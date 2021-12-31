<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<meta charset="UTF-8">
	<!-- 기본css -->
	<link rel="stylesheet" href="/resources/commonCss/mainhf.css">
	<!-- 부트스트랩 -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		
	<div class="header-title">
        <div class="h-logo">
			<a href="/main.do">Musée d'art</a>
        </div>
		<div class="h-left">
        <nav class="header-nav">
           <div class="navi">
               <ul>
                   <li><a href="/showList.do">공연 · 예매</a></li>
                   <li><a href="/spaceMain.do">공간 · 대관</a>
                   		<ul class="sub">
                           <li><a href="/spaceMain.do">대관 안내</a></li>
                           <li><a href="/spaceList.do">공간 소개</a></li>
                           <li><a href="/spaceRes.do?spaceNo=0">대관 현황</a></li>
                           <li><a href="/selectSpaceBoardList.do?reqPage=1">사용 게시판</a></li>
                        </ul>
                   </li>
                   <li><a href="/exhibitionList.do?reqPage=4">전시</a></li>
                   <li><a href="/readingNotice.do">열람실</a></li>
                   <li>
                       <a href="/academyList.do?reqPage=4&category=all">아카데미</a>
                       <ul class="sub">
                           <li><a href="/academyList.do?reqPage=4&category=all">수강 신청</a></li>
                           <li><a href="/requritList.do?reqPage=1">강사 모집</a></li>
	                     	<c:choose>
						    	<c:when test="${not empty sessionScope.m && sessionScope.m.memberLevel == 1 }">
									<li><a href="#">수업 관리</a></li>
								</c:when>
								<c:when test="${not empty sessionScope.m && sessionScope.m.memberLevel == 2 }">
								    <li><a href="/teacherAcademyList.do?academyTeacher=${sessionScope.m.memberName }">학생관리</a></li>
								</c:when>
							</c:choose>
                        </ul>
                   </li>
                   <li>
                       <a href="/additionBoard.do?boardType=1&reqPage=1">부가서비스</a>
                       <ul class="sub">
                           <li><a href="/additionBoard.do?boardType=1&reqPage=1">공지사항</a></li>
                           <li><a href="/additionBoard.do?boardType=3&reqPage=1">소통게시판</a></li>
                           <li><a href="/additionBoard.do?boardType=2&reqPage=1">문의게시판</a></li>
                           <li><a href="/additionGuide.do">시설안내 · 오시는 길</a></li>
                           <li><a href="/discount.do">이벤트</a></li>
                       </ul>
                   </li>
               </ul>
           </div>
	</nav>
        </div>  
        <div class="h-right">
		<c:choose>
	    	<c:when test="${empty sessionScope.m }">
				<a href="/loginFrm.do">Sign in <span>></span></a>
			</c:when>
			<c:when test="${not empty sessionScope.m && sessionScope.m.memberLevel == 0}">
			    <a href="/adminpage.do">My Page[관리] <span>></span></a>
			    <a href="/logout.do">로그아웃</a>
			</c:when>
			<c:when test="${not empty sessionScope.m && sessionScope.m.memberLevel == 1 || sessionScope.m.memberLevel == 2}">
			    <a href="/mypage.do?memberNo=${sessionScope.m.memberNo }">My Page[일반] <span>></span></a>
			    <a href="/logout.do"> 로그아웃</a>
			</c:when>
		</c:choose>
		</div>
		<div class="headerText" style="text-shadow: 2px 2px 2px gray;">	
 			<strong>${headerText}</strong>
		</div>
	</div>