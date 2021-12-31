<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공간 메인</title>
<link href="resources/spaceCss/space_default.css" rel="stylesheet">
<link href="resources/spaceCss/space_main.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container">
		<h3>
			<img class="i-img" src="resources/spaceImage/information.png"
				style="width: 40px;"> 대관안내
		</h3>
		<div class="space-img">
			<img src="resources/spaceImage/연습실1.png">
			<p>
				어때 ???무지다 문화센터에는 연습실, 다목적실, 강의실, 세미나실 총 4개의 공간이 있습니다.<br> 비영리 모임,
				생활문화동아리와 문화인, 그리고 지역의 예술가들을 위해 제공합니다.<br> 공간 특성에 따라 사용할 수 있는
				용도가 다르며, 실별 용도와 보유물품 리스트는 아래 상세내용에서 확인하실 수 있습니다.<br> 쾌적한 공간 사용을
				위해, 실별 적정인원 확인을 추천드리고, 사용 후에는 사용 후 게시판에 게시물을 작성하여야 합니다. <br>
			</p>
		</div>
		<div class="rental-sequence">
			<h3>
				<img class="i-img" src="resources/spaceImage/information.png"
					style="width: 40px;"> 대관절차
			</h3>
			<img src="resources/spaceImage/대관절차.png">
		</div>
		<div class="ckeckL">
			<h3>
				<img class="i-img" src="resources/spaceImage/information.png"
					style="width: 40px;"> 주의사항
			</h3>
			<p>
				<img class="i-img" src="resources/spaceImage/star.png"
					style="width: 20px;"> 사용 후 체크리스트 작성
			</p>
			<p>1. 공지사항에서 양식 다운로드</p>
			<p>2. 양식 작성 후 저장</p>
			<p>3. 무지다 홈페이지 접속 > 로그인 > 공간대관 > 사용게시판 > 글쓰기 > 파일 업로드</p>
			<p>- 공간 사용 후 일주일 이후 까지 체크리스트 업로드가 없으면 공간 대관이 일주일간 불가능 해집니다. 또한
				작성을 완료하지 않으면 누적 되니 주의하시길 바랍니다.</p>
		</div>
		<div class="rental-price">
			<h3>
				<img class="i-img" src="resources/spaceImage/information.png"
					style="width: 40px;"> 대관료 안내
			</h3>
			<div class="spaceRes">
				<a href="/spaceList.do">>공간보기</a>
			</div>
				<c:forEach items="${list }" var="s">
				<div class="space-intro">
					<c:forEach items="${fList }" var="f">
						<c:if test="${s.spaceNo eq f.spaceNo }">
							<img class="info-img" src="resources/spaceImage/upload/${f.filename }">
						</c:if>
					</c:forEach>
					<p>이름 : ${s.spaceName }</p>
					<p>용도 : ${s.spacePurpose }</p>
					<p>수용인원 : 최대  ${s.maxPeople }명</p>
					<p>가격 : ${s.price }원/ 2시간</p>
				</div>
				</c:forEach>
		</div>
		<div class="btn-box">		
		<button class="btn btn-default" id="rentalBtn"
			onclick="location.href='/spaceRes.do?spaceNo=0'">대관 신청하기</button>
		</div>	
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>