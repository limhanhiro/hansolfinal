<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전시 마이페이지</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link href="resources/hansolCss/hansol_exhibitionMypage.css" rel="stylesheet">
</head>
<body>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp" />
	<div class="container">        
        <div class="mypage-title"><span>전시</span>예매내역</div>
        <c:if test="${empty list && empty last }">
        	<div class="noRental">
        		<p>예매 내역이 없습니다.</p>
        	</div>
        </c:if>
        <c:if test="${!empty list || !empty last }">
		<div class="pop">
			<span>☞이메일 발권이란?</span>
			<p>회원가입시 등록한 이메일로 티켓을 전송 해드립니다</p>
			<span>☞주의 사항</span>
			<p>1회만 가능합니다</p>
		</div>
        <div class="mypage-container" >
		<div class="table-box">
			<table class="table table-bordered table-hover">
				<tr>
					<th>No.</th>
					<th>전시명</th>
					<th>예약 날짜</th>
					<th>전시 날짜</th>
					<th>전시 시간</th>
					<th>장소</th>
					<th>인원</th>
					<th>가격</th>
					<th>취소하기</th>
					<th>이메일 발권</th>
				</tr>
				<c:forEach items="${list }" var="exm" varStatus="i">
					<tr>
						<td>${i.count }</td>
						<td><a href="/exhibitionView.do?exhibitionNo=${exm.exhibitionNo }" style="text-decoration: none; color: black;">${exm.exhibitionTitle }</a></td>
						<td>${exm.bookDate }</td>
						<td>${exm.exhibitionStart }~${exm.exhibitionEnd }</td>
						<td>${exm.exhibitionTimeStart }~${exm.exhibitionTimeEnd }</td>
						<td>무지다 미술관</td>
						<td>${exm.paymentQuantity }명</td>
						<td>${exm.paymentPrice }원</td>
						<c:choose>
						<c:when test="${exm.checkEmail  eq 0 }">
							<c:if test="${exm.paymentCancel eq 0 }">
								<td><button class="writeBtn cancelPayment" type="button" paymentNo="${exm.paymentNo }" memberNo="${sessionScope.m.memberNo }">취소</button></td>
								<td><button class="writeBtn emailSend" type="button" id="emailSend" memberNo="${sessionScope.m.memberNo }" paymentNo="${exm.paymentNo }">발권</button></td>
							</c:if>
							<c:if test="${exm.paymentCancel eq 1 }">
								<td colspan="2">취소되었습니다</td>
							</c:if>
							<c:if test="${exm.paymentCancel eq 2 }">
								<td colspan="2">환불 예정 입니다</td>
							</c:if>
						</c:when>
						<c:when test="${exm.checkEmail eq 1 }">
							<td colspan="2">발권되었습니다</td>
						</c:when>
						</c:choose>
					</tr>
				</c:forEach>
				<c:forEach items="${last }" var="exml" varStatus="i">
					<tr>
						<c:set var="totalCount" value="${totalCount }"/>
						<td>${i.count + totalCount}</td>
						<td><a href="/exhibitionView.do?exhibitionNo=${exml.exhibitionNo }" style="text-decoration: none; color: black;">${exml.exhibitionTitle }</a></td>
						<td>${exml.bookDate }</td>
						<td>${exml.exhibitionStart }~${exml.exhibitionEnd }</td>
						<td>${exml.exhibitionTimeStart }~${exml.exhibitionTimeEnd }</td>
						<td>무지다 미술관</td>
						<td>${exml.paymentQuantity }명</td>
						<td>${exml.paymentPrice }원</td>
						<td colspan="2">지난 공연 입니다</td>
					</tr>
				</c:forEach>
			</table>
		</div>
        </div>
        </c:if>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script >
	$(function () {
		$(".pop").hide();
		$("#q-img").hover(function() {
			$(".pop").show();
		},function(){
			$(".pop").hide();	
		});
		/* 체크 한 내용 출력  */
	});
	$(".cancelPayment").click(function(){
		var paymentNo = $(this).attr("paymentNo");
		var memberNo = $(this).attr("memberNo");
		location.href="/deletePayment.do?paymentNo="+paymentNo+"&memberNo="+memberNo;
	});
	$(".emailSend").click(function(){
		var memberNo = $(this).attr("memberNo");
		var paymentNo = $(this).attr("paymentNo");
		swal({
			  title: "이메일 발권",
			  text: "한번만 발권이 가능 하면 발권시 취소가 불가능 합니다 합니다 발권 하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((email) => {
			  if (email) {
				  location.href="/sendEmailTicket.do?paymentNo="+paymentNo+"&memberNo="+memberNo;
			  } else {
			    swal("발권을 취소 하였습니다");
			  }
		});
	});
	
	</script>
</body>
</html>
