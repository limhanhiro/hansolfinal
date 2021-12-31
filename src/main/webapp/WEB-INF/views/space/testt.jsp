<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="now" class="java.util.Date" />
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
	<c:if test="${fn:length(list) == 0  }">
		<p class="no">미작성한 예매 내역이 없습니다.</p>
	</c:if>
	<c:if test="${fn:length(list) != 0  }">
	<table class="table table-bordered">
				<tr>
					<th>No.</th>
					<th>예약 공간</th>
					<th>예약 시간</th>
					<th>예약 날짜</th>
					<th>용도</th>
					<th>인원</th>
					<th>가격</th>
					<th>상태</th>
					<th>리뷰/예매</th>
					<th>체크리스트 <img id="q-img" src="resources/spaceImage/ask.png" style="width: 20px; "></th>
				</tr>
				<c:forEach items="${list }" var="l" varStatus="i">
					<tr>
						<td>${i.count }</td>
						<td>${l.spaceName }</td>
						<td>${l.startTime }~${l.endTime }</td>
						<td>${l.rentalDate }</td>
						<td>${l.spacePurpose }</td>
						<td>${l.rentalPeople }/${l.maxPeople }명</td>
						<td>${l.price }원</td>
						<c:if test="${l.rentalStatus eq 1 }">
							<td>심사중</td>
						</c:if>
						<c:if test="${l.rentalStatus eq 2 }">
							<td>확정</td>
						</c:if>
						<td>
							<c:choose>
								<c:when test="${l.srNo eq 0 && l.rentalDate<today|| l.delYn eq 'Y'  }">
									<button class="writeBtn" type="button"
									class="btn btn-info btn-lg" data-toggle="modal"
									data-target="#myModal">리뷰 작성</button>
									<input type="hidden" id="rentalNo" value="${l.rentalNo }">
								</c:when>
								<c:when test="${ l.rentalDate>today  }">
									<button class="writeBtn" type="button" onclick="location.href='/deleteRes.do?rentalNo=${l.rentalNo}&memberId=${sessionScope.m.memberId }'">예약 취소</button>
								</c:when>
								<c:otherwise>
									<button  class="update-Btn" type="button" class="btn btn-info btn-lg" data-toggle="modal"
							data-target="#rModal">리뷰 수정</button>
							<input type="hidden" id="rentalNo" value="${l.rentalNo }">
								<div class="d-review">
										<img   src="resources/spaceImage/x.png" style="width: 20px; opacity: 0.8;">
									</div>
								</c:otherwise>
							</c:choose>							
						</td>
						<td>
							<c:choose>
								<c:when test="${l.usedBoard eq 1 }">
									작성완료
								</c:when>
								<c:when test="${l.usedBoard eq 0 && l.rentalDate>today }">
									-
								</c:when>
								<c:when test="${l.usedBoard eq 0 && l.rentalDate<today}">
									<a id="ckList" href="/selectSpaceBoardList.do?reqPage=1">▶ 작성하러가기</a>
								</c:when>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</table>
	</c:if>
		<script >
	$(function () {
		$(".pop").hide();
		$("#q-img").hover(function() {
			$(".pop").show();
		},function(){
			$(".pop").hide();	
		});
		/* 체크 한 내용 출력  */
 		$("[name=ub]").change(function(){
	        if($("[name=ub]").is(":checked")){
	     	   $.ajax({
					url : "/spaceMypageAjax.do",
					data : {memberId : $("[name=memberId]").val(), ub : $("[name=ub]").val() },
					type : "post",
					success : function(data) {
						$(".table").hide();
						$(".table-bb").show();
						$(".table-bb").empty();
						$(".table-bb").append(data);
					}
			   });
	        }else{
	        	$(".table").show();
	        	$(".table-bb").hide();
	        }
	    }); 
	});
		$(".d-review").click(function () {
			var delConfirm = confirm('리뷰를 삭제하시겠습니까?');
			var rentalNo = $(this).prev().val();
			   if (delConfirm) {
				   $.ajax({
						url : "/deleteSpaceReview.do",
						data : {rentalNo :rentalNo},
						type : "post",
						success : function(data) {
							if(data>0){
							 location.href = "/spaceMypage.do?memberId=${sessionScope.m.memberId}"; 
							}else{
								alert("삭제 실패");
							}
						}
				   });
			      alert('삭제되었습니다.');
			   }
			   else {
			      alert('삭제가 취소되었습니다.');
			   }
		});
	$(".writeBtn").click(
			function() {
				$.ajax({
					url : "/selectRentalInfo.do",
					data : {rentalNo :$(this).next().val()},
					type : "post",
					success : function(data) {
						console.log(data);
						$(".modal-b").empty();
						$(".modal-b").append("<input type = 'hidden' name='rentalNo' value='"+data.rentalNo +"'>");
					}
				});
			});
	$(".updateBtn").click(
			function() {
				$.ajax({
					url : "/selectReviewInfo.do",
					data : {rentalNo :$(this).next().val()},
					type : "post",
					success : function(data) {
						console.log(data);
						$(".modal-bb").empty();
						$(".modal-bb").append("<input type = 'hidden' name='rentalNo' value='"+data.rentalNo +"'>");
						$("[name=srContent]").empty();
						$("[name=srContent]").attr("value",data.srContent);
					}
				});
			});
	</script>
</body>
</html>