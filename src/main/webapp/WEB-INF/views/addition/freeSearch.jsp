<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소통게시판</title>
<link rel="stylesheet" href="/resources/additionCss/freeSearch.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container" id="container">
			<table id="table1" class="table">
				<tr id="firtr">
					<td>번호</td><td>제목</td><td>작성자</td><td>작성일</td><td>조회수</td>
				</tr>
				<c:choose>
					<c:when test="${not empty list }">
						<c:forEach	items="${list }" var="b" varStatus="i">
							<tr>
								<td>${b.bnum }</td>
								<c:choose>
									<c:when test="${b.boardLevel==2 }">
									<td id="btitle"><a href="/boardView.do?boardType=3&boardNo=${b.boardNo}" id="regulation" class="chk">관리자에 의해 규제된 글입니다.</a></td>
									<input type="hidden" class="memberId" value="${sessionScope.m.memberId }">
									<input type="hidden" class="memberLevel" value="${sessionScope.m.memberLevel }">
									</c:when>
									<c:otherwise>
									<td id="btitle"><a href="/boardView.do?boardType=3&boardNo=${b.boardNo}" id="noRegulation">${b.boardTitle }&nbsp;[${b.commentCount }]</a></td>
									</c:otherwise>
								</c:choose>
								<td>${b.boardWriter }</td>
								<td>${b.regDate }</td>
								<td>${b.readCount }</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5">일치하는 검색 결과가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
				
			</table>
		<div id="page">
			<div id="pageNavi">${pageNavi }</div>
		</div>
		<div>
			<a id="back" class="btn" href="/additionBoard.do?boardType=3&reqPage=1">목록</a>
		</div>
	</div>
	<script type="text/javascript">
	$(document).on("click",".chk",function(){
		var idx=$(".chk").index(this);
		var memberLevel = $(".memberLevel").eq(idx).val();
		var memberId = $(".memberId").eq(idx).val();
		if(!memberId=="" && memberLevel==0){
			return true;
		}
		return false;
    });
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>