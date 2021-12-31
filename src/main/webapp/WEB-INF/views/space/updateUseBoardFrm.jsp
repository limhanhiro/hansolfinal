<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공간 게시판 수정</title>
    <link href="resources/spaceCss/space_default.css" rel="stylesheet">
    <link href="resources/spaceCss/space_boardWrite.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="container">
		<h3><img class="i-img" src="resources/spaceImage/edit.png" style="width: 40px; "> 게시판 수정 </h3>
			<form action="/updateUseBoard.do" method="post" enctype="multipart/form-data">
				<table class="table tb" border="1">
					<tr>
						<th style="border-top: 1px solid black;" colspan="2">제목</th>
						<td style="border-top: 1px solid black;" colspan="6"><input type="text" name="ubTitle" value="${u.ubTitle }"></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${sessionScope.m.memberId }</td>
						<th>작성날짜</th>
						<td>${u.ubDate }</td>
						<th>첨부파일</th>
						<td><input type="file" name="upfile"></td>
					</tr>
					<tr>
						<td colspan="8">내용</td>
					</tr>	
					<tr>
						<td colspan="8"><textarea name="ubContent" >${u.ubContent }</textarea></td>
					</tr>	
				
				</table>
				<input type="hidden" name="memberId" value="${sessionScope.m.memberId }">
				<input type="hidden" name="ubNo" value="${u.ubNo }">
				<div class="btn-box">
					<button id="btn" type="submit" onclick="return checkAgree();">수정하기</button>			
				</div>
			</form>	
		</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script>
	 function checkAgree() {
	      if ($("[name=upfile]").val() == "") {
	         alert("파일을 업로드 해주세요.");
	         $("[name=upfile]").focus();
	         return false;
	      }
	 }
	</script>
</body>
</html>