package com.spring.app.commute.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.commute.domain.CommuteVO;
import com.spring.app.employee.domain.DepartmentVO;

@Mapper
public interface CommuteDAO {

	// 오늘자 근태 조회 select
	CommuteVO getTodayWorkInfo(String fk_employeeNo);

	// 오늘자 출근 insert
	int insertWorkStart(String fk_employeeNo);

	// 오늘자 출근 시간 입력 update
	int updateStartTime(String fk_employeeNo);

	// 오늘자 퇴근 시간 입력 update
	int updateEndTime(String fk_employeeNo);

	int statusChange(Map<String, String> paramap);

	List<Map<String, String>> getThisWeekWorkTime(String fk_employeeNo);

	List<DepartmentVO> getDepInfo();

	List<Map<String, String>> getMontWorkInfo(Map<String, String> paramap);

	List<Map<String, String>> getWorktime(Map<String, String> paramap);

	List<Map<String, String>> getMontWorkInfo_allday(Map<String, String> paraMap);



}
