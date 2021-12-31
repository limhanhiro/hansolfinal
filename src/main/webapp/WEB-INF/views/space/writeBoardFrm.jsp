<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용 게시판 작성</title>
    <link href="resources/spaceCss/space_default.css" rel="stylesheet">
    <link href="resources/spaceCss/space_boardWrite.css" rel="stylesheet">
</head>
<body>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="container">
		<h3><img class="i-img" src="resources/spaceImage/edit.png" style="width: 40px; "> 게시판 작성 </h3>
			<form action="/writeBoard.do" method="post" enctype="multipart/form-data">
				<table class="table table-border" border="1">
					<tr>
						<th colspan="2">제목</th>
						<td colspan="6"><input type="text" name="ubTitle" value="${today } ${r.spaceName } 사용체크리스트 "></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${sessionScope.m.memberId }</td>
						<th>사용공간</th>
						<td>${r.spaceName }</td>
						<th>사용날짜</th>
						<td>${r.rentalDate }</td>
						<th>첨부파일</th>
						<td><input type="file" name="upfile"></td>
					</tr>
					<tr>
						<th colspan="8">내용</th>
					</tr>	
					<tr>
						<td colspan="8"><textarea name="ubContent">체크리스트 작성 완료.</textarea></td>
					</tr>	
				
				</table>
				<input type="hidden" name="rentalNo" value="${r.rentalNo }">
				<input type="hidden" name="memberId" value="${sessionScope.m.memberId }">
				<div class="btn-box">
				<button id="btn" onclick="return checkAgree();" type="submit">등록하기</button>			
				</div>
			</form>	
		</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script >
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