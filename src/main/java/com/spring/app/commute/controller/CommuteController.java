package com.spring.app.commute.controller;


import java.lang.reflect.Array;
import java.security.PublicKey;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.commute.domain.AnnualVO;
import com.spring.app.commute.domain.CommuteVO;
import com.spring.app.commute.service.CommuteService;
import com.spring.app.employee.domain.DepartmentVO;
import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.employee.domain.PositionVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;

@Controller
@RequestMapping(value="/commute/*")
public class CommuteController {
	
	@Autowired
	private CommuteService service;

	@GetMapping("")
	public ModelAndView commute(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		

		HttpSession session = request.getSession();

		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		if (loginuser == null) {

			mav.setViewName("mycontent/employee/login");

		}
		else {
		
			mav.setViewName("mycontent/commute/commute");
			
		}
		
		return mav;
	}
	
	@GetMapping("getDeptname")
	@ResponseBody
	public List<DepartmentVO> getDeptname() {
		
		List<DepartmentVO> dvoList = service.getDepInfo(); // 모든 부서 리스트 조회
		
		return dvoList;
	}
	
	
	
	
	
	
	
	// 오늘자 근태 조회
	@GetMapping("getTodayWorkInfo")
	@ResponseBody
	public Map<String, Object> getTodayWorkInfo(HttpServletRequest request, HttpServletResponse response, @RequestParam String fk_employeeNo) {
	
		Map<String, Object> map = new HashMap<>();
		
		int n = 0; // 0:아직 출근 안했거나 연차,반차(출근버튼 활성화)  1:출근했다(출근버튼 비활성화) 2:퇴근했다(퇴근버튼 비활성화). 
		
		// 금일자 출근정보 조회하기
		CommuteVO cvo = service.getTodayWorkInfo(fk_employeeNo);
		
		
		if(cvo == null) {
			n = 0;
			map.put("startTime", "-");
			map.put("endTime", "-");
			map.put("status", "0");
			map.put("overTimeYN","0");
			map.put("rest","0");
			
		}
		else {
			
			if("-".equals(cvo.getStartTime())) { // 오늘자 출근기록이 없는 경우
				n = 0;
			}
			else {	// 오늘자 출근기록이 있는 경우
				
				
				if("-".equals(cvo.getEndTime())) { // 오늘자 퇴근기록이 없는 경우
					n = 1;
				}
				else {
					n = 2;
				}
				
				map.put("startTime", cvo.getStartTime());
				map.put("endTime", cvo.getEndTime());
				map.put("status", cvo.getStatus());
				map.put("overTimeYN",cvo.getOverTimeYN());
				map.put("rest",cvo.getRest());
				
			}
			
		}
		
		// 주간 근무시간 구하기
		int n_workTime_sec = 0;
		int workTime_hour = 0;
		int workTime_min = 0;
		int workTime_sec = 0;

		List<Map<String, String>> mapList = service.getThisWeekWorkTime(fk_employeeNo);

		for (Map<String, String> ThisWeekWorkTimeMap : mapList) {

			String workTime = ThisWeekWorkTimeMap.get("workTime");

			double n_workTime_day = Double.parseDouble(workTime); // 1 = 1일

			n_workTime_sec += (int) (n_workTime_day * 24 * 60 * 60);
			
		}

		workTime_hour = (n_workTime_sec / 60 / 60);

		workTime_min = (n_workTime_sec / 60 - workTime_hour * 60);

		workTime_sec = (n_workTime_sec - workTime_hour * 60 * 60 - workTime_min * 60);
		
		map.put("n", n);
		map.put("workTime_hour", workTime_hour);
		map.put("workTime_min", workTime_min);
		map.put("workTime_sec", workTime_sec);

		return map;
	}
	
	// 출근 클릭시
	@PostMapping("workStart")
	@ResponseBody
	public Map<String, Object> workStart(HttpServletRequest request, HttpServletResponse response, @RequestParam String fk_employeeNo) {
		
		System.out.println("출근 클릭 ~ ");
		
		int n = 0; // 0:에러, 1:성공
		
		// 금일자 출근정보가 있는지 조회
		CommuteVO cvo = service.getTodayWorkInfo(fk_employeeNo);
		
		System.out.println("출근 클릭 ~ DB ~ cvo : " + cvo);
		
		
		
		if(cvo == null) { // 근태 기록이 없다면
			n = service.insertWorkStart(fk_employeeNo); // 새로운 근태 기록 insert
		}
		else { // 오늘자 근태 행이 이미 있다면 (연차, 반차 등으로 이미 insert 해준 경우)

			if (cvo.getStartTime() == null) { // 퇴근기록이 없고 출근 시간이 null 이라면
				n = service.updateStartTime(fk_employeeNo); // 출근시간 업데이트
			}
			
		}
	
		Map<String, Object> map = new HashMap<>();
		map.put("n", n);
		
		
		return map;
	}
	
