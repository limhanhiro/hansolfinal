<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아카데미 마이페이지</title>
<link href="resources/hansolCss/hansol_exhibitionMypage.css" rel="stylesheet">
</head>
<body>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp" />
	<div class="container">        
        <div class="mypage-title"><span>수업</span>결제내역</div>
        <c:if test="${empty list }">
        	<div class="noRental">
        		<p>수강 내역이 없습니다.</p>
        	</div>
        </c:if>
        <c:if test="${!empty list }">
        <div class="mypage-container" >
		<div class="table-box">
			<table class="table table-bordered table-hover">
				<tr>
					<th>No.</th>
					<th>수업명</th>
					<th>카테고리</th>
					<th>결제 날짜</th>
					<th>수업 기간</th>
					<th>담당 선생님</th>
					<th>장소</th>
					<th>가격</th>
					<th>취소하기</th>
				</tr>
				<c:forEach items="${list }" var="acp" varStatus="i">
					<tr>
						<td>${i.count }</td>
						<td><a href="/academyView.do?academyNo=${acp.academyNo }" style="text-decoration: none; color: black;">${acp.academyTitle }</a></td>
						<td>${acp.academyStart }~${acp.academyEnd }</td>
						<td>${acp.paymentDate }</td>
						<td>${acp.academyCategory }</td>
						<td>${acp.academyTeacher }</td>
						<td>${acp.academyPlace }</td>
						<td>${acp.paymentPrice }원</td>
						<c:choose>
						<c:when test="${acp.paymentCancel eq 0 }">
							<td><button class="writeBtn acCancelPayment" type="button" paymentNo="${acp.paymentNo }" memberNo="${sessionScope.m.memberNo }">취소</button></td>
						</c:when>
						<c:when test="${acp.paymentCancel eq 1 }">
							<td>취소완료</td>
						</c:when>
						<c:when test="${acp.paymentCancel eq 2 }">
							<td>환불예정</td>
						</c:when>
						</c:choose>
					</tr>
				</c:forEach>
				<c:forEach items="${last }" var="acpl" varStatus="i">
					<tr>
						<c:set var="totalCount" value="${totalCount }"/>
						<td>${i.count + totalCount}</td>
						<td><a href="/academyView.do?academyNo=${acpl.academyNo }" style="text-decoration: none; color: black;">${acpl.academyTitle }</a></td>
						<td>${acpl.academyStart }~${acp.academyEnd }</td>
						<td>${acpl.paymentDate }</td>
						<td>${acpl.academyCategory }</td>
						<td>${acpl.academyTeacher }</td>
						<td>${acpl.academyPlace }</td>
						<td>${acpl.paymentPrice }원</td>
						<td>지난 수업</td>
					</tr>
				</c:forEach>
			</table>
		</div>
        </div>
        </c:if>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script >
	$(".acCancelPayment").click(function(){
		var paymentNo = $(this).attr("paymentNo");
		var memberNo = $(this).attr("memberNo");
		location.href="/deleteAcPayment.do?paymentNo="+paymentNo+"&memberNo="+memberNo;
	});
	</script>
</body>
</html>
