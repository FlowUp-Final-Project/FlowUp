<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
   //     /myspring 
%>      

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="<%=ctxPath%>/js/util.js"></script>
   
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

	:root{
	    --size2  : clamp(2px, 0.1042vw, 200px);
	    --size8  : clamp(6px, 0.4167vw, 200px);
	    --size12 : clamp(10px, 0.6250vw, 200px);
	    --size14 : clamp(12px, 0.7292vw, 200px);
	    --size15 : clamp(14px, 0.7813vw, 200px);
	    --size16 : clamp(16px, 0.8333vw, 200px);
	    --size18 : clamp(17px, 0.9375vw, 200px);
	    --size20 : clamp(18px, 1.0417vw, 200px);
	    --size24 : clamp(24px, 1.2500vw, 200px);
	    
	    --size30 : clamp(28px, 1.5625vw, 200px);
	    --size32 : clamp(30px, 1.6667vw, 200px);
	    --size40 : clamp(36px, 2.0833vw, 200px);
	    --size52 : clamp(48px, 2.7083vw, 200px);
	    --size60 : clamp(50px, 3.1250vw, 200px);
	    --size65 : clamp(60px, 3.3854vw, 200px);
	
	    --size98  : clamp(80px, 5.1042vw, 2000px);
	    --size100 : clamp(80px, 5.2083vw, 2000px);
	    --size120 : clamp(100px, 6.2500vw, 2000px);
	    --size200 : clamp(200px, 10.4167vw, 2000px);
	    --size300 : clamp(300px, 15.6250vw, 2000px);
	    --size400 : clamp(380px, 20.8333vw, 2000px);
	    --size500 : clamp(500px, 26.0417vw, 2000px);
	    --size670 : clamp(650px, 34.8958vw, 2000px);
	    --size700 : clamp(680px, 36.4583vw, 3000px);
	    --size930 : clamp(900px, 48.4375vw, 10000px);
	
	    --whiteColor : #fff;
	    --baseColor1 : #F9FAFB;
	    --baseColor2 : #f1f2f3;
	    --pointColor : #2985DB;
	    --keyColor : #21255b;
	
	    --darkBgColor : #0C1929;
	    --darkBaseColor : #141C30;
	}
	
	#goToWork {
	    width: 100%;
	    height: auto;
	    background-color: var(--whiteColor);
	    border-radius: var(--size20);
	    box-sizing: border-box;
	    padding: var(--size16);
	    color: #000;
	}
	
	#goToWork > div {
	    position: relative;
	    width: 100%;
	    height: 100%;
	}
	
	#workTitle {
	    font-size: var(--size16);
	    margin-bottom: var(--size12);
	}
	
	#clock {
	    font-size: var(--size14);
	    color: var(--pointColor);
	    opacity: 0.9;
	}
	
	#gauge-title {
	    font-size: var(--size24);
	    line-height: var(--size40);
	}
	
	#gauge-title b {
	    font-size: var(--size16);
	    margin-left: var(--size2);
	    letter-spacing: 0;  
	}
	
	#gauge {
	    position: relative;
	    width: 100%;
	    height: var(--size12);
	    background-color: #eee;
	    border-radius: var(--size12);
	    overflow: hidden;
	}
	
	#gauge-percent {
	    /*width: calc(52 / 52 * 100%);*/
	    width: 0%;
	    height: 100%;
	    background-color: var(--keyColor);
	}
	
	#clock-contants > div:nth-child(2) {
	
	    width: 100%;
	    display: flex;
	    justify-content: space-between;
	}
	
	#clock-contants > div:nth-child(2) button {
	    display: inline-block;
	    width: 46%;
	    height: var(--size40);
	    line-height: var(--size40);
	    text-align: center;
	    color: var(--keyColor);
	    box-sizing: initial;
	    border: 1px solid var(--keyColor);
	    border-radius: var(--size8);
	    font-size: var(--size16);
	    transition: all 0.3s;
	}
	
	
	.hhover:hover {
		cursor: pointer;
		
	}
	
	
	#total-hour {
	    position: relative;
	    box-sizing: border-box;
	    padding: var(--size12) 0px;
	    margin-bottom: var(--size40);
	}
	
	#total-hour::before {
	    content: "";
	    position: absolute;
	    bottom: 0px;
	    left: 0px;
	    background-color: var(--pointColor);
	    width: 100%;
	    height: 0.5px;
	}
	
	#hour-gauge {
	    font-size: var(--size14);
	    color: var(--keyColor);
	}
	
	#hour-gauge > div:nth-child(1) {
	    margin-bottom: var(--size40);
	}
	
	#gauge-container {
	    position: relative;
	}
	
	.gauge-bar {
	    position: absolute;
	    top: 0px;
	    left: calc(40 / 52 * 100% - 20px);
	    width: var(--size2);
	    height: 100%;
	    background-color: red;
	}
	
	.max-time {
	    position: absolute;
	    right: 0px;
	    top: calc(-1 * var(--size20) );
	    color: #5a5a5a;
	}
	
	.min-time {
	    position: absolute;
	    top: var(--size20);
	    left: calc(40 / 52 * 100% - var(--size30) );
	}
	
	.hour-check {
	    display: flex;
	    justify-content: space-between;
	}