	// 퇴근 클릭시
	@PostMapping("workEnd")
	@ResponseBody
	public Map<String, Object> workEnd(HttpServletRequest request, HttpServletResponse response, @RequestParam String fk_employeeNo) {

		System.out.println("퇴근 클릭 ~ ");
		
		int n = 0; // 0:에러, 1:성공,

		// 금일자 출근정보가 있는지 조회
		CommuteVO cvo = service.getTodayWorkInfo(fk_employeeNo);

		System.out.println("퇴근 클릭 ~ DB ~ cvo : " + cvo);
		
		if (!"-".equals(cvo.getStartTime())) { // 출근 기록이 있다면
			n = service.updateEndTime(fk_employeeNo); // 퇴근시간 업데이트
		}
		
		System.out.println("퇴근 클릭 ~ n : " + n);
		
		Map<String, Object> map = new HashMap<>();
		map.put("n", n);

		return map;
	}
	
	@PostMapping("statusChange")
	@ResponseBody
	public Map<String, Integer> statusChange(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> paramap) {
		
		int n = 0;
		
		if(!"0".equals(paramap.get("status"))) {
			n = service.statusChange(paramap);
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map;
	}
	
	@GetMapping("getMontWorkInfo")
	@ResponseBody
	public List<Map<String, String>> getMontWorkInfo(@RequestParam Map<String, String> paramap) {
		
		List<Map<String, String>> mapList = service.getMontWorkInfo(paramap);
		
		return mapList;
	}
	
	
	@GetMapping("getWorktime")
	@ResponseBody
	public List<Map<String, String>> getWorktime(@RequestParam Map<String, String> paramap) {
		
		List<Map<String, String>> mapList = service.getWorktime(paramap);
		
		return mapList;
	}
	
	
	@PostMapping("downloadExcel")
	public String downloadExcelFile(@RequestParam(defaultValue = "") String year_month, @RequestParam(defaultValue = "") String fk_employeeNo, Model model) {

		if(fk_employeeNo != null || year_month != null ) {
			
			
			Map<String,String> map = service.getEmployeeInfo(fk_employeeNo);
			
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("positionName", map.get("positionName"));
			paraMap.put("name", map.get("name"));
			paraMap.put("fk_employeeNo", fk_employeeNo);
			paraMap.put("year_month", year_month);
			
			service.commuteList_to_Excel(paraMap, model);
			
			return "excelDownloadView"; // "excelDownloadView"은 ViewConfiguration의 19번째줄 메소드 이름이다..
		}
		else {
			return "mycontent/commute/commute";
		}
	}
		
		
	@GetMapping("myAnnual")
	public ModelAndView myAnnual(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();

		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		if (loginuser == null) {
			mav.setViewName("mycontent/employee/login");
		}
		else {
			LocalDate now = LocalDate.now();
			int n_year = now.getYear();
			String year = ""+n_year;
			
			String fk_employeeNo = loginuser.getEmployeeNo();
			
			
			Map<String,String> map = service.getEmployeeInfo(fk_employeeNo);
			
			Map<String, String> paramap = new HashMap<>();
			paramap.put("year", year);
			paramap.put("fk_employeeNo", fk_employeeNo);
			
			AnnualVO avo = service.getAnnualInfo(paramap);
			
			mav.addObject("map", map);
			mav.addObject("avo", avo);
			mav.setViewName("mycontent/commute/myAnnual");
			
		}
		
		return mav;
	}
		
		
		
	@GetMapping("getUsedAnnualList")
	@ResponseBody
	public List<Map<String, String>> getUsedAnnualList(@RequestParam Map<String, String> paraMap) {
		
		List<Map<String, String>> mapList = service.getUsedAnnualList(paraMap);
		
		return mapList;
	}
		
		
	@GetMapping("getWorkYear")
	@ResponseBody
	public List<String> getWorkYear(@RequestParam(defaultValue = "") String fk_employeeNo) {
		
		System.out.println("확인용 fk_employeeNo : "+fk_employeeNo);
		
		List<String> yearList = service.getWorkYear(fk_employeeNo);
		
		return yearList;
	}
		
	
	@GetMapping("commuteTable")
	public ModelAndView commuteTable(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String departmentNo = request.getParameter("departmentNo");

		
	
		mav.addObject("departmentNo", departmentNo);
		mav.setViewName("mycontent/commute/commuteTable");
			

		
		return mav;
	}
	
	
	
	
	
	
	
	
	@GetMapping("commuteChart")
	public ModelAndView commuteChart(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String departmentNo = request.getParameter("departmentNo");

		
	
		mav.addObject("departmentNo", departmentNo);
		mav.setViewName("mycontent/commute/commuteChart");
			

		
		return mav;
	}
	
	
	
	
	
	
	
	
	@GetMapping("annualInfo")
	public ModelAndView annualInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		
		
		mav.setViewName("mycontent/commute/annualInfo");
			

		
		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
