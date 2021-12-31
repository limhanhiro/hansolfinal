<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용 게시판 상세보기</title>
<link href="resources/spaceCss/space_default.css" rel="stylesheet">
<link href="resources/spaceCss/space_boardWrite.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container">
	<h3><img class="i-img" src="resources/spaceImage/search.png" style="width: 40px; "> 게시판 상세보기 </h3>
		<table class="table tb" >
			<tr>
				<th style="border-top: 1px solid black;" colspan="2">제목</th>
				<td style="border-top: 1px solid black;" colspan="6">${u.ubTitle }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${u.memberId }</td>
				<th>작성날짜</th>
				<td>${u.ubDate }</td>
				<th>첨부파일</th>
				<td><a href="/spaceFileDown.do?ubNo=${u.ubNo }">${u.filename }</a></td>
			</tr>
			<tr>
				<td colspan="8">내용</td>
			</tr>
			<tr>
				<td colspan="8"><div id="content" name="ubContent"> ${u.ubContent }</div></td>
			</tr>
		</table>
		<div class="prev-btn">
			<button onclick="location.href='/selectSpaceBoardList.do?reqPage=1'"> &lt  뒤로가기</button>
		</div>
		<c:if test="${sessionScope.m.memberId eq u.memberId }">
		<div class="view-btn">
			<button onclick="location.href='/deleteUseBoard.do?ubNo=${u.ubNo}'">삭제</button>
			<button onclick="location.href='/updateUseBoardFrm.do?ubNo=${u.ubNo}'">수정</button>
			</div>
		</c:if>
		<c:if test="${sessionScope.m.memberLevel eq 0 }">
		<div class="view-btn">
			<button onclick="location.href='/deleteUseBoard.do?ubNo=${u.ubNo}'">삭제</button>
		</div>	
		</c:if>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>