</style>


<script type="text/javascript">
	$(document).ready(()=>{
	
		
		
	    // ========== 시간을 알려주는 메소드 ========== //
	    function updateClock() {
	        const now = new Date();
	        const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
	        const dayOfWeek = daysOfWeek[now.getDay()];
	        const year = now.getFullYear();
	        const month = (now.getMonth() + 1).toString().padStart(2, '0');
	        const day = now.getDate().toString().padStart(2, '0');
	        const hours = now.getHours();
	        const minutes = now.getMinutes().toString().padStart(2, '0');
	        const seconds = now.getSeconds().toString().padStart(2, '0');
	        
	        let displayHours = hours;
	        
	        const timeString = `\${year}-\${month}-\${day} (\${dayOfWeek}) \${displayHours}:\${minutes}:\${seconds}`;
	        document.getElementById('clock').textContent = timeString;
	    }
	    
	    // 매 초마다 시계 업데이트
	    setInterval(updateClock, 1000);
	    
	    // 페이지 로드 시에도 시계 업데이트
	    updateClock();
	    // ========== 시간을 알려주는 메소드 ========== //
	    
	    // 금일 근태정보 조회 및 버튼 활성화/비활성화
	    getTodayWorkInfo();
	    
	    // 근무 상태 버튼 클릭시 열림
	    $('#btn_status').click(e=>{
	    	
	    	const btn_status = $(e.target).text();
	    	
	    	if(btn_status != '업무종료') {
	    		$('#btn_status_list').slideToggle();
	    	}
	    
	    });
	    
	 	// (내)근태 관리 버튼 클릭시 열림
	    $('#btn_myCommute').click(e=>{
	    	$('#btn_myCommute_list').slideToggle();
	    });
	 	
		// 부서 근태 관리 버튼 클릭시 열림
	    $('#btn_depCommute').click(e=>{
	    	$('#btn_depCommute_list').slideToggle();
	    });
		
	 // 부서 근태 관리 버튼 클릭시 열림
	    $('#btn_allCommute').click(e=>{
	    	$('#btn_allCommute_list').slideToggle();
	    });
	    
	    
		
	    // 근무상태 하위 탭 클릭시
	    $('#btn_status_list > li').click(e=>{
	    	
	    	const status = $(e.target).text();
	    	
	    	$('#btn_status').html(status);
	    	$('#btn_status_list').slideToggle();
	    	
	    	
	    	let n_status = "0" ;
	    	
	    	if(status == "내근") {
	    		n_status = "2"
	    	}
	    	else if(status == "외근") {
	    		n_status = "3"
	    	}
			else if(status == "파견") {
				n_status = "4" 		
			}
			else if(status == "출장") {
				n_status = "5"
			}
	    	
	    	$.ajax({
				url:"<%= ctxPath%>/commute/statusChange",
				type:"post",
				data:{"fk_employeeNo":"${sessionScope.loginuser.employeeNo}"
					, "status":n_status},
				dataType:"json",
				success:function(json) {
					
					
					
				},
				error: function(request, status, error){
		        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
	    	
	    	
	    });

	    
	    
	    // 출근 버튼 클릭시
	    $("#startWork").click(function(e) {
	    	
	    	$.ajax({
				url:"<%= ctxPath%>/commute/workStart",
				type:"post",
				async:false,
				data:{"fk_employeeNo":"${sessionScope.loginuser.employeeNo}"},
				dataType:"json",
				success:function(json) {

					if(json.n == 1) { // 정상 출근
						alert("출근처리 되었습니다.");
					} 
					else { // 에러
						alert("퇴근처리 실패");
					}
					
				},
				error: function(request, status, error){
		        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
	    	
	    	location.reload(true);
	    	
	    });
	    
	    // 퇴근 버튼 클릭시
	    $("#endWork").click(function(e) {
	    	
	    	if(confirm("정말로 퇴근하시겠습니까?")) {
	    		
	    		$.ajax({
					url:"<%= ctxPath%>/commute/workEnd",
					type:"post",
					async:false,
					data:{"fk_employeeNo":"${sessionScope.loginuser.employeeNo}"},
					dataType:"json",
					success:function(json) {

						if(json.n == 1) { // 정상 퇴근
							alert("퇴근처리 되었습니다.");
						}
						else {
							alert("퇴근처리 실패");
						}
						
					},
					error: function(request, status, error){
			        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
				});
	    		
	    		location.reload(true);
	    		
	    	} // confirm
	    });
	  
    
	    // 내 근태현황
	    $("#myCommuteTable").click(e=>{
	    	
	    	location.href="<%= ctxPath%>/commute/";
	    	
	    });
	    
	    // 내 연차내역
		$("#myAnnualInfo").click(e=>{
	    	
			location.href="<%= ctxPath%>/commute/myAnnual";
			
	    });
 		
		
		// 부서 근태현황
		$(document).on('click', "div.deptCommuteTable", e=>{
			
			const departmentNo = $(e.target).parent().find("input").val();

			location.href=`<%= ctxPath%>/commute/commuteTable?departmentNo=\${departmentNo}`;
			
		});
		
		// 부서 근태통계
		$(document).on('click', "div.deptCommuteChart", e=>{
			
			const departmentNo = $(e.target).parent().find("input").val();

			location.href=`<%= ctxPath%>/commute/commuteChart?departmentNo=\${departmentNo}`;
			
		});
		
		
		
	 	
	 	
		// 전사 근태현황
	 	$("#allCommuteTable").click(e=>{
	    	
	 		location.href=`<%= ctxPath%>/commute/commuteTable?departmentNo=all`;
		    	
		});
		
	 	// 전사 근태통계
	 	$("#allCommuteChart").click(e=>{
	 		
	 		location.href=`<%= ctxPath%>/commute/commuteChart?departmentNo=all`;
		    	
		});
	 	
	 // 전사 연차현황
	 	$("#allAnnualInfo").click(e=>{
	 		
	 		location.href=`<%= ctxPath%>/commute/annualInfo`;
		    	
		});
 		
 		
	 	getDeptname();
 		
 		
	}); // ready
	
	
	// 금일 근태정보 조회 및 버튼 활성화/비활성화 함수
	function getTodayWorkInfo() {
		
		$.ajax({
			url:"<%= ctxPath%>/commute/getTodayWorkInfo",
			type:"get",
			async:false,
			data:{"fk_employeeNo":"${sessionScope.loginuser.employeeNo}"},
			dataType:"json",
			success:function(json) {
				
				let todayStartTime;
				let todayEndTime;
				
				if(json.startTime != "-") {
					todayStartTime = (json.startTime).substring(11);
				}
				
				if(json.endTime != "-") {
					todayEndTime = (json.endTime).substring(11);
				}
				
				
				if(json.n == 0) { // 아직 출근안함 
					$("#startWork").attr("disabled", false);		// 출근버튼 활성화
					$("#startWork").addClass("btnHover");
					$("#endWork").attr("disabled", true);			// 퇴근버튼 비활성화
					$("#endWork").removeClass("btnHover");   
				}
				else if(json.n == 1) { // 이미 출근
					$("#startWork").attr("disabled", true).removeClass("btnHover"); // 출근버튼 비활성화
					$("#endWork").attr("disabled", false).addClass("btnHover");;  // 퇴근버튼 활성화	
				}
				else if(json.n == 2){ // 이미 퇴근
					$("#startWork").attr("disabled", true).removeClass("btnHover"); // 출근버튼 비활성화
					$("#endWork").attr("disabled", true).removeClass("btnHover");   // 퇴근버튼 비활성화	
					$('#btn_status').html("업무종료");
				}
				else { // 에러
					console.log("오늘자 근태정보 조회 해오는거 에러~~");
				}
				
				$("#todayStartTime").html(todayStartTime);
				$("#todayEndTime").html(todayEndTime);
				
				$("span#workTime_hour").html(json.workTime_hour);
				$("span#workTime_min").html(json.workTime_min);
				
				if(json.status == "1") {
					$('#btn_status').html("휴가");
				}
				else if(json.status == "2") {
					$('#btn_status').html("내근");
				}
				else if(json.status == "3") {
					$('#btn_status').html("외근");
				}
				else if(json.status == "4") {
					$('#btn_status').html("파견");
				}
				else if(json.status == "5") {
					$('#btn_status').html("출장");
				}
				else if(json.status == "6") {
					$('#btn_status').html("업무종료");
				}
				
				
				$("#gauge-percent").css({ 
					'width':`calc( ( \${json.workTime_hour} + \${json.workTime_min} / 60 ) / 52 * 100% )`
				});
				
				
			},
			error: function(request, status, error){
		        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
		});
		
	}// function getTodayWorkInfo()
	
	function getDeptname() {
		
		
		let html = ``;
		
		if(${sessionScope.loginuser.securityLevel == "10"}) {
			
			$.ajax({
				url:"<%= ctxPath%>/commute/getDeptname",
				type:"get",
				async:false,
				data:{"fk_employeeNo":"${sessionScope.loginuser.employeeNo}"},
				dataType:"json",
				success:function(json) {
					
					$.each(json, (index,item)=>{
						
						html += `<div style="margin-bottom:10px;">
			            			<div>&nbsp;&nbsp;&nbsp;\${item.departmentName}</div>
				            		<div class="deptCommuteTable hhover">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;부서 근태현황</div>
				            		<div class="deptCommuteChart hhover">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;부서 근태통계</div>
				            		<input type="hidden" value="\${item.departmentNo}" />
			            		</div>`;
						
					});
					
				},
				error: function(request, status, error){
			        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			});
		}
		else {
			
			html += `<div>
			        	<div>&nbsp;&nbsp;&nbsp;\${sessionScope.loginuser.departmentName}</div>
			        	<div class="deptCommuteTable hhover">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;부서 근태현황</div>
			        	<div class="deptCommuteChart hhover">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;부서 근태통계</div>
			        	<input type="hidden" value="" />
					</div>`;
		}
		
		
		
		$("div#btn_depCommute_list").html(html);
		
		
	}

	
	
	
	
	
</script>

<div id="goToWork">
     <div>
         <div id="workTitle">근태관리</div>
         <div id="clock">Loading...</div> 
         <!-- $('#clock').text(); 찍으면 현재 시간 나옵니다! ex) 2025-01-31 (금) 0:00:49 -->
        <!-- 출근, 퇴근 클릭시 해당 엘리먼트 이용하면 될듯 합니다! -->
        <div id="clock-contants">
            <div id="total-hour">
                <div id="hour-gauge">
                    <div>
                        <span id="gauge-title" title="주간 근무시간입니다."><span id="workTime_hour">00</span><b>h</b> <span id="workTime_min">00</span><b>m</b></span>
                        <div id="gauge-container">
                            <div id="gauge">
                                <div id="gauge-percent"></div> 
                                <!-- 주마다 시간을 모두 합산해 n/52 한 백분율 값을 gauge-percent의 width로 %를 주세요 -->
                                <!-- 현재는 임의로 30%를 지정했습니다. -->
                            </div>
                            <div class="gauge-bar"></div>
                            <div class="max-time">최대 52h</div>
                            <div class="min-time">40h</div>
                        </div>
                    </div>
                    <div>
                        <div class="hour-check">
                            <span>출근시간</span>
                            <span id="todayStartTime">-</span> <!-- 출근시간과 퇴근시간을 기록해주세요 -->
                        </div>
                        <div class="hour-check">
                            <span>퇴근시간</span>
                            <span id="todayEndTime">-</span>  <!-- 출근시간과 퇴근시간을 기록해주세요 -->
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <button type="button" id="startWork" class="">출근</button> <!-- 해당버튼 클릭시 출근시간이 input태그의 value값에 들어가게 해주세요 -->
                <button type="button" id="endWork" class="">퇴근</button> <!-- 해당버튼 클릭시 퇴근시간이 input태그의 value값에 들어가게 해주세요 -->
                <!-- 출근시간과 퇴근시간의 차에 시급을 곱한 값이 일당입니다. -->
            </div>
            
            <div style="margin-top:6px;">
            
            	<div id="btn_status" class="hhover" style="font-size:14pt; font-weigt:bold; border:solid 1px #21255b; text-align:center; border-radius: 6px; margin-bottom:3px; height:35px;">업무시작전</div>
            	
            	<ul id="btn_status_list" style="list-style: none; display: none; text-align:center; border:solid 1px #21255b; border-radius: 6px; ">
            		<li style="margin-top:3px; margin-bottom:3px;" class="hhover">내근</li>
            		<li style="margin-top:3px; margin-bottom:3px;" class="hhover">외근</li>
            		<li style="margin-top:3px; margin-bottom:3px;" class="hhover">파견</li>
            		<li style="margin-top:3px; margin-bottom:3px;" class="hhover">출장</li>
            	</ul>
            </div>
            
            <br>
            
            <div style="margin-top:5px;">
	         	<div id="btn_myCommute" class="hhover" style="font-size:14pt; font-weight: bold;">내 근태관리</div>
	            <div id="btn_myCommute_list" style="list-style: none; display: none;">
            		<div id="myCommuteTable" class="hhover">&nbsp;&nbsp;&nbsp;내 근태현황</div>
            		<div id="myAnnualInfo" class="hhover">&nbsp;&nbsp;&nbsp;내 연차내역</div>
            	</div>
            </div>
            
            <div style="margin-top:10px;">
            
            		<div id="btn_depCommute" class="hhover" style="font-size:14pt; font-weight: bold;">부서 근태관리</div>
		         	
		            <div id="btn_depCommute_list" style="list-style: none; display: none;"></div>
		            
		    </div>
            
            <c:if test="${sessionScope.loginuser.securityLevel == '10'}">
            	
            	<div style="margin-top:10px;">
            
            		<div id="btn_allCommute" class="hhover" style="font-size:14pt; font-weight: bold;">전사 근태관리</div>
		         	
		            <div id="btn_allCommute_list" style="list-style: none; display: none;">
			            <div id="allCommuteTable" class="hhover">&nbsp;&nbsp;&nbsp;전사 근태현황</div>
	            		<div id="allCommuteChart" class="hhover">&nbsp;&nbsp;&nbsp;전사 근태통계</div>
	            		<div id="allAnnualInfo" class="hhover">&nbsp;&nbsp;&nbsp;전사 연차현황</div>
            		</div>
		            
		    	</div>
		         	
            </c:if>
            	
            
            
        </div>
    </div>
</div>
