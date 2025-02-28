<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String ctxPath = request.getContextPath();
//     /myspring

%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../../header/header.jsp" />

<style>
* {
	font-family: "Noto Sans KR", sans-serif;
	font-optical-sizing: auto;
	margin: 0px;
	padding: 0px;
}

*::after {
	margin: 0px;
	padding: 0px;
}

*::before {
	margin: 0px;
	padding: 0px;
}

:root {
	--size2: clamp(2px, 0.1042vw, 200px);
	--size8: clamp(6px, 0.4167vw, 200px);
	--size12: clamp(10px, 0.6250vw, 200px);
	--size14: clamp(12px, 0.7292vw, 200px);
	--size15: clamp(14px, 0.7813vw, 200px);
	--size16: clamp(16px, 0.8333vw, 200px);
	--size18: clamp(17px, 0.9375vw, 200px);
	--size20: clamp(18px, 1.0417vw, 200px);
	--size24: clamp(24px, 1.2500vw, 200px);
	--size30: clamp(28px, 1.5625vw, 200px);
	--size32: clamp(30px, 1.6667vw, 200px);
	--size40: clamp(36px, 2.0833vw, 200px);
	--size52: clamp(48px, 2.7083vw, 200px);
	--size60: clamp(50px, 3.1250vw, 200px);
	--size65: clamp(60px, 3.3854vw, 200px);
	--size98: clamp(80px, 5.1042vw, 2000px);
	--size100: clamp(80px, 5.2083vw, 2000px);
	--size120: clamp(100px, 6.2500vw, 2000px);
	--size200: clamp(200px, 10.4167vw, 2000px);
	--size300: clamp(300px, 15.6250vw, 2000px);
	--size400: clamp(380px, 20.8333vw, 2000px);
	--size500: clamp(500px, 26.0417vw, 2000px);
	--size670: clamp(650px, 34.8958vw, 2000px);
	--size700: clamp(680px, 36.4583vw, 3000px);
	--size930: clamp(900px, 48.4375vw, 10000px);
	--whiteColor: #fff;
	--baseColor1: #F9FAFB;
	--baseColor2: #f1f2f3;
	--pointColor: #2985DB;
	--keyColor: #21255b;
	--darkBgColor: #0C1929;
	--darkBaseColor: #141C30;
}

.dateController {
	width: 100%;
	margin: auto;
}

.dateTopBar {
	display: flex;
	gap: var(--size16);
	align-items: center;
	justify-content: space-between;
	padding: 0px var(--size24);
	margin-bottom: var(--size30);
}

.dateTopBtn {
	display: flex;
	gap: var(--size16);
	align-items: center;
	justify-content: center;
}

#today {
	font-size: var(--size24);
	font-weight: 500;
}

#now {
	box-sizing: border-box;
	padding: calc(var(--size2)+ var(--size2)) calc(var(--size2)+ var(--size2));
	margin-top: calc(var(--size2)+ var(--size2));
	font-size: var(--size12);
}

#now:hover {
	background-color: #eee;
}

.calendar_container {
	position: relative;
}

table {
	border-collapse: collapse;
	font-size: var(--size14);
	border: 1px solid #ddd;
	width: 100%;
	table-layout: fixed;
	border-collapse: collapse;
	border-spacing: 0;
}

table tr th, .info {
	height: var(--size30);
	font-weight: normal;
	text-align: center;
}

.info {
	vertical-align: middle;
	overflow: hidden;
	text-align: center;
	border-left: 0;
}

.info span {
	display: block;
	color: #333;
	text-align: left;
	margin: 2px 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	max-width: 100%;
	cursor: pointer;
	font-size: 13px;
}

table td {
	position: relative;
	z-index: 1;
}

div.hoverDiv:hover {
	cursor: pointer;
}

/*   table td:hover {
    	background-color: yellow;
    	cursor: pointer;
    } */
.openDiv {
	display: block;
}

.closeDiv {
	display: none;
}





</style>

