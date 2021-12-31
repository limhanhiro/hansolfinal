<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 현황</title>
    <link href="resources/readingCss/reserationToday.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<br><br><br>
		<div class="container">
			<div class="main-title">
				<h1 class="todaySeat"></h1>
			</div>
			<br><br><br>
			<div class="container-left col-sm-10">
				<c:forEach begin="1" end="100" varStatus="i" >
					<c:choose>
						<c:when test="${i.index%20 eq 0}">
							<div id="seat${i.index }" class="seat">${i.index }</div>
							<br><br><br><br>
						</c:when>
						<c:when test="${i.index%10 eq 0}">
							<div id="seat${i.index }" class="seat">${i.index }</div>
							<br>
						</c:when>
						<c:when test="${i.count%5 eq 0 }" >
							<div id="seat${i.index }" class="seat">${i.index }</div>
							<div id="emptyseat">
								빈
							</div>
						</c:when>
						<c:otherwise>
							<div id="seat${i.index }" class="seat">${i.index }</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<div class="container-right col-sm-2">
				<div style="background-color:#A79078">이용가능</div>
				<div style="background-color:#6B6C68">이용불가</div>
			</div>
		</div>
	<script>
		$(function(){
			var today = new Date();
			var year = today.getFullYear();
		    var month = ("0" + (1 + today.getMonth())).slice(-2);
		    var day = ("0" + today.getDate()).slice(-2);
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
			refresh();
		});
		function refresh(){  
		      setTimeout('location.reload()',60000); 
		}
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>