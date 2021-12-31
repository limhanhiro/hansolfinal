<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택사항</title>
    <link href="resources/readingCss/reading_option.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<br><br><br>
		<div class="container">
		<div class="main-title">
			<h1>예약 내역 & 비품 대여</h1>
		</div>
		<br><br><br>
			<div class="info">
				<h3>예약일 : ${re.readingTime}</h3>
				<h3>예약일자 : ${re.readingDay}</h3>
				<h3>좌석번호 : ${re.readingNum}</h3>
				<h3>예약이름 : ${re.readingName}</h3>
				<c:choose>
					<c:when test="${re.readingTy eq 0}">
						<h3>이용시간 : 종일 09:00 ~ 19:00</h3>
					</c:when>
					<c:when test="${re.readingTy eq 1}">
						<h3>이용시간 : 오전 09:00 ~ 14:00 (점심시간 전원퇴실)</h3>
					</c:when>
					<c:when test="${re.readingTy eq 2}">
						<h3>이용시간 : 오후 14:00 ~ 19:00</h3>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${(fi.fixturesCharger eq 1 and fi.fixturesTable eq 1) and fi.fixturesBlanket eq 1 }">
						<h3>비품대여 : 충전기, 독서대, 담요</h3>
					</c:when>
					<c:when test="${fi.fixturesCharger eq 1 and fi.fixturesTable eq 1 }">
						<h3>비품대여 : 충전기, 독서대</h3>
					</c:when>
					<c:when test="${fi.fixturesCharger eq 1 and fi.fixturesBlanket eq 1 }">
						<h3>비품대여 : 충전기, 담요</h3>
					</c:when>
					<c:when test="${fi.fixturesTable eq 1 and fi.fixturesBlanket eq 1 }">
						<h3>비품대여 : 독서대, 담요</h3>
					</c:when>
					<c:when test="${fi.fixturesCharger eq 1 }">
						<h3>비품대여 : 충전기</h3>
					</c:when>
					<c:when test="${fi.fixturesTable eq 1 }">
						<h3>비품대여 : 독서대</h3>
					</c:when>
					<c:when test="${fi.fixturesBlanket eq 1 }">
						<h3>비품대여 : 담요</h3>
					</c:when>
					<c:otherwise>
						<h3>비품대여 : 없음</h3>
					</c:otherwise>
				</c:choose>
			</div>
			<br>
			
			<div class="form-box">
				<input type="hidden" name="readingDay" value="${re.readingDay }">
				<input type="hidden" name="modals" class="btn btn-success btn-lg" data-toggle="modal" data-target="#myModal" value="비품대여" style="background-color: #e79b36; border-color: #e79b36">
	<%-- 		<a href="/readingOption1.do" class="btn btn-success btn-lg">수정하기-미구현(다 구현후 좌석선택을 오전/오후/종일로 나누고 이용시간 수정만 확장예정)</a>--%>
				<button class="hidden" id="fixturescancel" style="margin-left: 10px;">비품대여취소</button>
				<button class="hidden" id="cancel" style="margin-left: 10px;">예약취소</button>
				
				<a href="/readingNotice.do" class="btn btn-default btn-lg" style="margin-left: 10px;">처음으로</a>
			</div>
			<br>
			
			<div class="info">
				<h3 style="color : red">※ 가족 및 타인의 계정으로 신청한 좌석이거나,</h3>
				<h3 style="color : red">신청 외의 좌석 이용적발시</h3>
				<h3 style="color : red">즉시 퇴실 + 1주일 열람실 이용 제한</h3>
			</div>
		</div>
		
		<!-- Modal -->
		<div id="myModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h2 class="modal-title">비품대여</h2>
		      </div>
		      <div class="modal-body">
		        <form action="/fixturesInsert.do" method="post" class="modal-form">
					<input type="hidden" name="readingNo" value="${re.readingNo }">
					<input type="hidden" name="fixturesDay" value="${re.readingDay }">
					<input type="hidden" name="fixturesNum" value="${re.readingNum }">
					<input type="hidden" name="fixturesId" value="${sessionScope.m.memberId }">
					<input type="hidden" name="fixturesName" value="${re.readingName }">
					<label><h4><input type="checkbox" name="fixturesCharger" value="1"> 충전기</h4></label><br>
					<label><h4><input type="checkbox" name="fixturesTable" value="1"> 독서대</h4></label><br>
					<label><h4><input type="checkbox" name="fixturesBlanket" value="1"> 담요</h4></label><br>
					<div><input type="hidden" name="sub" class="btn btn-success btn-lg" value="비품대여" style="background-color: #e79b36; border-color: #e79b36;"></div>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		      </div>
		    </div>
		
		  </div>
		</div>	
	
	<script>
	$("#cancel").click(function(){
		var readingDay = "${re.readingDay }";
		var readingId = "${sessionScope.m.memberId }";
		var result = confirm("예약을 취소하시겠습니까? \n※비품대여를 신청했을경우 예약취소가 실패할 수 있습니다.");
		if(result){
			$.ajax({
				url : "/reservationCancel.do",
				data : {readingDay:readingDay,readingId:readingId},
				type : "post",
				success : function(data){
					if(data > 0){
						alert("예약이 취소되었습니다.");
						location.href = "/readingNotice.do";
					}else{
						alert("예약취소를 실패하였습니다. 비품대여신청이 있는지 확인해주세요.");
						location.href = "/readingNotice.do";
					}
				}
			});
		}
	});
	$("#fixturescancel").click(function(){
		var readingDay = "${re.readingDay }";
		var readingId = "${sessionScope.m.memberId }";
		var result = confirm("비품대여예약을 취소하시겠습니까?");
		if(result){
			$.ajax({
				url : "/fixturesCancel.do",
				data : {readingDay:readingDay,readingId:readingId},
				type : "post",
				success : function(data){
					if(data > 0){
						alert("비품대여예약이 취소되었습니다.");
						location.href = "/readingNotice.do";
					}else{
						alert("비품대여예약취소를 실패하였습니다.");
						location.href = "/readingNotice.do";
					}
				}
			});
		}
	});

	$(function(){
		var redate = new Date($("input[name=readingDay]").val());
		var today = new Date();
		if(redate>today){
			$("input[name=sub]").attr("type","submit");
			$("#cancel").attr("class","btn btn-danger btn-lg");
			if(${fi.fixturesNo eq 0}){
				$("input[name=modals]").attr("type","button");
			}else{
				$("#fixturescancel").attr("class","btn btn-danger btn-lg");
			}
		}
	});
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>