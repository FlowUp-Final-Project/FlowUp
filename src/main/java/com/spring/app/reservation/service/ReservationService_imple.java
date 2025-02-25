package com.spring.app.reservation.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.reservation.domain.AssetReservationVO;
import com.spring.app.reservation.domain.AssetVO;
import com.spring.app.reservation.model.ReservationDAO;

//=== 서비스 선언 === //
//트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class ReservationService_imple implements ReservationService {

	@Autowired
	private ReservationDAO dao;

	
	// 자산 대분류를 select 해주는 메소드
	@Override
	public List<Map<String, String>> tbl_assetSelect() {
		List<Map<String, String>> assetList = dao.tbl_assetSelect();
		
		return assetList;
	}
	
	
	
	// 자산 대분류를 insert 해주는 메소드
	@Override
	public int reservationAdd(Map<String, String> paraMap) {
		int n = dao.reservationAdd(paraMap);
		return n;
	}



	// 자산 상세를 select 해주는 메소드
	@Override
	public List<Map<String, String>> tbl_assetDetailSelect() {
		List<Map<String, String>> assetDetailList = dao.tbl_assetDetailSelect();
		return assetDetailList;
	}



	// 내 예약 정보를 select 해주는 메소드
	@Override
	public List<Map<String, String>> my_Reservation(String employeeNo) {
		List<Map<String, String>> my_ReservationList = dao.my_Reservation(employeeNo);
		return my_ReservationList;
	}


	// 대분류를 삭제하는 메소드
	@Override
	public int deleteAsset(String assetNo) {
		int n = dao.deleteAsset(assetNo);
		return n;
	}


	// 자산 하나에 해당하는 대분류 정보를 select 해주는 메소드
	@Override
	public AssetVO assetOneSelect(String assetNo) {
		AssetVO assetvo = dao.assetOneSelect(assetNo);
		return assetvo;
	}


	// 대분류 하나에 해당하는 자산 정보를 select 해주는 메소드
	@Override
	public List<Map<String, String>> middleTapInfo(String assetNo) {
		List<Map<String, String>> middleTapInfoList = dao.middleTapInfo(assetNo);
		return middleTapInfoList;
	}


	// 비품명을 추가해주는 메소드
	@Override
	public int addFixtures(Map<String, Object> paraMap) {
		
		
        String[] arr_AssetDetailNo = (String[]) paraMap.get("arr_AssetDetailNo");
        String[] arr_InformationTitle = (String[]) paraMap.get("arr_InformationTitle");
        String[] arr_InformationContents = (String[]) paraMap.get("arr_InformationContents");
        String fk_assetNo = (String) paraMap.get("fk_assetNo");

        int result = 0;

        for (int i = 0; i < arr_AssetDetailNo.length; i++) {
            for (int j = 0; j < arr_InformationTitle.length; j++) {
                // 데이터 삽입
                Map<String, Object> insertMap = new HashMap<>();
                insertMap.put("assetDetailNo", arr_AssetDetailNo[i]);
                insertMap.put("fk_assetNo", fk_assetNo);
                insertMap.put("InformationTitle", arr_InformationTitle[j]);
                insertMap.put("InformationContents", arr_InformationContents[j]);

                // DAO 호출
                result += dao.addFixtures(insertMap);
            }
        }

        // 모든 삽입 작업이 성공적으로 끝나면 1 반환
        return result;
    }
	



	// 대분류에 딸린 소분류들을 select 해주는 메소드
	@Override
	public List<Map<String, String>> assetOneDeSelect(String assetNo) {
		List<Map<String, String>> OneDeList = dao.assetOneDeSelect(assetNo);
		return OneDeList;
	}



	// 자산추가를 해주는 메소드
	@Override
	public int addAsset(Map<String, String> paraMap) {
		int result = dao.addAsset(paraMap);
		return result;
	}


	// 해당 페이지 내의 일자 구간 예약정보 불러오기
	@Override
	public List<AssetReservationVO> selectassetReservationThis(AssetReservationVO assetreservationvo) {
		List<AssetReservationVO> reservationvoList = dao.selectassetReservationThis(assetreservationvo);
		return reservationvoList;
	}


	
	
}
