package com.spring.app.commute.domain;

import java.text.DecimalFormat;

public class AnnualVO {

	private String annualNo;		// 연차 고유번호
	private String fk_employeeNo;	// 사번
	private String year;			// 적용 연도
	private String occurAnnual;		// 발생 연차
	private String overAnnual;		// 이월 연차
	private String addAnnual;		// 조정 연차
	private String usedAnnual;     	// 소진 연차
	
	
	private String totalAnnual;		// 총 연차
	private String remainderAnnual;	// 잔여 연차
	
	
	
	public String getTotalAnnual() {
		
		DecimalFormat df = new DecimalFormat("###.#");
		
		double n_occurAnnual = Double.parseDouble(occurAnnual);
		double n_overAnnual = Double.parseDouble(overAnnual);
		double n_addAnnual = Double.parseDouble(addAnnual);
		double n_totalAnnual = n_occurAnnual + n_overAnnual + n_addAnnual;
		
		totalAnnual = df.format(n_totalAnnual);
		
		return totalAnnual;
	}

	public String getRemainderAnnual() {
		
		DecimalFormat df = new DecimalFormat("###.#");
		
		double n_totalAnnual = Double.parseDouble(getTotalAnnual());
		double n_usedAnnual = Double.parseDouble(usedAnnual);
		double n_remainderAnnual = n_totalAnnual - n_usedAnnual;
		
		remainderAnnual = df.format(n_remainderAnnual);
		
		return remainderAnnual;
	}
	
	
	
	

	public String getFk_employeeNo() {
		return fk_employeeNo;
	}
	public void setFk_employeeNo(String fk_employeeNo) {
		this.fk_employeeNo = fk_employeeNo;
	}
	public String getYear() {
		return year;
	}
	public String getAnnualNo() {
		return annualNo;
	}
	public void setAnnualNo(String annualNo) {
		this.annualNo = annualNo;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getOccurAnnual() {
		return occurAnnual;
	}
	public void setOccurAnnual(String occurAnnual) {
		this.occurAnnual = occurAnnual;
	}
	public String getOverAnnual() {
		return overAnnual;
	}
	public void setOverAnnual(String overAnnual) {
		this.overAnnual = overAnnual;
	}
	public String getAddAnnual() {
		return addAnnual;
	}
	public void setAddAnnual(String addAnnual) {
		this.addAnnual = addAnnual;
	}
	public String getUsedAnnual() {
		return usedAnnual;
	}
	public void setUsedAnnual(String usedAnnual) {
		this.usedAnnual = usedAnnual;
	}

	
	
	
	
	
	
}
