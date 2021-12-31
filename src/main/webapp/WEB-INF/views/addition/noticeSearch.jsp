<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="/resources/additionCss/noticeSearch.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container" id="container">
		<div id="table">
			<table id="table1" class="table">
				<tr id="firtr">
					<td>번호</td><td>제목</td><td>작성일</td><td>조회수</td>
				</tr>
				<c:choose>
				 <c:when test="${not empty list }">
					 <c:forEach	items="${list }" var="b" varStatus="i">
					<tr>
						<td>${b.bnum }</td>
						<td id="btitle"><a href="/boardView.do?boardType=1&boardNo=${b.boardNo}">${b.boardTitle }</a></td>
						<td>${b.regDate }</td>
						<td>${b.readCount }</td>
					</tr>
					</c:forEach>
				 </c:when>
				 <c:otherwise>
				 	<tr>
				 		<td colspan="4">일치하는 검색 결과가 없습니다.</td>
				 	</tr>
				 </c:otherwise>
				</c:choose>
				
			</table>
		</div>
		<div id="page">
			<div id="pageNavi">${pageNavi }</div>
		</div>
		<div>
			<a id="back" class="btn" href="/additionBoard.do?boardType=1&reqPage=1">목록</a>
		</div>
	</div>	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>