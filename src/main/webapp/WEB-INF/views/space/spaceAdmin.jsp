<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대관 관리자 페이자</title>
<link href="resources/spaceCss/space_default.css" rel="stylesheet">
<link href="resources/spaceCss/space_admin.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<jsp:include page="/WEB-INF/views/common/adminpageMenu.jsp" />
	<div class="container">
		<div class="mypage-title">
			<span>대</span>관관리
		</div>
		<div class="mypage-container">
			<div class="rental-mgr">
			<h3><img class="i-img" src="resources/spaceImage/settings.png" style="width: 40px; "> 대관 신청 관리 </h3>
				<div class="table-box">
					<table class="table table-bordered">
						<tr>
							<th>No.</th>
							<th>이미지</th>
							<th>공간 이름</th>
							<th>아이디</th>
							<th>예약 시간</th>
							<th>예약 날짜</th>
							<th>예약 명수</th>
							<th>상태</th>
						</tr>
						<c:forEach items="${list }" var="l" varStatus="i">
							<tr>
								<td>${start + i.index }</td>
								<td><img class="rental-img"
									src="resources/spaceImage/upload/${l.filename }"></td>
								<td>${l.spaceName }</td>
								<td>${l.memberId }</td>
								<td>${l.startTime }~${l.endTime }</td>
								<td>${l.rentalDate }</td>
								<td>${l.rentalPeople }명</td>
								<c:if test="${l.rentalStatus eq 1 }">
									<td>심사중<br>
										<button class="mBtn"
											onclick="location.href='/mailSend.do?rentalNo=${l.rentalNo}&memberId=${l.memberId }'">확정하기</button>
									</td>
								</c:if>
								<c:if test="${l.rentalStatus eq 2 }">
									<td>확정</td>
								</c:if>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="page-box">${pageNavi }</div>
			</div>
			<div class="space-box">
				<h3><img class="i-img" src="resources/spaceImage/settings.png" style="width: 40px; "> 공간 관리 </h3>
				<div class="choice">
					<span id="sL">공간 리스트</span><span id ="dL">삭제 된 공간</span>
				</div>
				<c:forEach items="${space }" var="s">
					<div class="noDel-space">
					<img class="info-img"
							src="resources/spaceImage/upload/${s.filename }">
						<p>공간 이름: ${s.spaceName }</p>
						<p>용도 : ${s.spacePurpose }</p>
						<p>수용인원 :${s.maxPeople }</p>
						<p>가격 : ${s.price }</p>
						<button id="btn" class="btn btn-default"
							onclick="location.href='/spaceDelete.do?spaceNo=${s.spaceNo}'">삭제하기</button>
						<button id="btn" class="btn btn-default"
							onclick="location.href='/spaceUpdate.do?spaceNo=${s.spaceNo}'">수정하기</button>
					</div>
				</c:forEach>
				<c:forEach items="${delSpace }" var="d">
					<div class="del-space">
					<img class="info-img"
							src="resources/spaceImage/upload/${d.filename }">
						<p>공간 이름 : ${d.spaceName }</p>
						<p>용도 : ${d.spacePurpose }</p>
						<p>수용인원 :${d.maxPeople }</p>
						<p>가격 : ${d.price }</p>
						<input type="hidden" value="${d.spaceNo }">
						<img class="del-img" src="resources/spaceImage/bin.png">
						<button id="btn" class="btn btn-default"
							onclick="location.href='/spaceRestore.do?spaceNo=${d.spaceNo}'">복구하기</button>
					</div>
				</c:forEach>
			</div>
			<div class="del-black">
			<h3><img class="i-img" src="resources/spaceImage/settings.png" style="width: 40px; "> 블랙리스트 관리 </h3>
					<table class="table">
						<tr>
							<th>No.</th>
							<th>아이디</th>
							<th>블랙된 횟수</th>
						<tr>
				<c:forEach items="${black }" var="b" varStatus="i">
					<tr class=" t-hover">
						<td>${i.count }</td>
						<td>${b.blackId }</td>
						<td>${b.blackCount }</td>
					</tr>						
				</c:forEach>
					</table>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
		$(".del-space").hide();
		$("#sL").css("color","#e79b36").css('font-weight','bold' );
		$("#dL").css("color","black").css('font-weight','lighter' );
		$("#dL").click(function () {
			$("#dL").css("color","#e79b36").css('font-weight','bold' );
			$("#sL").css("color","black").css('font-weight','lighter' );
			$(".noDel-space").hide();
			$(".del-space").show();
		});
		$("#sL").click(function () {
			$("#sL").css("color","#e79b36").css('font-weight','bold' );
			$("#dL").css("color","black").css('font-weight','lighter' );
			$(".del-space").hide();
			$(".noDel-space").show();
		});
		$(".del-img").click(function () {
			var delConfirm = confirm('공간을 완전 삭제 하시겠습니까? 복구가 불가능 합니다.');
			var spaceNo = $(this).prev().val();
			   if (delConfirm) {
				   $.ajax({
						url : "/realDeleteSpace.do",
						data : {spaceNo :spaceNo},
						type : "post",
						success : function(data) {
							if(data>0){
							 location.href = "/spaceAdmin.do?selectmenu=3&reqPage=1"; 
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
	</script>
</body>
</html>
