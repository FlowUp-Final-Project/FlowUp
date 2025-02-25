<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@include file="./reservationLeftBar.jsp" %>
 

 
<%-- 각자 페이지에 해당되는 css 연결 --%>
<link href="<%=ctxPath%>/css/reservation/reservation_main.css" rel="stylesheet"> 
<link href="<%=ctxPath%>/css/reservation/reservation_Deone.css" rel="stylesheet"> 

<%-- 각자 페이지에 해당되는 js 연결 --%>
<script src="<%=ctxPath%>/js/reservation/reservation.js"></script>

	
	<!-- 오른쪽 바 -->
    <div id="right_bar">
        <div id="right_title_box">
            <span id="right_title">${requestScope.assetName}</span>
        </div>
		<span><input type="text" name="reservationStart" />~<input type="text" name="reservationEnd" /></span>
		<div class="dateController">
			
			<div class="dateTopBar">
				<div></div>
				
				<div class="dateTopBtn">
			        <span id="prev" style="cursor: pointer; margin:auto;">&#60;</span>   <!-- 이전날짜 버튼 -->
			        <div id="today" style="text-align: center;">2025.02.23 ~ 2025.03.01</div> <!-- 날짜 표기 -->
			        <span id="next" style="cursor: pointer; margin:auto;">&#62;</span>   <!-- 다음날짜 버튼 -->
			
			        <span id="now" style="cursor: pointer;">이번주</span>
				</div>
				
				<div></div>
			</div>
			<div id="calendar"></div>
			<table class="week_table_back_form">
				<thead>
					<tr class="weekTitle">
		                
						
						
		                <!-- 주말은 제외 -->
		                <!-- 주말은 제외 -->
						
						
					</tr>
	            </thead>
				
				<tbody class="week_table_back_td">
					
					<!-- 9시부터 21시 30분까지 예약 가능 -->
					<!-- 9시부터 21시 30분까지 예약 가능 -->
					
				</tbody>
			</table>
			
			
			<div id="assetModalBg" class="modal_bg">
								
			</div>
			<div id="assetModal" class="modal_containerAsset" style="padding:24px;">
				<div class="assetModalTitle" >예약</div>
				<div class="assetModal_body">
					<input type="text" value="${requestScope.assetDetailNo}" name="fk_assetDetailNo" />
					<input type="text" value="${sessionScope.loginuser.employeeNo}" name="fk_employeeNo" />
					<div>
						<label>예약일</label><span><input type="text" name="reservationStart" size="4" /> ~ <input type="text" name="reservationEnd" size="4" /></span>
					</div>
					<div>
						<label>예약자</label><span>${sessionScope.loginuser.name}</span>
					</div>
					<div>
						<label>목적</label><span><input type="text" name="reservationContents" /></span>
					</div>
				</div>
				<div id="goReservation">확인</div>
			</div>
			
			
		
    	</div>
	</div>
    <!-- 오른쪽 바 -->

