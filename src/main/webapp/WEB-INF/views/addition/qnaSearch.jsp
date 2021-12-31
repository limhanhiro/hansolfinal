<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의게시판</title>
<script src="https://kit.fontawesome.com/4054b6ceaa.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/additionCss/qnaSearch.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container" id="container">
		<div id="table">
			<table id="table1" class="table">
				<tr id="firtr">
					<td>번호</td><td>제목</td><td>작성자</td><td>작성일</td><td>답변상태</td>
				</tr>
				<c:choose>
					<c:when test="${not empty list }">
						<c:forEach	items="${list }" var="b" varStatus="i">
						<tr>
							<td>${b.bnum }</td>
							<c:choose>
								<c:when test="${b.boardLevel eq 1}">
									<td id="btitle"><a href="/boardView.do?boardType=2&boardNo=${b.boardNo}" class="chk"><i class="fas fa-lock"></i>&nbsp;&nbsp;${b.boardTitle }</a></td>
									<input type="hidden" class="boardLevel" value="${b.boardLevel }">
									<input type="hidden" class="memberId" value="${sessionScope.m.memberId }">
									<input type="hidden" class="memberLevel" value="${sessionScope.m.memberLevel }">
									<input type="hidden" class="boardWriter" value="${b.boardWriter }">
								</c:when>
								<c:otherwise>
									<td id="btitle"><a href="/boardView.do?boardType=2&boardNo=${b.boardNo}">${b.boardTitle }</a></td>
								</c:otherwise>
							</c:choose>
							<td>${b.boardWriter }</td>
							<td>${b.regDate }</td>
							<c:choose>
								<c:when test="${b.commentCount ne 0}">
								<td id="answerAfter">답변완료</td>
								</c:when>
								<c:otherwise>
								<td id="answerBefore">미답변</td>
								</c:otherwise>
							</c:choose>
						</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5">일치하는 검색 결과가 없습니다.</td>
						<tr>
					</c:otherwise>
				</c:choose>
				
				
			</table>
		</div>
		<div id="page">
			<div id="pageNavi">${pageNavi }</div>
		</div>
		<div>
			<a id="back" class="btn" href="/additionBoard.do?boardType=2&reqPage=1">목록</a>
		</div>
	</div>
	<script type="text/javascript">
	$(document).on("click",".chk",function(){
		var idx=$(".chk").index(this);
		var boardWriter = $(".boardWriter").eq(idx).val();
		var boardLevel = $(".boardLevel").eq(idx).val();
		var memberId = $(".memberId").eq(idx).val();
		var memberLevel = $(".memberLevel").eq(idx).val();
		if(memberId ==""){
			alert("읽기 권한이 없습니다.");
			return false;
		}
		if(boardLevel==1){
			if(memberLevel == 0){
				return true;
			}else if(boardWriter == memberId){
				return true;
			}else{
				alert("읽기 권한이 없습니다.");
				return false;
			}
		}
    });
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>