<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>열람실 예약</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/jquery-ui/jquery-ui-big.css">
    <link href="resources/readingCss/reading_list.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>	
	<script type="text/javascript" src="/resources/jquery-ui/jquery-ui.min.js"></script>
	
	<br><br><br>
	<div class="container">
		<h1>열람실 예약</h1><br>
		<h3>총 100석</h3><br>
		<div class="container-left col-sm-7" >
			<!-- 캘린더 코드 -->
			<div id="datepicker"></div>
		</div>
		<div class="container-right col-sm-5">
			<form action="/readingSeat.do" method="post">
				<input type="hidden" name="readingDay">
				<input type="hidden" name="readingId" value="${sessionScope.m.memberId }">
				<h2 name="showdate"></h2>
				<h2 name="showseat"></h2><!-- 총좌석 - 카운트 = 남은좌석 -->
				<input type="hidden" name="sub"class="btn btn-success btn-lg" value="좌석 선택하기" style="background-color: #563D39; border-color: #563D39">
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