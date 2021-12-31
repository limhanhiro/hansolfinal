<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link href="resources/readingCss/reading_seat.css" rel="stylesheet">
	<br><br><br>
		<div class="container">
			<div class="main-title">
				<h1 class="todaySeat"></h1>
			</div><br><br><br>
			<div class="container-left col-sm-9">
			
				<c:forEach begin="1" end="100" varStatus="i" >
					<c:choose>
						<c:when test="${i.index%20 eq 0}">
							<div id="seat${i.index }" class="seat" onclick="chocie(this);">${i.index }</div>
							<br><br><br><br>
						</c:when>
						<c:when test="${i.index%10 eq 0}">
							<div id="seat${i.index }" class="seat" onclick="chocie(this);">${i.index }</div>
							<br>
						</c:when>
						<c:when test="${i.count%5 eq 0 }" >
							<div id="seat${i.index }" class="seat" onclick="chocie(this);">${i.index }</div>
							<div id="emptyseat">
								빈
							</div>
						</c:when>
						<c:otherwise>
							<div id="seat${i.index }" class="seat" onclick="chocie(this);">${i.index }</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<div class="container-right col-sm-3">
				<h1><strong>선택 내역</strong></h1>
				<div class="readingInfo">
					<h2 name="showseat"></h2>
				</div>
				<button name="rollback" class="btn btn-success btn-lg" onclick="history.go(-1);" style="background-color: #563D39; border-color: #563D39; margin-top: 10px;">이전단계</button>
				<form action="/readingOption.do" method="post">
					<input type="hidden" name="readingNum">
					<input type="hidden" name="readingDay" value="${re.readingDay }">
					<input type="hidden" name="readingId" value="${sessionScope.m.memberId }">
					<input type="hidden" name="sub" class="btn btn-danger btn-lg" value="예약하기" style="margin-top: 10px;">
				</form>
			</div>
		</div>
	<script>
		$(function(){
			var today = new Date();
			var year = today.getFullYear();
			
			var selectDate = $("input[name=readingDay]").val();
			var readingDay = selectDate;
			var month = selectDate.substring(5,7); //몇월
			var day = selectDate.substring(8,10);  //몇일
			var str = year+"-"+month+"-"+day;
			var readingDay = str;
			$(".todaySeat").html(str+" 좌석 현황");
			$.ajax({
				url : "/chkSeat.do",
				data : {readingDay:readingDay},
				type : "post",
				success : function(data){
					for(var i=0; i<data.length; i++){
				 		var seat = data[i];
				 		for(var j=0; j<100; j++){ //좌석 수 마다 변경
				 			if($(".seat").eq(j).html() == seat){
				 				$(".seat").eq(j).removeAttr("onclick").css("background-color", "#6B6C68").css("color", "black");
				 			}
				 		}
				 	}
				}
			})
		});
	
		var count = 0;
		
		function chocie(obj){
	    	if(count == 1){
	    		alert("좌석은 한개만 선택할 수 있습니다.");
	    	}else{
				$(obj).css("background-color", "#563D39");
				$(obj).attr("onclick", "cancel(this);");
				$("input[name=readingNum]").val($(obj).html());
				$("h2[name=showseat]").html($(obj).html()+"번 좌석");
				$("input[name=sub]").attr("type","submit");
				count++;
				$("button[name=rollback]").attr("class","hidden");
	    	}
		}
		function cancel(obj){
			$(obj).css("background-color", "#A79078");
			$(obj).attr("onclick", "chocie(this);");
			$("input[name=readingNum]").val("");
			$("h2[name=showseat]").html("");
			$("input[name=sub]").attr("type","hidden");
			count--;
			$("button[name=rollback]").attr("class","btn btn-success btn-lg");
		}
		
		$(document).ready(function() {
		    $(window).on('beforeunload', function(){
		        return "Any changes will be lost";
		    });
		    // Form Submit
		    $(document).on("submit", "form", function(event){
		        // disable warning
		        $(window).off('beforeunload');
		    });
		});
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>