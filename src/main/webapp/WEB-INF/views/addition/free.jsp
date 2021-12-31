<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소통게시판</title>
<script src="https://kit.fontawesome.com/4054b6ceaa.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/additionCss/free.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container" id="container">
		<div id="table">
			<div id="new">새글수 : ${nCount }/${totalCount }</div>
			<div id="search">
			<form action="/searchKeyword.do?boardType=3&reqPage=1" method="post">
			 	<select name="type" id="type">
			 		<option value="tac">제목+내용</option>
			 		<option value="writer">작성자</option>
			 	</select>
			 	<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요.">
			 	<button id="submit"><i class="fas fa-search"></i></button>
			</form>
			</div>
			<table id="table1" class="table">
				<tr id="firtr">
					<td>번호</td><td>제목</td><td>작성자</td><td>작성일</td><td>조회수</td>
				</tr>
				<c:forEach	items="${list }" var="b" varStatus="i">
				<c:if test="${b.bnum != 0 }">
				<tr>
					<td>${b.bnum }</td>
					<c:choose>
						<c:when test="${b.boardLevel==2 }">
						<c:if test="${sessionScope.m.memberLevel==0 }">
						<td id="btitle"><a href="/boardView.do?boardType=3&boardNo=${b.boardNo}" id="regulation" class="chk">(규제중)&nbsp;${b.boardTitle }&nbsp;[${b.commentCount }]</a></td>
						</c:if>
						<c:if test="${sessionScope.m.memberLevel!=0 }">
						<td id="btitle"><a href="/boardView.do?boardType=3&boardNo=${b.boardNo}" id="regulation" class="chk">관리자에 의해 규제된 글입니다.</a></td>
						</c:if>
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
				</c:if>
				</c:forEach>
			</table>
		</div>
		<c:if test="${not empty sessionScope.m }">
			<div id="table">	
				<a class="btn" id="write" href="/boardWriteFrm.do?boardType=3">글작성</a>
				<a class="btn" id="my" href="/myFree.do?memberId=${sessionScope.m.memberId }">내글보기</a>
			</div>
		</c:if>
		<div id="page">
			<div id="pageNavi">${pageNavi }</div>
		</div>
	</div>
	<script type="text/javascript">
	$("#submit").click(function(){
		var keyword = $("#keyword").val();
		if(keyword == ""){
			alert("검색어를 입력하세요.");
			return false;
		}
	});
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