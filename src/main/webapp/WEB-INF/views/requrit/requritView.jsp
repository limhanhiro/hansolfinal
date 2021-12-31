<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전시 상세보기</title>
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
<link href="resources/hansolCss/hansol_requritView.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 <div class="container">
		
		<c:choose>	
			<c:when test="${r.period le -1 }">
				<p>마감된 공고입니다</p>
			</c:when>
		<c:when test="${r.period ge 0 }">
        <h2 class="title">${r.requritTitle }</h2>
        <div class="sector">
                <span class="first"><span class="line">경력</span></span>
                <span class="second">${r.requritCareer }</span>
				<p class="sectorLine"></p>
        </div>
        <div class="sector">
            <span class="first"><span class="line">성별</span></span>
            <span class="second">${r.requritGender }</span>
			<p class="sectorLine"></p>
        </div>
        <div class="sector">
            <span class="first"><span class="line">직종</span></span>
            <span class="second">${r.requritField }</span>
			<p class="sectorLine"></p>
        </div>
        <div class="sector">
            <span class="first"><span class="line">고용</span>형태</span>
            <span class="second">${r.employeeType }</span>
			<p class="sectorLine"></p>
        </div>
        <div class="sector">
            <span class="first"><span class="line">모집</span>기간</span>
            <c:choose>
            <c:when test="${r.period ge 1 }">
            	<span class="second">${r.requritStart } ~ ${r.requritEnd }(남은기간${r.period } 일)</span>
            </c:when>
            <c:when test="${r.period eq 0 }">
            	<span class="second">${r.requritStart } ~ ${r.requritEnd }(오늘 마감!!)</span>
            </c:when>
            </c:choose>
			<p class="sectorLine"></p>
        </div>
         <div class="sector">
            <span class="first"><span class="line">이력</span>서 다운</span><br>
            <span class="second" style="margin-left: 200px; display: inline-block;  width: 100px;">이력서</span><button onclick="download('이력서.docx')" class="btn" style="display: inline-block; margin-left: 50px;" onfocus="this.blur()"">이력서 다운</button>
     		<span class="second" style="margin-left: 200px;  display: inline-block; width: 150px; margin-top: 5px;">경력 기술서</span><button onclick="download('경력기술서.docx')" class="btn" style="display: inline-block;" onfocus="this.blur()">경력 기술서 다운</button>
			<p class="sectorLine"></p>
        </div>
        <div class="sector">
            <p><span class="line">상세</span>설명</p>
            	${r.requritDetail }
        </div>
        <div class="btnArea" style="text-align: center;">
        <c:choose>
        	<c:when test="${sessionScope.m.memberLevel eq 1 || sessionScope.m.memberLevel eq 2 }">
       			 <button type="button" class="btn btn-lg" onclick="goResumeFrm();">지원하기</button>
        	</c:when>
         	<c:when test="${sessionScope.m.memberLevel eq 0 }">
         	<c:if test="${r.requritCancel eq 0 }">
        		<button type="button" class="btn" id="deleteRequrit">삭제하기</button>
        		<button type="button" class="btn" id="updateRequrit">수정하기</button>
        		<button type="button" class="btn" onclick="goResumeList();">지원자보기</button>
        	</c:if>
        	<c:if test="${r.requritCancel eq 1 }">
        		<button type="button" class="btn btn-lg" id="updateRequritAndRevival">수정하고 재공고</button>
        	</c:if>
       	 	</c:when>
        </c:choose>
        </div>
		</c:when>
        </c:choose>
        <input type="hidden" id ="hide" value="${r.requritNo }">
    </div>
  	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script>
	function download(fileName){
		location.href="/attacheFileDown.do?fileName="+fileName;
	}
	function goResumeFrm(){
		var requritTitle = $(".title").html();
		var requritNo = $("#hide").val();
		if(confirm(requritTitle+"에지원 하시겠습니까")){
			location.href="/resumeFrm.do?requritNo="+requritNo+"&requritTitle="+requritTitle;
		}
	}
	function goResumeList(){
		var requritNo = $("#hide").val();
		var requritTitle = $(".title").html();
		location.href="/resumeList.do?requritNo="+requritNo+"&requritTitle="+requritTitle;
	}
	$("#deleteRequrit").click(function(){
		var requritNo = $("#hide").val();
		location.href ="/deleteRequrit2.do?requritNo="+requritNo;
	});
	$("#updateRequrit").click(function(){
		var requritNo = $("#hide").val();
		location.href ="/updateRequritFrm.do?requritNo="+requritNo;
	});
	$("#updateRequritAndRevival").click(function(){
		var requritNo = $("#hide").val();
		location.href ="/revivalRequritFrm.do?requritNo="+requritNo;
	});
	</script>
</body>
</html>