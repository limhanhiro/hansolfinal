<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>열람실 이용안내</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/jquery-ui/jquery-ui.css">
    <link href="resources/readingCss/reading_notice.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>	
	<script type="text/javascript" src="/resources/jquery-ui/jquery-ui.min.js"></script>
	<br><br><br>
	<div class="container">
		<div class="main-title">
			<h1>열람실 안내</h1>
		</div>
		<br><br><br>
			<div class="container-left col-sm-9">
				<div class="single-title">
					<h3><span>대</span>상</h3>
					<ul>
						<li>회원가입을 한 지역 주민 및 현장 접수</li>
						<li>현장 접수는 지역 주민 외에도 이용 가능 ※신분증 필요</li>
					</ul>
				</div>
				<br>
				<div class="single-title">
					<h3><span>이</span>용안내 : 09:00 ~ 19:00 총 100석</h3>
					<ul>
						<li>입장은 오전 9시부터 가능</li>
						<li>점심시간(12:00 ~ 13:00)은 방역 및 소독 실시(시설 이용 불가) 전원 퇴실 후 재입장</li>
						<li>법정공휴일 및 매주 월요일 휴관</li>
						<li>사전비품대여 신청자는 좌석 이용전 메인에서 보증금 제출하고 수령(당일대여는 메인에서)</li>
					</ul>
				</div>
				<br>
				<div class="single-title">
					<h3 class="today"><span>이</span>용방법
						<a href="/reservationToday.do" class="btn btn-primary btn" style="margin-left: 10px; background-color: #4972bc; border-radius: 0px;">좌석현황 확인하기</a>
					</h3>
					<ul>
						<li>이용일 일주일 전부터 예약가능</li>
						<li>비회원은 메인에서 신분증을 맡긴 후 이용가능</li>
						<li>※ 가족 및 타인의 계정으로 신청한 좌석이거나, 신청 외의 좌석 이용 적발시 즉시 퇴실 + 1주일 열람실 이용 제한</li>
					</ul>
				</div>
				<br>
				<div class="single-title">
					<h3><span>이</span>용수칙</h3>
					<ul>
						<li>지정좌석에서 마스크 상시 착용</li>
						<li>점심시간(12:00 ~ 13:00)에 소독을 위한 전원 퇴실 (귀중품 개인 소지 필수)</li>
						<li>방역지침으로 인한 휴게실 사용 불가</li>
						<li>조기 퇴실시 다음 이용자를 위해 메인이나 퇴실장치에 찍고 퇴실</li>
						<li>※ 비품 대여자는 비품반납 후 보증금 수령</li>
					</ul>
				</div>
			</div>
			<div class="container-right col-sm-3">
				<!-- 캘린더 코드 -->
				<div id="datepicker"></div>
				<form action="/readingSeat.do" method="post" class="date-form">
					<input type="hidden" name="readingDay">
					<input type="hidden" name="readingId" value="${sessionScope.m.memberId }">
					<h2 name="showdate"></h2>
					<h2 name="showseat" style="margin-bottom:20px"></h2><!-- 총좌석 - 카운트 = 남은좌석 -->
					<input type="hidden" name="sub"class="btn btn-success btn-lg" value="좌석 선택하기" style="background-color: #e79b36; border-color: #e79b36">
				</form>
			</div>
			<div class="readingList-form col-sm-12">
				<form action="/reservationDay.do" method="post">
					<fieldset>
						<input type="hidden" name="readingId" value="${sessionScope.m.memberId }" readonly>
						<input type="submit" class="btn btn-success btn-lg" value="예약내역보기  & 비품 대여" style="margin-left: 10px; background-color: #064663; border-color: #064663">
					</fieldset>
				</form>
			</div>
		</div>
	<script>
	    $(function() {
	        var today = new Date(); //현재날짜
	        var startDate = new Date(today); //시작날짜
	        startDate.setDate(startDate.getDate()); //오늘제외
	        var endDate = new Date(today);
	        endDate.setDate(endDate.getDate()+7); //+7일까지만 예약받음
	        $("#datepicker").datepicker({
	        	//캘린더 기본베이스
	            dateFormat: "yy-mm-dd",
	            monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
	            monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
	            dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
	            dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
	            dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
	            yearSuffix : '년',
	            minDate: startDate,
	            maxDate: endDate,
	            beforeShowDay: noMondays //월요일은 휴무일
	        });
	    });
	   	//월요일 휴무 코드
	    function noMondays(date) {
	    	return [date.getDay() != 1, ''];
	    };
	    var seat=0;
	    $("#datepicker").change(function() {
	    	var total=100;
	    	
			selectDate = $(this).val();
			$("input[name=readingDay]").val(selectDate);
			var readingDay = $("input[name=readingDay]").val();
			var month = selectDate.substring(5,7); //몇월
			var day = selectDate.substring(8,10);  //몇일
			$.ajax({
				url : "/countSeat.do",
				data : {readingDay:readingDay},
				type : "post",
				success : function(data){
					seat=total-data;
					$("h2[name=showdate]").html(month+"월 "+day+"일");
					$("h2[name=showseat]").html("남은좌석 : "+seat+ "석");
					$("input[name=sub]").attr("type","submit"); //좌석선택 hidden에서 submit으로
				}
			});
        });
    </script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>