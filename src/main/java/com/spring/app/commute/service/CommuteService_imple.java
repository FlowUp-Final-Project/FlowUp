package com.spring.app.commute.service;

import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.app.commute.domain.AnnualVO;
import com.spring.app.commute.domain.CommuteVO;
import com.spring.app.commute.model.CommuteDAO;
import com.spring.app.employee.domain.DepartmentVO;
import com.spring.app.employee.domain.EmployeeVO;

@Service
public class CommuteService_imple implements CommuteService {
	
	@Autowired
	private CommuteDAO dao;

	// 오늘자 근태조회
	@Override
	public CommuteVO getTodayWorkInfo(String fk_employeeNo) {
		CommuteVO cvo = dao.getTodayWorkInfo(fk_employeeNo);
		return cvo;
	}

	// 오늘자 출근 insert
	@Override
	public int insertWorkStart(String fk_employeeNo) {
		int n = dao.insertWorkStart(fk_employeeNo);
		return n;
	}

	// 오늘자 출근 시간 입력 update
	@Override
	public int updateStartTime(String fk_employeeNo) {
		int n = dao.updateStartTime(fk_employeeNo);
		return n;
	}
	
	// 오늘자 퇴근 시간 입력 update
	@Override
	public int updateEndTime(String fk_employeeNo) {
		int n = dao.updateEndTime(fk_employeeNo);
		return n;
	}

	// status update
	@Override
	public int statusChange(Map<String, String> paramap) {
		int n = dao.statusChange(paramap);
		return n;
	}

	// 이번주 근무시간 조회하는 메소드 select
	@Override
	public List<Map<String, String>> getThisWeekWorkTime(String fk_employeeNo) {
		List<Map<String, String>> mapList = dao.getThisWeekWorkTime(fk_employeeNo);
		return mapList;
	}

	@Override
	public List<DepartmentVO> getDepInfo() {
		List<DepartmentVO> dvoList = dao.getDepInfo();
		return dvoList;
	}

	@Override
	public List<Map<String, String>> getMontWorkInfo(Map<String, String> paramap) {
		List<Map<String, String>> mapList = dao.getMontWorkInfo(paramap);
		return mapList;
	}

	@Override
	public List<Map<String, String>> getWorktime(Map<String, String> paramap) {
		List<Map<String, String>> mapList = dao.getWorktime(paramap);
		return mapList;
	}

