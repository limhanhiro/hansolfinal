<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-공간</title>
<link href="resources/spaceCss/space_mypage.css" rel="stylesheet">
</head>
<body>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp" />
	<div class="container">        
        <div class="mypage-title"><span>대</span>관신청내역</div>
        <c:if test="${empty list }">
        	<div class="noRental">
        		<p>대관 내역이 없습니다.</p>
        	</div>
        </c:if>
        <c:if test="${!empty list }">
		<div class="pop">
			<span>▶ 체크리스트란?</span>
			<p>공간 사용 후 작성하는 체크리스트</p>
			<span>▶ 작성방법</span>
			<p>공지사항 -> 양식 다운로드 -> 양식 작성 후 저장 -> 사용게시판에 체크리스트 업로드</p>
			<p>※주의 : 대관 후 일주일 이상 체크리스트 미작성시 일주일간 모든 공간 대관 불가. 작성 한 후 일주일 후 부터 사용 가능</p>
		</div>
        <div class="mypage-container" >
         <label for="ub">체크리스트 미작성만 보기</label><input type="checkbox" id="ub" value="on" name="ub">
         <div class="table-bb"></div>
		<div class="table-box">
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
			<!-- 리뷰 작성 모달 -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title"><img   src="resources/spaceImage/edit.png" style="width: 20px; ">   리뷰를 작성 해주세요.</h4>
						</div>

						<div class="modal-body">
							<form action="/insertSpaceReview.do">
								<input type="hidden" value="${sessionScope.m.memberId }" name="memberId">
								<input placeholder="▶ 리뷰를 작성해주세요." name="srContent">
								<div class="modal-b"></div>
								<button class="updateBtn" type="submit">리뷰 등록</button>
							</form>
						</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
			<!-- 리뷰 수정 모달 -->
		<div class="modal fade" id="rModal" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title"><img   src="resources/spaceImage/edit.png" style="width: 20px; ">   수정할 리뷰를 작성해주세요.</h4>
						</div>

						<div class="modal-body">
							<form action="/updateSpaceReview.do">
								<input type="hidden" value="${sessionScope.m.memberId }" name="memberId">
								<input type="text" name="srContent">
								<div class="modal-bb"></div>
								<button class="updateBtn" type="submit">리뷰 수정</button>
							</form>
						</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
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
						$(".modal-b").empty();
						$(".modal-b").append("<input type = 'hidden' name='rentalNo' value='"+data.rentalNo +"'>");
					}
				});
			});
	$(".update-Btn").click(
			function() {
				$.ajax({
					url : "/selectReviewInfo.do",
					data : {rentalNo :$(this).next().val()},
					type : "post",
					success : function(data) {
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
