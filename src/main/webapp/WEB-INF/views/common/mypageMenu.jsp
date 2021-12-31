<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/resources/commonCss/mypage.css">

        <div class="mypage-nav">
            <div class="mypage-navi">
                <div><a class="selectMenu" href="/showMypage.do?selectmenu=0&memberId=${sessionScope.m.memberId }">공연예매내역</a></div>
                <div><a class="selectMenu" href="/exhibitionMypage.do?selectmenu=1&memberNo=${sessionScope.m.memberNo }">전시예매내역</a></div>
                <div><a class="selectMenu" href="/academyMypage.do?selectmenu=2&memberNo=${sessionScope.m.memberNo }">강좌신청내역</a></div>
                <div><a class="selectMenu" href="/spaceMypage.do?selectmenu=3&memberId=${sessionScope.m.memberId }">대관신청내역</a></div>
                <div><a class="selectMenu" href="/readingMypage.do?selectmenu=4&memberId=${sessionScope.m.memberId }">열람실예약내역</a></div>
                <div><a class="selectMenu" href="/mypage.do?selectmenu=5&memberNo=${sessionScope.m.memberNo }">개인정보관리</a></div>
            </div>
        </div>
        
       <script>
        	$(function(){
        		var selectmenu = '${selectmenu}';
        		$(".selectMenu").eq(selectmenu).css("background-color","#064663");
        		$(".selectMenu").eq(selectmenu).css("color","#fff");
        		$(".selectMenu").eq(selectmenu).css("font-weight","bold");
        	});
        </script>
