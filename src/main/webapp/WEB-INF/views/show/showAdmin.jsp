<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<link rel="stylesheet" href="/resources/showCss/showAdmin.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/jquery-ui/jquery-ui.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<script type="text/javascript" src="/resources/jquery-ui/jquery-ui.min.js"></script>
	<jsp:include page="/WEB-INF/views/common/adminpageMenu.jsp"/>
	<div class="container">        
        <div class="mypage-title"><span>공</span>연관리</div>
        <div class="mypage-container">
        	<div class="listNavi">
	    		<div><h4>진행중인 공연</h4></div>
	    		<div><h4>지난 공연</h4></div>
	    	</div>
			<div class="showBox">
	        	<c:forEach items="${list }" var="s">
	        		<div class="showList">
		                <img src="${s.filepath }" class="poster">
		                <div>
			                <h2>공연명 : ${s.showName }</h2>
			                <h4>공연장 : ${s.showHall }</h4>
			                <p>공연기간 : ${s.showStart } ~ ${s.showEnd }</p>	 
			                <a href="/showView.do?showNo=${s.showNo }" class="btn btn-default">상세보기</a>
		                </div>
		                <div class="reservList">
		                	<input type="text" class="datepicker form-control" placeholder="날짜선택">
		                	<input type="hidden" value="${s.showStart }">
		                	<input type="hidden" value="${s.showEnd }">
		                	<input type="hidden" value="${s.showNo }">
		                	<div class="show"></div>
		                </div>
		                <div>
		                	<button onclick="deleteShow('${s.showNo}')" class="btn btn-danger">공연삭제</button>
		                </div>
	        		</div>
	        	</c:forEach>
        	</div>
        	<div class="lastShowBox">
	        	<c:forEach items="${last }" var="s">
	        		<div class="showList">
		                <img src="${s.filepath }" class="poster">
		                <div>
			                <h2>공연명 : ${s.showName }</h2>
			                <h4>공연장 : ${s.showHall }</h4>
			                <p>공연기간 : ${s.showStart } ~ ${s.showEnd }</p>	 
			                <a href="/showView.do?showNo=${s.showNo }" class="btn btn-default">상세보기</a>
		                </div>
		                <div>
		                	<button onclick="deleteShow('${s.showNo}')" class="btn btn-danger">공연삭제</button>
		                </div>
	        		</div>
	        	</c:forEach>
        	</div>
        </div>
	</div>
	<script>

		function deleteShow(showNo) {
	    	if(confirm("공연을 삭제하시겠습니까?")){
				location.href="/deleteShow.do?showNo="+showNo;
			}
		}
		$(function() {
			$(".datepicker").focusin(function() {
				var start = $(this).next().val();
				var end = $(this).next().next().val();
				$(this).datepicker({
		            dateFormat: "yy-mm-dd",
		            monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
		            monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
		            dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		            dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		            dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		            yearSuffix : '년',
		            minDate: start,
		            maxDate: end,
		            beforeShowDay: noMondays //월요일은 휴무일
		        });
			    function noMondays(date) {
			    	return [date.getDay() != 1, ''];
			    };
			});
			
			$(".datepicker").change(function() {
				var showDate = $(this).val();
				var showNo = $(this).next().next().next().val();
				var idx = $(".datepicker").index(this);
				$(".show").eq(idx).empty();
				$.ajax({
					url: "/checkReserv.do",
					data: {showDate:showDate, showNo:showNo},
					type: "post",
					success: function(data) {
						var seats = 413;
						if(data[0] != null){
							for (var i = 0; i < data.length; i++) {
								var p = $("<p>");
								p.append("예매자 : "+data[i].memberId);
								p.append(" 예매수 : "+data[i].ticketNum);
								seats -= data[i].ticketNum;
								$(".show").eq(idx).append(p);
								$(".show").scrollTop(innerHeight);
							}
							$(".show").eq(idx).append("<h4>잔여좌석 : "+seats+"</h4>");
						}else{
							$(".show").eq(idx).append("<h4>예매정보가 없습니다.</h4>");
						}
						
					}
				});
			});

			$(".listNavi>div").click(function() {
				$(".listNavi>div").children().removeClass("selec");
	            $(this).children().addClass("selec");
	            $(".listNavi").nextAll().hide();
	            if($(this).index() == 0){
	                $(".showBox").show();
	            }else{
	                $(".lastShowBox").show();
	            }
			});
			$(".listNavi>div").first().click();
		});
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>