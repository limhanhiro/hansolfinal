<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/resources/commonCss/mypage.css">

        <div class="mypage-nav">
            <div class="mypage-navi">
                <div class="m1"><a class="selectMenu" href="/showAdmin.do?selectmenu=0">공연관리</a></div>
                <div><a class="selectMenu" href="/exhibitionAdmin.do?selectmenu=1">전시관리</a></div>
                <div><a class="selectMenu" href="/academyAdminList.do?selectmenu=2">강좌관리</a></div>
                <div><a class="selectMenu" href="/spaceAdmin.do?selectmenu=3&reqPage=1">대관관리</a></div>
                <div><a class="selectMenu" href="/readingAdmin.do?selectmenu=4">열람실 관리</a></div>
                <div><a class="selectMenu" href="/allMember.do?selectmenu=5&reqPage=1">회원 관리</a></div>
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
        