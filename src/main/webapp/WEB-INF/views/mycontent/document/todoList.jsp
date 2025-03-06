<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>


<jsp:include page="document_main.jsp" />

<script type="text/javascript">

	$(document).ready(function(){
		
		
	}); // end of $(document).ready(function(){})-------------------------------------------------
	
</script>

	<div>
		<div class="mt-3 ml-3 mb-3">
			<h3 class="mb-3">결재 대기 문서함</h3>
			<button class="doc_download">목록 다운로드</button>
		</div>
		<table class="table">
			<thead>
				<tr>
					<th>
						<input type="checkbox" />
					</th>
					<th>
						<span>기안일</span>
					</th>
					<th>
						<span>결재양식</span>
					</th>
					<th>
						<span>제목</span>
					</th>
					<th>
						<span>첨부</span>
					</th>
					<th>
						<span>기안자</span>
					</th>
					<th>
						<span>문서번호</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty requestScope.todoList}">
					<c:forEach var="todo" items="${requestScope.todoList}">
						<tr class="document" onclick="location.href='<%= ctxPath%>/document/documentView?documentNo=${todo.documentNo}&documentType=${todo.documentType}';">
							<td>
								<input type="checkbox" class="document_check" onclick='event.cancelBubble=true;'>
							</td>
							<td>
								<span>${todo.draftDate}</span>
							</td>
							<td>
								<span>${todo.documentType}</span>
							</td>
							<td>
								<span>${todo.subject}</span>
							</td>
							<td>
								<span></span>
							</td>
							<td>
								<span>${todo.name}</span>
							</td>
							<td>
								<span>${todo.documentNo}</span>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.todoList}">
					<tr>
						<td colspan="6"><span>결재 대기 문서가 없습니다.</span></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
	</div>
</div>
<jsp:include page="../../footer/footer.jsp" /> 