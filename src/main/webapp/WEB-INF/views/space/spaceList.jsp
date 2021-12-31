<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공간 소개</title>
<link href="resources/spaceCss/space_default.css" rel="stylesheet">
<link href="resources/spaceCss/space_list.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container">
		<h3>
			<img class="i-img" src="resources/spaceImage/townhouse.png"
				style="width: 40px;"> 공간 소개
		</h3>
		<c:if test="${sessionScope.m.memberLevel eq 0 }">
			<button id="insert-btn" class="btn btn-default"
				onclick="location.href='/spaceInsertFrm.do'">새 공간 등록하기</button>
		</c:if>
		<c:forEach items="${spaceList }" var="s">
			<div class="space-list">
				<c:forEach items="${fileList }" var="f">
					<c:if test="${s.spaceNo eq f.spaceNo }">
						<img class="info-img"
							src="resources/spaceImage/upload/${f.filename }">
					</c:if>
				</c:forEach>
				<a id="info" href="/spaceView.do?spaceNo=${s.spaceNo }&reqPage=1">>상세보기</a>
				<p>공간 : ${s.spaceName }</p>
				<p>용도 : ${s.spacePurpose }</p>
				<p>수용인원 :${s.maxPeople }</p>
				<p>가격 : ${s.price }</p>
				<c:if test="${sessionScope.m.memberLevel eq 0 }">
					<button id="del-btn" class="btn btn-default"
						onclick="location.href='/spaceDelete.do?spaceNo=${s.spaceNo}'">삭제하기</button>
					<button id="update-btn" class="btn btn-default"
						onclick="location.href='/spaceUpdate.do?spaceNo=${s.spaceNo}'">수정하기</button>
				</c:if>
			</div>
		</c:forEach>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>