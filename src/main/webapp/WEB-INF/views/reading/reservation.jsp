<%@page import="kr.or.member.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%
    Member m = (Member)session.getAttribute("m");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 내역 조회</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/jquery-ui/jquery-ui-big.css">
<link href="resources/readingCss/reservation.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
	<script type="text/javascript" src="/resources/jquery-ui/jquery-ui.min.js"></script>

	<br><br><br>
	<div class="container">
		<div class="main-title">
			<h1>예약 내역 조회</h1><br>
		</div>
		<br><br><br>
		<div class="container-left col-sm-7">
			<h2>날짜를 선택해주세요</h2><br>
			<!-- 캘린더 코드 -->
			<div id="datepicker"></div>
		</div>
		<div class="container-right col-sm-5">
			<h2 class="reservationInfo"></h2>
			<div id="result"></div>
		</div>
		
	</div>
	<script>
		$(function() {
			$("#datepicker").datepicker(
					{
						//캘린더 기본베이스
						dateFormat : "yy-mm-dd",
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월','7월', '8월', '9월', '10월', '11월', '12월' ],
						monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월','7월', '8월', '9월', '10월', '11월', '12월' ],
						dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
						dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
						dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
						yearSuffix : '년',
						beforeShowDay : noMondays
					//월요일은 휴무일
					});
		});
		//월요일 휴무 코드
		function noMondays(date) {
			return [ date.getDay() != 1, '' ];
		};

		$("#datepicker").change(function() {
			var readingDay = $(this).val();
			var readingId =  "${sessionScope.m.memberId}";
			var result = "";
			$.ajax({
				url : "/ajaxSearchReservation.do",
				data : {readingDay:readingDay,readingId:readingId},
				type : "post",
				success : function(data){
					$(".reservationInfo").html("");
					$("#result").html("");
					console.log(data);
					if(data != null){
						$(".reservationInfo").html("예약 내역이 있습니다.");
						result+='<form action="/reservationInfo.do" method="post">';
						result+='<input type="hidden" name="readingDay" value="'+readingDay+'">';
						result+='<input type="hidden" name="readingId" value="${sessionScope.m.memberId }">';
						result+='<input type="submit" name="sub" class="btn btn-success btn-lg" value="상세내역보기" style="background-color: #064663; border-color: #064663">';
						result+='</form>';
						$("#result").html(result);
					}else{
						$(".reservationInfo").html("예약 내역이 없습니다.")
					}
				}

			})
		});
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>