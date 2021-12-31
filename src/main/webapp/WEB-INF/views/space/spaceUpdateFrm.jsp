<meta charset="UTF-8">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공간 수정</title>
<link href="resources/spaceCss/space_default.css" rel="stylesheet">
<link href="resources/spaceCss/space_insert.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container">
		<div class="insert-main">
			<form action="/updateSpace.do" method="post"
				enctype="multipart/form-data">
				<h3>
					<img class="i-img" src="resources/spaceImage/edit.png"
						style="width: 40px;"> 공간 수정
				</h3>
				<input type="hidden" value="${s.spaceNo }" name="spaceNo">
				<div class="space-info">
					<p>
						<img class="i-img" src="resources/spaceImage/townhouse.png"
							style="width: 40px;">공간 정보 수정
					</p>
					<table class="table-condensed info-table">
						<tr>
							<th>이름</th>
							<td><input type="text" name="spaceName"
								value="${s.spaceName}"></td>
						</tr>
						<tr>
							<th>용도</th>
							<td><input type="text" name="spacePurpose"
								value="${s.spacePurpose }"></td>
						</tr>
						<tr>
							<th>주요시설</th>
							<td><input type="text" name="mainFacility"
								value="${s.mainFacility }"></td>
						</tr>
						<tr>
							<th>주요물품</th>
							<td><input type="text" name="mainProduct"
								value="${s.mainProduct }"></td>
						</tr>
						<tr>
							<th>수용인원</th>
							<td><input type="text" name="maxPeople"
								value="${s.maxPeople }"></td>
						</tr>
						<tr>
							<th>대관료</th>
							<td><input type="text" name="price" value="${s.price }"></td>
						</tr>
					</table>
				</div>
				<div class="space-time">
					<p>
						<img class="i-img" src="resources/spaceImage/clock.png"
							style="width: 40px;">시간 정보 수정
					</p>
					<table class="table-condensed time-table">
						<c:forEach items="${st }" var="st">
							<input type="hidden" value="${st.stNo }" name="stNo">
							<tr>
								<th>이용시간 :
								<th>
								<td><input value="${st.startTime }" name='startTime'></td>
								<th>~</th>
								<td><input value="${st.endTime }" name='endTime'></td>
							</tr>
						</c:forEach>
					</table>
					<table class="table-condensed time-table">
					</table>
				</div>
				<div class="space-img">
					<p>※이미지를 새로 등록해주세요.</p>
					<p>※이미지의 최대 개수는 3장입니다.</p>
					<p>※이미지 등록 후 꼭 썸네일 사진을 클릭 해주세요.</p>
					<input name="files" type="file" id="image" accept="image/*"
						onchange="setThumbnail(event);" multiple />
					<div id="image_container"></div>
					<input type="hidden" name="thumbnail">
					<div id="insertBtn">
						<button onclick="return checkAgree();" class="btn btn-default"
							type="submit">수정하기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
	 function checkAgree() {
	      if ($("[name=spaceName]").val() == "") {
	         alert("공간 이름을 입력하세요.");
	         $("[name=spaceName]").focus();
	         return false;
	      }
	      if ($("[name=spacePurpose]").val() == "") {
	         alert("공간 목적을 입력하세요.");
	         $("[name=spacePurpose]").focus();
	         return false;
	      }
	      if ($("[name=mainFacility]").val() == "") {
	         alert("주요 시설을 입력하세요.");
	         $("[name=mainFacility]").focus();
	         return false;
	      }

	      if ($("[name=mainProduct]").val() == "") {
	         alert("주요 물품을 입력하세요.");
	         $("[name=mainProduct]").focus();
	         return false;
	      }

	      if ($("[name=maxPeople]").val() == "") {
	         alert("수용 인원을 입력하세요.");
	         $("[name=maxPeople]").focus();
	         return false;
	      }
	      if ($("[name=price]").val() == "") {
	         alert("대관료를 입력하세요.");
	         $("[name=price]").focus();
	         return false;
	      }
	      if ($("[name=startTime]").val() == "") {
	         alert("이용시간(시작시간)을 입력하세요.");
	         $("[name=startTime]").focus();
	         return false;
	      }
	      if ($("[name=endTime]").val() == "") {
	         alert("이용시간(종료시간)을 입력하세요.");
	         $("[name=endTime]").focus();
	         return false;
	      }
	      if ($("#image").val() == "") {
	         alert("이미지를 등록 해주세요.");
	         return false;
	      }
	      if ($("[name=thumbnail]").val() == "") {
	         alert("썸네일을 클릭해주세요.");
	         return false;
	      }
	   }
	$(function () {
		$("#plus").click(function () {
			if($(".time-table tr").length <4){
			$(".time-table").append("<tr><th>이용시간 : <th><td><input placeholder='10:00' name = 'startTime'></td><th>~</th><td><input placeholder='12:00' name='endTime'></td></tr>");
			}else{
				alert("시간은 4개까지만 등록 가능합니다.");
				
			}
		});
		$("#del-time").click(function () {
			$(this).parent().parent().parent().remove();
		})
 		$(document).on("click","#image_container>*",function(){
				$(this).addClass("mainImg");
			if($("#image_container>*").not($(this)).hasClass("mainImg")){
				$("#image_container>*").not($(this)).removeClass("mainImg");
			}
			var idx = $("#image_container>*").index(this); 
			$("[name=thumbnail]").val(idx);
		
	    });		
	});
 	function setThumbnail(event) {
 		var fileInput = document.getElementById("image");
        var files = fileInput.files;
        var file;
		if(files.length > 3){
			alert("사진은 최대 3개까지 업로드 할 수 있습니다.");
			$("#image").val("");

			return;	
		}
 		$("#image_container>img").remove();
		for (var image of event.target.files) {
			var reader = new FileReader();
			reader.onload = function(event) {
				var img = document.createElement("img");
				img.setAttribute("src", event.target.result);
				document.querySelector("div#image_container").appendChild(img);
				};
				reader.readAsDataURL(image);
				}
		} 

	</script>
</body>
</html>