	@Override
	public void commuteList_to_Excel(Map<String, String> paraMap, Model model) {
		// 엑셀 시트 생성하기
		SXSSFWorkbook workbook = new SXSSFWorkbook();

		SXSSFSheet sheet = workbook.createSheet(paraMap.get("year_month") + " 근태 조회");

		// 시트 열 너비 설정
		sheet.setColumnWidth(0, 4000);
		sheet.setColumnWidth(1, 4000);
		sheet.setColumnWidth(2, 4000);
		sheet.setColumnWidth(3, 4000);
		sheet.setColumnWidth(4, 3000);
		sheet.setColumnWidth(5, 3000);
		sheet.setColumnWidth(6, 3000);
		sheet.setColumnWidth(7, 5000);

		////////////////////////////////////////////////////////////////////////////////////////

		

		CellStyle headerStyle = workbook.createCellStyle(); 
		headerStyle.setAlignment(HorizontalAlignment.CENTER); 
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND); 
		headerStyle.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex()); 

		headerStyle.setBorderTop(BorderStyle.THIN); // 테두리 위 두껍게
		headerStyle.setBorderBottom(BorderStyle.DOUBLE); // 테두리 아래 두껍게
		headerStyle.setBorderLeft(BorderStyle.THIN); // 테두리 왼쪽 얇게
		headerStyle.setBorderRight(BorderStyle.THIN); // 테두리 오른쪽 얇게
		
		CellStyle mergeRowStyle = workbook.createCellStyle(); 
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER); 
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER); 
		mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND); 
		mergeRowStyle.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex()); 
		
		mergeRowStyle.setBorderTop(BorderStyle.THIN); // 테두리 위 두껍게
		mergeRowStyle.setBorderLeft(BorderStyle.THIN); // 테두리 왼쪽 얇게
		mergeRowStyle.setBorderRight(BorderStyle.THIN); // 테두리 오른쪽 얇게
		mergeRowStyle.setBorderBottom(BorderStyle.THIN);
		
		CellStyle detaleStyle = workbook.createCellStyle(); 
		detaleStyle.setAlignment(HorizontalAlignment.CENTER); 
		detaleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		detaleStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND); 
		detaleStyle.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex()); 
		
		detaleStyle.setBorderBottom(BorderStyle.DOUBLE); // 테두리 아래 두껍게
		detaleStyle.setBorderLeft(BorderStyle.THIN); // 테두리 왼쪽 얇게
		detaleStyle.setBorderRight(BorderStyle.THIN); // 테두리 오른쪽 얇게
		
		CellStyle moneyStyle = workbook.createCellStyle(); 
		moneyStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));

		Font headerRowFont = workbook.createFont(); // 폰트 스타일 생성 import org.apache.poi.ss.usermodel.Font; 으로 한다.
		headerRowFont.setFontName("나눔고딕"); // 폰트 나눔고딕체
		headerRowFont.setBold(true); // 굵은 글자
		
		headerStyle.setFont(headerRowFont);
		mergeRowStyle.setFont(headerRowFont);
		
		
		CellStyle title_infoStyle = workbook.createCellStyle(); 
		title_infoStyle.setAlignment(HorizontalAlignment.CENTER); 
		title_infoStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		title_infoStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND); 
		title_infoStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		
		title_infoStyle.setBorderTop(BorderStyle.THIN); // 테두리 위 두껍게
		title_infoStyle.setBorderLeft(BorderStyle.THIN); // 테두리 왼쪽 얇게
		title_infoStyle.setBorderRight(BorderStyle.THIN); // 테두리 오른쪽 얇게
		title_infoStyle.setBorderBottom(BorderStyle.THIN);
		
		
		
		
		
		CellStyle infoStyle = workbook.createCellStyle(); 
		infoStyle.setAlignment(HorizontalAlignment.CENTER); 
		infoStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		infoStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND); 
		infoStyle.setFillForegroundColor(IndexedColors.WHITE.getIndex());
		
		infoStyle.setBorderTop(BorderStyle.THIN); // 테두리 위 두껍게
		infoStyle.setBorderLeft(BorderStyle.THIN); // 테두리 왼쪽 얇게
		infoStyle.setBorderRight(BorderStyle.THIN); // 테두리 오른쪽 얇게
		infoStyle.setBorderBottom(BorderStyle.THIN);
		
		
		// 행의 위치를 나타내는 변수
		int rowLocation = 0;
		
		Row tltle_header_1 = sheet.createRow(rowLocation);
		
		Cell tltle_header_A1 = tltle_header_1.createCell(0);
		tltle_header_A1.setCellStyle(headerStyle);
		tltle_header_A1.setCellValue(paraMap.get("year_month"));
		
		Cell tltle_header_B1 = tltle_header_1.createCell(1);
		tltle_header_B1.setCellStyle(headerStyle);
		tltle_header_B1.setCellValue("총 근무시간");
		
		Cell tltle_header_C1 = tltle_header_1.createCell(2);
		tltle_header_C1.setCellStyle(headerStyle);
		tltle_header_C1.setCellValue("연장 근무시간");
		
		rowLocation++; // 1
		
		Row tltle_header_2 = sheet.createRow(rowLocation); 
		
		Cell tltle_header_A2 = tltle_header_2.createCell(0);
		tltle_header_A2.setCellStyle(title_infoStyle);
		tltle_header_A2.setCellValue(paraMap.get("positionName") + " " + paraMap.get("name"));
		
		Cell tltle_header_B2 = tltle_header_2.createCell(1);
		tltle_header_B2.setCellStyle(title_infoStyle);
		
		Cell tltle_header_C2 = tltle_header_2.createCell(2);
		tltle_header_C2.setCellStyle(title_infoStyle);
		
		
		
		
		
		rowLocation++; // 2 (빈 행)
		
		rowLocation++; // 3
		
		Row headerRow_1 = sheet.createRow(rowLocation); 
		
		Cell headerCell_1 = headerRow_1.createCell(0);
		headerCell_1.setCellValue("일자");
		headerCell_1.setCellStyle(headerStyle);

		headerCell_1 = headerRow_1.createCell(1);
		headerCell_1.setCellValue("업무시작");
		headerCell_1.setCellStyle(headerStyle);

		headerCell_1 = headerRow_1.createCell(2);
		headerCell_1.setCellValue("업무종료");
		headerCell_1.setCellStyle(headerStyle);

		headerCell_1 = headerRow_1.createCell(3);
		headerCell_1.setCellValue("총 근무시간");
		headerCell_1.setCellStyle(headerStyle);

		headerCell_1 = headerRow_1.createCell(4);
		headerCell_1.setCellValue("근무시간 상세");
		headerCell_1.setCellStyle(mergeRowStyle);

		headerCell_1 = headerRow_1.createCell(5);
		headerCell_1.setCellValue("근무시간 상세");
		headerCell_1.setCellStyle(mergeRowStyle);

		headerCell_1 = headerRow_1.createCell(6);
		headerCell_1.setCellValue("근무시간 상세");
		headerCell_1.setCellStyle(mergeRowStyle);

		headerCell_1 = headerRow_1.createCell(7);
		headerCell_1.setCellValue("비고");
		headerCell_1.setCellStyle(headerStyle);

		sheet.addMergedRegion(new CellRangeAddress(3, 3, 4, 6)); // 시작 행, 끝 행, 시작 열, 끝 열
		
		rowLocation++; // 4
		
		Row headerRow_2 = sheet.createRow(rowLocation); 
		
		Cell headerCell_2 = headerRow_2.createCell(0);
		headerCell_2.setCellStyle(headerStyle);
		headerCell_2.setCellValue("일자");

		headerCell_2 = headerRow_2.createCell(1);
		headerCell_2.setCellStyle(headerStyle);
		headerCell_2.setCellValue("업무시작");

		headerCell_2 = headerRow_2.createCell(2);
		headerCell_2.setCellStyle(headerStyle);
		headerCell_2.setCellValue("업무종료");

		headerCell_2 = headerRow_2.createCell(3);
		headerCell_2.setCellStyle(headerStyle);
		headerCell_2.setCellValue("총 근무시간");

		headerCell_2 = headerRow_2.createCell(4);
		headerCell_2.setCellValue("기본");
		headerCell_2.setCellStyle(detaleStyle);

		headerCell_2 = headerRow_2.createCell(5);
		headerCell_2.setCellValue("연장");
		headerCell_2.setCellStyle(detaleStyle);

		headerCell_2 = headerRow_2.createCell(6);
		headerCell_2.setCellValue("야간");
		headerCell_2.setCellStyle(detaleStyle);

		headerCell_2 = headerRow_2.createCell(7);
		headerCell_2.setCellStyle(headerStyle);
		
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 0, 0)); 
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 1, 1)); 
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 2, 2)); 
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 3, 3)); 
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 7, 7)); 
		
		///////////////////////////////////////////////////////////////////////////

		Row bodyRow = null;
		Cell bodyCell = null;

		List<Map<String, String>> month_commuteList = dao.getMontWorkInfo_allday(paraMap);

		int worksec_day = 0;
		int worksec_week = 0;
		int worksec_month = 0;
		int overtime_month = 0;
		
		for( Map<String, String> dailyCommute : month_commuteList) {
			
			rowLocation++;
			
			bodyRow = sheet.createRow(rowLocation); 
			
			bodyCell = bodyRow.createCell(0);
			bodyCell.setCellValue(dailyCommute.get("dt"));
			bodyCell.setCellStyle(infoStyle);
			
			bodyCell = bodyRow.createCell(1);
			bodyCell.setCellValue(dailyCommute.get("startTime"));
			bodyCell.setCellStyle(infoStyle);
			
			bodyCell = bodyRow.createCell(2);
			bodyCell.setCellValue(dailyCommute.get("endTime"));
			bodyCell.setCellStyle(infoStyle);
			
			bodyCell = bodyRow.createCell(3);
			bodyCell.setCellValue(secToHour(Integer.parseInt(dailyCommute.get("worksec"))));
			bodyCell.setCellStyle(infoStyle);
		
			
			if(Integer.parseInt(dailyCommute.get("worksec")) > 8*60*60) {
				bodyCell = bodyRow.createCell(4);
				bodyCell.setCellValue("08:00:00");
				bodyCell.setCellStyle(infoStyle);
				
				bodyCell = bodyRow.createCell(5);
				bodyCell.setCellValue(secToHour(Integer.parseInt(dailyCommute.get("worksec")) - 8*60*60));
				bodyCell.setCellStyle(infoStyle);
			}
			else {
				bodyCell = bodyRow.createCell(4);
				bodyCell.setCellValue(secToHour(Integer.parseInt(dailyCommute.get("worksec"))));
				bodyCell.setCellStyle(infoStyle);
				
				bodyCell = bodyRow.createCell(5);
				bodyCell.setCellValue("00:00:00");
				bodyCell.setCellStyle(infoStyle);
			}

			bodyCell = bodyRow.createCell(6);
			bodyCell.setCellValue("00:00:00");
			bodyCell.setCellStyle(infoStyle);
			
			if(dailyCommute.get("rest") == "0") {
				bodyCell = bodyRow.createCell(7);
				bodyCell.setCellValue("-");
				bodyCell.setCellStyle(infoStyle);
			}
			else if(dailyCommute.get("rest") == "1") {
				bodyCell = bodyRow.createCell(7);
				bodyCell.setCellValue("연차 사용");
				bodyCell.setCellStyle(infoStyle);
			}
			else if(dailyCommute.get("rest") == "2") {
				bodyCell = bodyRow.createCell(7);
				bodyCell.setCellValue("오전 반차 사용");
				bodyCell.setCellStyle(infoStyle);
			}
			else if(dailyCommute.get("rest") == "3") {
				bodyCell = bodyRow.createCell(7);
				bodyCell.setCellValue("오후 반차 사용");
				bodyCell.setCellStyle(infoStyle);
			}
			else {
				bodyCell = bodyRow.createCell(7);
				bodyCell.setCellValue("-");
				bodyCell.setCellStyle(infoStyle);
			}
			
			
			
			
			
			worksec_day = Integer.parseInt(dailyCommute.get("worksec"));
			
			worksec_week = worksec_week + worksec_day;
			worksec_month = worksec_month + worksec_day;
			
		    DayOfWeek date = LocalDate.parse(dailyCommute.get("dt")).getDayOfWeek();
		    
		    switch (date) {
		    
			case SUNDAY: 
				
				rowLocation++; // 5 
				bodyRow = sheet.createRow(rowLocation); 
			
				bodyCell = bodyRow.createCell(0);
				bodyCell.setCellValue("주간 근무시간");
				bodyCell.setCellStyle(title_infoStyle);
				
				bodyCell = bodyRow.createCell(1);
				bodyCell.setCellValue(secToHour(worksec_week));
				bodyCell.setCellStyle(title_infoStyle);
				
				bodyCell = bodyRow.createCell(2);
				bodyCell.setCellValue("연장 근무시간");
				bodyCell.setCellStyle(title_infoStyle);
				
				bodyCell = bodyRow.createCell(3);
				if(worksec_week > (40 * 60 * 60)) {
					
					int overtime_week = worksec_week - (40 * 60 * 60);
					
					overtime_month = overtime_month + overtime_week;
					
					bodyCell.setCellValue(secToHour(overtime_week)); // 주간 연장근무시간
				}
				else {
					bodyCell.setCellValue("00:00:00");
				}
				bodyCell.setCellStyle(title_infoStyle);
				
				bodyCell = bodyRow.createCell(4);
				bodyCell.setCellValue("");
				bodyCell.setCellStyle(title_infoStyle);
					
				bodyCell = bodyRow.createCell(5);
				bodyCell.setCellValue("");
				bodyCell.setCellStyle(title_infoStyle);
				
				bodyCell = bodyRow.createCell(6);
				bodyCell.setCellValue("");
				bodyCell.setCellStyle(title_infoStyle);
				
				bodyCell = bodyRow.createCell(7);
				bodyCell.setCellValue("");
				bodyCell.setCellStyle(title_infoStyle);
		
				sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 4, 6)); 
				
				worksec_week = 0;
				
		    }// switch

		    
		    
		} // for

		rowLocation++; // 5
		bodyRow = sheet.createRow(rowLocation);

		bodyCell = bodyRow.createCell(0);
		bodyCell.setCellValue("주간 근무시간");
		bodyCell.setCellStyle(title_infoStyle);

		bodyCell = bodyRow.createCell(1);
		bodyCell.setCellValue(secToHour(worksec_week));
		bodyCell.setCellStyle(title_infoStyle);

		bodyCell = bodyRow.createCell(2);
		bodyCell.setCellValue("연장 근무시간");
		bodyCell.setCellStyle(title_infoStyle);

		bodyCell = bodyRow.createCell(3);
		if (worksec_week > (40 * 60 * 60)) {

			int overtime_week = worksec_week - (40 * 60 * 60);

			overtime_month = overtime_month + overtime_week;

			bodyCell.setCellValue(secToHour(overtime_week)); // 주간 연장근무시간
		} else {
			bodyCell.setCellValue("00:00:00");
		}
		bodyCell.setCellStyle(title_infoStyle);

		bodyCell = bodyRow.createCell(4);
		bodyCell.setCellValue("");
		bodyCell.setCellStyle(title_infoStyle);

		bodyCell = bodyRow.createCell(5);
		bodyCell.setCellValue("");
		bodyCell.setCellStyle(title_infoStyle);

		bodyCell = bodyRow.createCell(6);
		bodyCell.setCellValue("");
		bodyCell.setCellStyle(title_infoStyle);

		bodyCell = bodyRow.createCell(7);
		bodyCell.setCellValue("");
		bodyCell.setCellStyle(title_infoStyle);

		sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 4, 6));

		tltle_header_B2.setCellValue(secToHour(worksec_month)); // 월간 총 근무시간

		tltle_header_C2.setCellValue(secToHour(overtime_month)); // 월간 연장 근무 시간

		model.addAttribute("locale", Locale.KOREA);
		model.addAttribute("workbook", workbook);
		model.addAttribute("workbookName", "근태정보");

	}

	

	
	
	
	// 초를 시분초로 바꾸는 메소드
	private String secToHour(int total_sec) {
		
		int hour = total_sec / 3600;
		int min = (total_sec % 3600) / 60;
		int sec = total_sec % 60;
		
		String s_hour = "";
		String s_min = "";
		String s_sec = "";
		
		if(hour < 10) {
			s_hour = "0"+hour;
		}
		else {
			s_hour = ""+hour;
		}
		
		if(min < 10) {
			s_min = "0"+min;
		}
		else {
			s_min = ""+min;
		}
		
		if(sec < 10) {
			s_sec = "0"+sec;
		}
		else {
			s_sec = ""+sec;
		}
		
		return s_hour + ":" + s_min + ":" + s_sec;
	}

	@Override
	public Map<String,String> getEmployeeInfo(String fk_employeeNo) {
		Map<String,String> map = dao.getEmployeeInfo(fk_employeeNo);
		return map;
	}

	@Override
	public AnnualVO getAnnualInfo(Map<String, String> paramap) {
		
		AnnualVO avo = dao.getAnnualInfo(paramap);
		
		avo.setUsedAnnual(dao.getUsedAnnual(paramap));
		
		
		return avo;
	}

	
	@Override
	public List<Map<String, String>> getUsedAnnualList(Map<String, String> paraMap) {
		List<Map<String, String>> mapList = dao.getUsedAnnualList(paraMap);
		return mapList;
	}

	@Override
	public List<String> getWorkYear(String fk_employeeNo) {
		List<String> yearList = dao.getWorkYear(fk_employeeNo);
		return yearList;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