<script type="text/javascript">
	// ====================== 날짜 리모컨 기능 생성 ====================== //
	let today = new Date(); // 현재 날짜 저장
	let currentDate = new Date(); // 오늘을 저장하는 변수
	let currentDateBg = new Date(); // 오늘과 날이 같다면 배경색을 바꾸기 위한 저장 변수

	// 이전 버튼 클릭 시
	$('#prev').click(() => {
	    // 이전 주의 월요일로 설정
	    today.setDate(today.getDate() - 7); // 오늘에서 7일을 빼서 이전 주 월요일로 이동
	    updateDate();
	});

	// 다음 버튼 클릭 시
	$('#next').click(() => {
	    // 현재 날짜 기준으로 1주일 후 월요일로 설정
	    today.setDate(today.getDate() + 7); // 오늘에서 7일을 더해서 다음 주 월요일로 이동
	    updateDate();
	});

	// 오늘 버튼 클릭 시
	$('#now').click(() => {
	    today = new Date(currentDate); // 저장된 currentDate 날짜로 복구
	    updateDate();
	});

	// 날짜 업데이트 함수
	function updateDate() {
	    const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
	    
	    // 주간 시작일과 종료일 계산
	    const startOfWeek = new Date(today);
	    const endOfWeek = new Date(today);

	    // 현재 날짜가 속한 주의 월요일 (startOfWeek)
	    const dayOfWeekIndex = today.getDay();
	    const diffToMonday = (dayOfWeekIndex === 0) ? -6 : 1 - dayOfWeekIndex; // 일요일은 -6일, 나머지는 월요일까지의 차이
	    startOfWeek.setDate(today.getDate() + diffToMonday);

	    // 주간 종료일은 월요일 기준으로 4일 후인 금요일로 설정
	    endOfWeek.setDate(startOfWeek.getDate() + 4);  // 월요일에서 4일 후가 금요일

	    // 주간 날짜를 출력하기 위해 날짜 배열 생성
	    const weekDates = [];
		const weekDates1 = []; // endDate 위해서 만듬..
		const weekDatesTarget = []; // 이건 밑에서 뿌려주기 위해 생성
		
	    for (let i = 0; i < 5; i++) {
	        const currentDay = new Date(startOfWeek);
	        currentDay.setDate(startOfWeek.getDate() + i); // 월요일부터 금요일까지
	        const formattedDate = `\${String(currentDay.getMonth() + 1).padStart(2, '0')}.\${String(currentDay.getDate()).padStart(2, '0')}(\${daysOfWeek[currentDay.getDay()]})`;
			
			const formattedDate1 = `\${String(currentDay.getMonth() + 1).padStart(2, '0')}.\${String(currentDay.getDate()).padStart(2, '0')}`;
			
			const formattedDateTarget = `\${String(currentDay.getFullYear())}.\${String(currentDay.getMonth() + 1).padStart(2, '0')}.\${String(currentDay.getDate()).padStart(2, '0')}`;
	        weekDates.push(formattedDate);
			weekDates1.push(formattedDate1);
			
			weekDatesTarget.push(formattedDateTarget);          
	    }
		// 날짜 포맷팅
		const startYear = startOfWeek.getFullYear();
		const startMonth = String(startOfWeek.getMonth() + 1).padStart(2, '0');
		const startDay = String(startOfWeek.getDate()).padStart(2, '0');

		// 마지막 날짜는 weekDates 배열에서 가져오기
		const endDate = weekDates1[weekDates1.length - 1]; // 마지막 날짜
		const endDateParts = endDate.split('.');  // 날짜를 '.'으로 나눠서 배열로 저장
		const endMonth = endDateParts[0];  // 월
		const endDay = endDateParts[1];    // 일

		// 주간 범위 (start ~ end) -> 요일은 포함되지 않음
		const weekRange = `\${startYear}.\${startMonth}.\${startDay} ~ \${startYear}.\${endMonth}.\${endDay}`;

		$('#today').text(weekRange); // 주간 날짜 범위 업데이트

		
		
		
		/////////////////////////////////////////////////////// 주간 캘린더 나타내기
	    // 주간 날짜를 HTML에 반영
	    $('.weekTitle').empty(); // 이전 달력 내용 삭제

	    // v_html로 주간 날짜 내용 작성
	    let v_html = ``;
	    v_html += `<th style="width: 60px;"></th>`; // 첫 번째 칸은 여백

	    weekDates.forEach(date => {
	        v_html += `<th>\${date}</th>`; // 날짜를 th 태그로 출력
	    });
		///////////////////////////////////////////////////////
		$('.week_table_back_td').empty();
		
		
		
		/////////////////////////////////////////////////////// 주간 캘린더 내부 나타내기
		let v_html2 = ``;
		v_html2 += `<tr id="weekWrap">
						<th class="time_wrap">
							<div class="time">09</div>
							<div class="time">10</div>
							<div class="time">11</div>
							<div class="time">12</div>
							<div class="time">13</div>
							<div class="time">14</div>
							<div class="time">15</div>
							<div class="time">16</div>
							<div class="time">17</div>
							<div class="time">18</div>
							<div class="time">19</div>
							<div class="time">20</div>
							<div class="time">21</div>
						</th>`;
		
						
		let targetCnt = 0;
		const dataValue = `\${String(currentDateBg.getMonth() + 1).padStart(2, '0')}.\${String(currentDateBg.getDate()).padStart(2, '0')}(\${daysOfWeek[currentDateBg.getDay()]})`;
		
		weekDates.forEach(date => {
			targetCnt++;
			
			if(date == dataValue){ // 만약 오늘 날자랑 td가 같으면 배경색을 #eee로 지정해주기 위해 .todayBg 생성
				v_html2 +=  `<td class="dateBar todayBg" data-value="\${date}" >`
			}
			else {
				v_html2 +=  `<td class="dateBar" data-value="\${date}" >`
			}
			v_html2 +=		`<div class="schedule_wrap">`;
								
								for(let i=0; i<26; i++) {
				                    let timeStr = (9 + i/2);
										
									    if (isInteger(timeStr)) { 
									        v_html2 += `<div class="table_cell" style="height: 60px;">
															<div class="box"><input class="clickTime" type="hidden" value="\${weekDatesTarget[targetCnt-1]+ ' '+timeStr+':00'}"/></div>`;
									    } else {
									        v_html2 += `	<div class="box"><input class="clickTime" type="hidden" value="\${weekDatesTarget[targetCnt-1]+ ' '+parseInt(timeStr, 10)+':30'}"/></div>
														</div>`;
									    }
				                } // end of for------------
								
			v_html2 +=		`</div>
						</td>`;
						
		
	    }); // end of weekDates.forEach(date => {})--------------------
		
		
		
		v_html2 += `</tr>`;
		
	    // HTML에 추가
	    $('.weekTitle').append(v_html);
		$('.week_table_back_td').append(v_html2);
	}
	///////////////////////////////////////////////////////

	// 페이지 로드 시 현재 날짜와 주간 캘린더 표시
	updateDate();
	// ====================== 날짜 리모컨 기능 생성 ====================== //




	// === 정수 체크 함수 === //
	function isInteger(number) {
	    return !isNaN(number) && Number.isInteger(Number(number));
	}
    // === 정수 체크 함수 === //
	
	
	
	
	
	
	///////////////////////////////////////////////////////////
	let isMouseDown = false;
    let startIndex = -1;
    let endIndex = -1;

    // 마우스 클릭 시 시작 index 기억
	$(document).on('mousedown', '.box', e=>{
		isMouseDown = true;
        startIndex = getBoxIndex(e.target);
        endIndex = startIndex;
        highlightBoxes(); // 색상 업데이트
	})
	

    // 마우스 뗄 때
    $(document).mouseup(function() {
        if (isMouseDown) {
            isMouseDown = false;
            // 마우스 업 시 끝난 index 기록
            // startIndex가 항상 작은 값이 되도록 처리
            if (startIndex > endIndex) {
                [startIndex, endIndex] = [endIndex, startIndex];  // swap
            }
            // alert('Start: ' + $('input.clickTime').eq(startIndex).val() + ', End: ' + $('input.clickTime').eq(endIndex + 1).val());
			
            
            // ======= 모달창 on ======= //
			$('#assetModalBg').fadeIn();
			$('.modal_containerAsset').fadeIn();
			// ======= 모달창 on ======= //
			
			$('input[name="reservationStart"]').val($('input.clickTime').eq(startIndex).val());
			$('input[name="reservationEnd"]').val($('input.clickTime').eq(endIndex + 1).val())
			
            highlightBoxes();
        }
    });

    // 마우스가 움직일 때
    $(document).mousemove(function(e) {
        if (isMouseDown) {
            let targetIndex = getBoxIndex(e.target);
            if (targetIndex !== -1) {
                endIndex = targetIndex;
                highlightBoxes(); // 색상 업데이트
            }
        }
    });

    // 드래그된 범위의 색상 변경
    function highlightBoxes() {
        $('.box').each(function(index) {
            if (index >= Math.min(startIndex, endIndex) && index <= Math.max(startIndex, endIndex)) {
                $(this).addClass('highlight');
            } else {
                $(this).removeClass('highlight');
            }
        });
    }

    // target이 속한 div의 index 반환
    function getBoxIndex(target) {
        return $('.box').index(target);
    }
    
    
    
    
    // ======== 모달창 닫기 ======== //
    $('#assetModalBg:not(.modal_containerAsset)').click(e=>{
    	$('#assetModalBg').fadeOut();
    	$('.modal_containerAsset').fadeOut();
    })
    // ======== 모달창 닫기 ======== //
    
    
    
    
    $('#goReservation').click(e=>{
    	
    	
    	
    })
    
    
    
    
    
    
    // ======== 현재 페이지에서의 예약 정보 ======== //
    
    const todayArr = $('#today').text().split("\~");
    
    
    $.ajax({
    	url:"<%=ctxPath%>/reservation/selectassetReservationThis",
    	type:"post",
    	data:{"reservationStart":todayArr[0].trim(),
    		  "reservationEnd":todayArr[1].trim()},
    	dataType:"json",
    	success:function(json){
    		console.log(JSON.stringify(json));
    		/*
    			[{"assetReservationNo":"100010","fk_assetDetailNo":"100014","fk_employeeNo":"100012","reservationStart":"2025.02.25 12:00","reservationEnd":"2025.02.25 14:30","reservationDay":null,"reservationContents":"그냥~"}]
    		*/
    		
    		const boxArr = Array.from($('.box')); 
    		
    		$.each(json, function(index, item){
    			
    			$.each(boxArr, function(idx, elmt){
    				
					const startTimeOne = parseInt(((item.reservationStart).split(/\s+/g)[1]).split(':')[0]); // 12
					const endTimeOne = parseInt(((item.reservationEnd).split(/\s+/g)[1]).split(':')[0]);    // 14
					
					const startTimeTwo = parseInt(((item.reservationStart).split(/\s+/g)[1]).split(':')[1]); // 00
					const endTimeTwo = parseInt(((item.reservationEnd).split(/\s+/g)[1]).split(':')[1]);    // 30
					
					// 예약 시작시간과 끝시간의 차를 구해 30단위로 끊은 것의 개수 구하기
					const timeSum = ((endTimeOne * 60 + endTimeTwo) - (startTimeOne * 60 + startTimeTwo)) / 30;

    				
    				if(item.reservationStart == $(elmt).find('.clickTime').val()){
    					
    					$(elmt).html(`<div class="reservationBox" style="height: calc(\${timeSum} * 30px);" 
    									title="\${(item.reservationStart).split(/\s+/g)[1] +" ~ "+ (item.reservationEnd).split(/\s+/g)[1]}&#10;\${item.fk_employeeNo}&#10;\${item.reservationContents}">
    								  	<div class="reservationBoxTitle">예약정보</div>
    								  	<div class="reservationBoxContent">
    								  		<div>\${(item.reservationStart).split(/\s+/g)[1] +" ~ "+ (item.reservationEnd).split(/\s+/g)[1]}</div>
    								  		<div>\${item.fk_employeeNo}</div>
    								  		<div>\${item.reservationContents}</div>
    								  	<div>
    								  </div>`);
    				}
    				

    			}) // end of $.each(boxArr, function(idx, elmt){})--------------
    			
    		}) // end of $.each(json, function(index, item){})---------------
    		
    		
    		
    	},
	    error: function(request, status, error){
	 	    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    } 
    });
    
    
    // ======== 현재 페이지에서의 예약 정보 ======== //
    
    

</script>

<jsp:include page="../../footer/footer.jsp" /> 