<script>
    $(document).ready(() => {
    	
        // ====================== 날짜 리모컨 기능 생성 ====================== //
        const currentDate = new Date(); 
        const currentDate_year = currentDate.getFullYear();
        const currentDate_month = String(currentDate.getMonth()+1).padStart(2, '0');  
        
        
        let today = new Date(currentDate_year,currentDate_month-1,1);
        
        
        // 이전 버튼 클릭 시
        $('#prev').click(() => {
        	today.setMonth(today.getMonth() - 1);
            week_div(today);
            
        });

        // 다음 버튼 클릭 시
        $('#next').click(() => {
        	today.setMonth(today.getMonth() + 1);
            week_div(today);
        });

        // 오늘 버튼 클릭 시
        $('#now').click(() => {
        	today = new Date(currentDate); // 저장된 currentDate 날짜로 복구
            week_div(today);
        });

       
        // 페이지 로드 시 현재 날짜 및 테이표시
        week_div(today);
        // ====================== 날짜 리모컨 기능 생성 ====================== //
 
        $('div.oneday').hide();
        
     	
     	// 주차 버튼 클릭시 열림
     	$(document).on('click', 'div.weekBig',e=>{
     	
     		if($(e.target).next().css('display') == 'none') {
     			$(e.target).parent().parent().find("div.weekbro").css({"display":"none"});
     			$(e.target).next().css({"display":""});
     			$(e.target).parent().parent().find("div.daybro").css({"display":"none"});
	 		}
	 		else {
	 			$(e.target).parent().parent().find("div.weekbro").css({"display":"none"});
	 		}
	 		
     	});
     	
     	
     	// 일자 버튼 클릭시 열림
     	$(document).on('click', 'div.dayBig',e=>{
     		
     		if($(e.target).next().css('display') == 'none') {
     			$(e.target).next().css({"display":""});
     			
	 		}
	 		else {
	 			$(e.target).next().css({"display":"none"});
	 		}
    	
     	});
        
     	
     	// 출퇴근표시 div 반응형
     	$(window).on('resize', function(){
     		
     		getHistory(today);

     	});
     	
     	
     	getWorktime();
     	
    	$("div.week"+today_week()).trigger("click");
    	
    	$("div.day"+today_day()).trigger("click");
    	
     	
    	
    	
    	
    }); // end of $(document).ready(() => {})-------------

    function today_week() {
			
    	const now = new Date();
    	
    	const currentDate = now.getDate();
    	
    	const firstDay = new Date(now.setDate(1)).getDay();
    	
    	return Math.ceil((currentDate + firstDay) / 7);
    
    }
    
    function today_day() {
		
    	const now = new Date();
    	const day = String(now.getDate()).padStart(2, '0');	
    	
    	return day;
    
    }
    
   
    function week_div(today) {

    	const year = today.getFullYear();
    	let month = String(today.getMonth()+1).padStart(2, '0');  		// 오늘(선택일)의 월
    	
    	const day = String(today.getDate()).padStart(2, '0');			// 오늘(선택일)의 일
    	const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];		//
    	const dayOfWeek = daysOfWeek[today.getDay()]; 					// 오늘(선택일)의 요일
 
    	const start = new Date(year, month-1, 1);
    	const end = new Date(year, month, 0);
    	
    	const end_day = Number(String(end.getDate()));

    	const timeString = `\${year}-\${month}`;
    	
    	
        $('#today').text(timeString);
    	
 
    	let weekNo = 1;
    	
    	let html = `<div style="padding:10px;"> `; // 전체 div 시작
    	
    
    	let today_week = 1;
    	
    	for(let i=1; i<=end_day; i++) {
    		
    		let i_day = i;
    		
    		if(i == end_day) {
    			month++;
    			i_day = 0;
    			
    		}
    		
    		
    		
    		const i_today = new Date(year,month-1, i_day);

    		const i_month = String(i_today.getMonth()+1).padStart(2, '0'); 
    		const i_date = String(i_today.getDate()).padStart(2, '0');
    		
    		const i_dayOfWeek = daysOfWeek[i_today.getDay()]; 
    	
    		
    		if(i == 1 || i_dayOfWeek == '월') {
    			html += `<div>
    						<div class="weekBig hoverDiv week\${weekNo}" style="width:100px; font-size:14pt;">\${weekNo} 주차</div>
    						<div class="weekbro" style="display:none;">`;			// 주차 적는 div
    						
    		}
    		
    		
    		html += `<div class="dayBig hoverDiv day\${i_date}" style="width:200px;">&nbsp;&nbsp;&nbsp;\${i_month}월 \${i_date}일 (\${i_dayOfWeek})</div>		
 
    				<div class="daybro" style="display:none; padding:0 10px;">													
    		    		<table class="\${i_date}" style="box-sizing: border-box; border-collapse:collapse;">			
    		    			<thead>`;															
    					
    		for(let j=0; j<24; j++) {
    	        		
    	    	let hour = j;
    	    			
    	    	if(hour < 10 ) {
    	    		hour = `0\${j}`;
    	    	}
    	    	
    	        html += `<th colspan="6" style="text-align:left; font-size:8pt;">\${hour}</th>`;										// th 
    		} ///
    			
    		html += `</thead>`;																	// 헤더 끝
    		
    		/* tbody */

    		html += `<tbody>`;																// 바디 시작
    					
        	for(let k=0; k<144; k++) {
        		
        		html += `<td style="height:30px;" class="\${k}"></td>`;	// td
        		
        	}
        	
        	html += `</tbody></table></div>`; 																			// 테이블 감싸는 div 끝
				
    		if(i_dayOfWeek == '일') {
    			html += `</div></div>`;														// 주차 감싸는 div 끝
    			weekNo++;   
    		}
    	
    	}
    
    	html += `</div>`; // 전체 div 끝
    	
    	$("div#weeklyDisplay").html(html);
    	
    	getHistory(today);
    	
    } //// week_div(today) 
    	
    	
    function getHistory(today) {
    	
    	const year = today.getFullYear();
    	let month = String(today.getMonth()+1).padStart(2, '0');  		// 오늘(선택일)의 월
    	
    	const day = String(today.getDate()).padStart(2, '0');			// 오늘(선택일)의 일
    	const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];		//
    	const dayOfWeek = daysOfWeek[today.getDay()]; 					// 오늘(선택일)의 요일
 
    	const start = new Date(year, month-1, 1);
    	const end = new Date(year, month, 0);
    	
    	const end_day = Number(String(end.getDate()));

    	const timeString = `\${year}-\${month}`;
    	
    	

    	const tableWidth = $('.dateController').width() - 40;
   // 	alert(tableWidth);
    	
    	$.ajax({
    		url:"<%=ctxPath%>/commute/getMontWorkInfo",
			type:"get",
			data:{"fk_employeeNo":"${sessionScope.loginuser.employeeNo}"
				 ,"selectMonth":start.getFullYear()+"-"+String(start.getMonth()+1).padStart(2, '0')+"-01"},
			dataType:"json",
			success:function(json) {
				
				
				$.each(json, (index,item)=>{

					const selectDay = item.startTime.substring(8, 10); 
					
					const starthour = (item.startTime).substring(11, 13); 
					const startmin = (item.startTime).substring(14, 16); 
					
					const endhour = (item.endTime).substring(11, 13); 
					const endmin = (item.endTime).substring(14, 16); 
																				                 //		   |00시 	   |01시 					
					const startCell = Number(starthour) * 6 + Math.ceil(Number(startmin)/10); // 01:19 라면 |1|2|3|4|5|6|7|@@@@@@@@@@@@@        => 8
					const endCell = Number(endhour) * 6 + Math.floor(Number(endmin)/10);   // 18:41 라면 @@@@@@@@@@@@@|@@@@@@@@@@@@@|@@@@@@@@@@@@|113|114|115|  => 112
					                  
					const totalCellCnt = endCell - startCell +1;                                              
				
					let v_html = ``;
					
					for(let k=0; k<144; k++) {
						
		        		
						if(k == startCell && totalCellCnt > 0) {
							
							
							
							v_html += `<td colspan="\${totalCellCnt}" style="height:20px; border: solid 0px;">
											<div title="출근시간 : \${starthour}:\${startmin}\n퇴근시간 : \${endhour}:\${endmin}" style="width: 100%%; height: 100%;background-color: #99ccff; margin:0 auto; z-index:100; border-radius:50px; text-align:center; color:white; font-size:10pt; line-height:20px;">업무</div>
										</td>`;	// td
							
							k = k + totalCellCnt - 1;
							
						}
						else {
							
							if( k % 6 == 0 ) {
								v_html += `<td style="height:20px; border: solid #e6e6e6; border-width: 0px 0px 0px 1px"></td>`;
							}
							else if( k % 6 == 5 ) {
								v_html += `<td style="height:20px; border: solid #e6e6e6; border-width: 0px 1px 0px 0px"></td>`;
							}
							else {
								v_html += `<td style="height:20px; border: solid #e6e6e6 0px"></td>`;
							}
							
						}
		        		
		        	}
					
					$("table."+selectDay+" tbody").html(v_html);
					
				});
				
			},
			error: function(request, status, error){
		        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
    		
    	});
    	
    	
    } // func
    

    function getWorktime() {
    	
    	const now = new Date();
    	
    	const year_month = String(now.getFullYear()) + String(now.getMonth()+1).padStart(2, '0');
    	
    	$.ajax({
			url:"<%= ctxPath%>/commute/getWorktime",
			type:"get",
			data:{"fk_employeeNo":"${sessionScope.loginuser.employeeNo}"
				 ,"year_month":year_month},
			dataType:"json",
			success:function(json) {
    	
				let total_sec = 0;
				let monthOvertime_sec = 0;
				
				$.each(json, (index,item)=>{
					
					const worktime_sec = Number(item.worktime_sec)+1;
					
					const weekWorktime = secToHour(worktime_sec);

					const todayWeekNo = String(new Date().getWeek()).padStart(2, '0');
				
					const plusMinus = worktime_sec - (40 * 60 * 60);
					
					if( plusMinus > 0 ) {
						monthOvertime_sec = monthOvertime_sec + plusMinus;
					}
					
					if(item.weekNo == todayWeekNo ) {
						
						$("div#thisWeekWorktime").html(weekWorktime);
						
						
						if( plusMinus > 0 ) {
							$("div#thisWeekWorktime_plus").html(secToHour(plusMinus));
						}
						else {
							$("div#thisWeekWorktime_minus").html(secToHour(plusMinus * (-1) ));
						}
						
					}
					
					total_sec = total_sec + worktime_sec;
					
				});

				const monthWorktime = secToHour(total_sec);
				$("div#thisMonthWorktime").html(monthWorktime);
				
				const monthOvertime = secToHour(monthOvertime_sec);
				$("div#thisMonthOvertime").html(monthOvertime);
					
			},
			error: function(request, status, error){
		        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
		});
 
    	
    	
    	
    }
    
    Date.prototype.getWeek = function (dowOffset) {
    	  /*getWeek() was developed by Nick Baicoianu at MeanFreePath: http://www.meanfreepath.com */

    	  dowOffset = typeof(dowOffset) == 'number' ? dowOffset : 0; // dowOffset이 숫자면 넣고 아니면 0
    	  var newYear = new Date(this.getFullYear(),0,1);
    	  var day = newYear.getDay() - dowOffset; //the day of week the year begins on
    	  day = (day >= 0 ? day : day + 7);
    	  var daynum = Math.floor((this.getTime() - newYear.getTime() -
    	    (this.getTimezoneOffset()-newYear.getTimezoneOffset())*60000)/86400000) + 1;
    	  var weeknum;
    	  //if the year starts before the middle of a week
    	  if(day < 4) {
    	    weeknum = Math.floor((daynum+day-1)/7) + 1;
    	    if(weeknum > 52) {
    	      let nYear = new Date(this.getFullYear() + 1,0,1);
    	      let nday = nYear.getDay() - dowOffset;
    	      nday = nday >= 0 ? nday : nday + 7;
    	      /*if the next year starts before the middle of
    	        the week, it is week #1 of that year*/
    	      weeknum = nday < 4 ? 1 : 53;
    	    }
    	  }
    	  else {
    	    weeknum = Math.floor((daynum+day-1)/7);
    	  }
    	  return weeknum;
    	};
    	
    	
    	
	function secToHour(total_sec) {

		const hour = Math.floor( total_sec / 60 / 60 ) ;
		const s_hour = String(hour).padStart(2, '0');
		
		const min = Math.floor( ( total_sec / 60 / 60 - hour ) * 60);
		const s_min = String(min).padStart(2, '0');
		
		const sec = Math.floor( ( ( ( total_sec / 60 / 60 ) - hour ) * 60 - min ) * 60 );
		const s_sec = String(sec).padStart(2, '0');	
			
		
		const worktime = s_hour + "h " + s_min + "m " + s_sec +"s";
		
		return worktime;
	}
    
    function hourToSec(hour, min, sec) {
    	
    	return Number(hour) * 60 * 60 + Number(min) * 60 + Number(sec);
    }
    
    
    
    function downloadExcel() {
    	
		const frm = document.downloadExcelForm;
			
		const year_month = $('#today').html();
		
		frm.year_month.value = year_month;
		frm.fk_employeeNo.value = '${sessionScope.loginuser.employeeNo}';
		
		
		console.log(frm.fk_employeeNo.value);
		
		frm.method = "post";
		frm.action = "<%=ctxPath%>/commute/downloadExcel";
		frm.submit();
		
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
</script>

<div style="display: flex;">

	<div style="width: var(--size250);; height: 100vh; border-right: solid 1px #000; flex-shrink: 0;">

		<jsp:include page="../../common/commute_btn.jsp" />

	</div>

	<div style="width: 100%; padding: 20px;">
	
		<div class="ml-1 mr-1 mb-5">
			
			<div style="font-size:14pt;">내 근태현황</div>
			
		</div>
	
		<div class="dateController">
			<div class="dateTopBar">

				<div class="dateTopBtn" style="width: 200px; margin: 0 auto;">
					<span id="prev" style="cursor: pointer;">&#60;</span>
					<!-- 이전날짜 버튼 -->
					<div id="today" style="text-align: center;">today</div>
					<!-- 날짜 표기 -->
					<span id="next" style="cursor: pointer;">&#62;</span>
					<!-- 다음날짜 버튼 -->

					<span id="now" style="cursor: pointer;">오늘</span>
				</div>

			</div>

		</div>

		<div id="summary" class="mb-3">
		
			<div class="mb-1" style="display:flex" >
				<div style="margin:0 auto 0 0;">
					<span class="h5 ml-1">월간/주간 요약</span>
				</div>
				<div style="margin:0 0 0 auto;">
					<button type="button" class="btn btn-outline-secondary btn-sm mr-1" id="overtime" name="overtime" onclick="">연장근무신청</button>
					<button type="button" class="btn btn-outline-secondary btn-sm " id="download" name="download" onclick="downloadExcel()">엑셀다운로드</button>
				</div>
			</div>
			
			<div class="border border-secondary ml-1" style="border-radius:3px;" >
				<div style="display:flex; height:100px; align-items: center;">
					<div style="margin:0 auto; width:150px; text-align: center;">
						<div>이번주 누적</div>
						<div id="thisWeekWorktime" style="color: #2985DB; font-size: 20px;">00:00:00</div>
					</div>
					
					<div style="margin:0 auto; width:150px; text-align: center;">
						<div>이번주 초과</div>
						<div id="thisWeekWorktime_plus" style="color: #2985DB; font-size: 20px;">00:00:00</div>
					</div>
					
					<div style="margin:0 auto; width:150px; text-align: center;">
						<div>이번주 잔여</div>
						<div id="thisWeekWorktime_minus" style="color: #2985DB; font-size: 20px;">00:00:00</div>
					</div>
					
					<div style="height:100px; width:3px; ">
						<span style="background-color:#e5e5e5; width: 1px; height: 60px; display:inline-block; margin:20px 1px;"></span>
					</div>
					
					<div style="margin:0 auto; width:150px; text-align: center;">
						<div style="color: #999;">이번달 누적</div>
						<div id="thisMonthWorktime" style="color: #999; font-size: 20px;">00:00:00</div>
					</div>
					
					<div style="margin:0 auto; width:150px; text-align: center;">
						<div style="color: #999;">이번달 연장</div>
						<div id="thisMonthOvertime" style="color: #999; font-size: 20px;">00:00:00</div>
					</div>
					
					<div style="margin:0 auto; width:150px; text-align: center;">
						<div></div>
						<div></div>
					</div>
				</div>
			</div>
		
		</div>

		<div id=weeklyDisplay></div>


		<div></div>
	</div>

</div>

<form name="downloadExcelForm">
	<input type="hidden" name="year_month" value="">
	<input type="hidden" name="fk_employeeNo" value="">
</form>

<jsp:include page="../../footer/footer.jsp" />
