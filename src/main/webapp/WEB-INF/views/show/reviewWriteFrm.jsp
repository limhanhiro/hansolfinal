<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="/resources/commonCss/default.css">
	<!-- 부트스트랩 -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<style>
	.reviewBox{
		padding: 20px;
		text-align: center;
	}
	.starBox{
		text-align: center;
		margin: 10px 0;
	}
	textarea{
		resize: none;
		margin: 10px 0;
	}
</style>
<body>
	<div class="reviewBox">
		<h1>공연명 : ${sr.showName }</h1>
		<h3>공연일 : ${sr.showDate }</h3>
		<form action="/insertReview.do" method="post">
			<input type="hidden" name="reviewWriter" value="${sessionScope.m.memberId }">
			<input type="hidden" name="showNo" value="${sr.showNo }">
			<input type="hidden" name="reservNo" value="${sr.reservNo }">
			<div class="starBox">
				<img src="resources/showImage/starOn.png" style="width:50px;" class="star selec">
				<c:forEach begin="0" end="3">
					<img src="resources/showImage/starOff.png" style="width:50px;" class="star">
				</c:forEach>
			</div>
			<input type="hidden" name="star" id="star" value="1">
			<textarea name="reviewContent" class="form-control" style="height: 200px;"></textarea>
			<button type="submit" class="btn btn-defualt btn-lg" style="width:100%;">관람평 등록</button>
		</form>
	</div>
	<script>
		var result = ${result};
		$(function() {
			if(result == 2){
				alert("${msg}");
				window.close();
			}else if(result != 0){
				alert("이미 관람평을 작성한 예매내역입니다.");
				window.close();
			}
			$(".star").click(function() {
				$(".star").attr("src", "resources/showImage/starOff.png").removeClass("selec");
				$(this).attr("src", "resources/showImage/starOn.png").addClass("selec");
				$(this).prevAll().attr("src", "resources/showImage/starOn.png").addClass("selec");
				var count = $(".selec").length;
				$("#star").val(count);
			});
		});
	</script>
</body>
</html>