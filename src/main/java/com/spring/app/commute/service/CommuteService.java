package com.spring.app.commute.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.spring.app.commute.domain.AnnualVO;
import com.spring.app.commute.domain.CommuteVO;
import com.spring.app.employee.domain.DepartmentVO;
import com.spring.app.employee.domain.EmployeeVO;

public interface CommuteService {
	
	// 오늘자 근태 조회 select
	CommuteVO getTodayWorkInfo(String fk_employeeNo);

	// 오늘자 출근 insert
	int insertWorkStart(String fk_employeeNo);

	// 오늘자 출근 시간 입력 update
	int updateStartTime(String fk_employeeNo);

	// 오늘자 퇴근 시간 입력 update
	int updateEndTime(String fk_employeeNo);

	// status update
	int statusChange(Map<String, String> paramap);

	// 이번주 근무시간 조회하는 메소드 select
	List<Map<String, String>> getThisWeekWorkTime(String fk_employeeNo);

	// 모든 부서정보 조회 select 
	List<DepartmentVO> getDepInfo();

	// 1달치 
	List<Map<String, String>> getMontWorkInfo(Map<String, String> paramap);

	// 서머리에 출력될 주간 근무시간 가져오기
	List<Map<String, String>> getWorktime(Map<String, String> paramap);

	// 한 사원의 근태 정보를 가져오며 엑셀을 다운받는 form을 생성 하는 메소드
	void commuteList_to_Excel(Map<String, String> paraMap, Model model);

	// 사원번호로 그 사원의 정보를 가져오는 메소드
	Map<String,String> getEmployeeInfo(String fk_employeeNo);

	// 사원번호를 받아 그 사원의 연차정보를 가져오는 메소드
	AnnualVO getAnnualInfo(Map<String, String> paramap);

	// 특정 사원 및 특정 연도(map)의 연차사용 내역을 가져오는 메소드
	List<Map<String, String>> getUsedAnnualList(Map<String, String> paraMap);

	// 근속했던 년도를 가져오는 메소드
	List<String> getWorkYear(String fk_employeeNo);



	
	
	
}
