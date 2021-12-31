<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="/resources/additionCss/noticeView.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container" id="container">
		<c:if test="${sessionScope.m.memberLevel eq 0 }">
		<a id="delete" class="btn" href="/boardDelete.do?num=&boardType=1&boardNo=${b.boardNo }">글삭제</a>
		<a id="update" class="btn" href="/boardUpdateFrm.do?boardType=1&boardNo=${b.boardNo }">글수정</a>
		</c:if>
		<a id="blist" class="btn" href="/additionBoard.do?boardType=1&reqPage=1">글목록</a>
		<table id="table1" class="table">
			<tr>
				<td id="boardTitle" colspan="3">${b.boardTitle }</td>
			</tr>
			<tr>
				<td>등록일 &nbsp;&nbsp;&nbsp;&nbsp;  ${b.regDate }</td>
				<c:if test="${not empty b.filename }">
				<td>첨부파일</td>
				<td>
				<a href="/fileDown.do?filename=${b.filename }&filepath=${b.filepath }">${b.filename }</a>
				</td>
				</c:if>
			</tr>
			<tr>
				<td colspan="3">
				<div style="min-height: 200px;">${b.boardContent }</div>
				</td>
			</tr>
		</table>
		<div>
		
		<div><span class="nextTitle">다음글</span>&nbsp;
			<a href="/boardView.do?boardType=1&boardNo=${info.nextNo}" onclick="return chkNext();">
			<input type="hidden" id="next" value="${info.nextNo }">${info.nextTitle }
			</a>
		</div>
		<div><span class="nextTitle">이전글</span>&nbsp;
			<a href="/boardView.do?boardType=1&boardNo=${info.prevNo}" onclick="return chkPrev();">
			<input type="hidden" id="prev" value="${info.prevNo }">${info.prevTitle }
			</a>
		</div>
	
		</div>
	</div>
	<script>
	function chkPrev(){
		var prev = $("#prev").val();
		if(prev==0){
			return false;
		}
	}
	function chkNext(){
		var next = $("#next").val();
		if(next==0){
			return false;
		}
	}
	
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>