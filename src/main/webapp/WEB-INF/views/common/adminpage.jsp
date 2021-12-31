<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<jsp:include page="/WEB-INF/views/common/adminpageMenu.jsp"/>
	<div class="container">        
        <div class="mypage-title"><span>회</span>원관리</div>
        <div class="mypage-container" style="border: 1px solid #BDB19A">
		관리자페이지 내용내용~ 테두리 포장제거후 사용~
        </div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>