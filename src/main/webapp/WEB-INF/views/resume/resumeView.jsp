<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이력서 보기</title>
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
<link href="resources/hansolCss/hansol_requritView.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 <div class="container">
        <h2 class="title">${r.memberName }님의 이력서</h2>
        <div class="sector">
                <span class="first"><span class="line">지원</span>이름</span>
                <span class="second">${r.memberName }</span>
				<p class="sectorLine"></p>
        </div>
        <div class="sector">
            <span class="first"><span class="line">성별</span></span>
            <span class="second">${r.resumeGender }</span>
			<p class="sectorLine"></p>
        </div>
        <div class="sector">
            <span class="first"><span class="line">연락</span>처</span>
            <span class="second">${r.resumePhone }</span>
			<p class="sectorLine"></p>
        </div>
        <c:if test="${not empty r.rtList  }">
        <div class="sector">
            <span class="first"><span class="line">이력</span>서</span><br>
            <c:forEach items="${r.rtList }" var="file">
            <span class="second">${file.filename }</span><button onclick="download(${file.fileNo });" class="btn">다운받기</button>
            </c:forEach>
			<p class="sectorLine"></p>
        </div>
        </c:if>
        <div class="sector">
           <p><span class="line">간단</span>소개</p>
            ${r.resumeDetail }
        </div>
        	<c:if test="${sessionScope.m.memberLevel eq 0 }">
        		<button type="button" class="btn" id="updateMemberLevel" memberNo = "${r.memberNo }" style="float: right;">고용하기</button>
        	</c:if>
        <input type="hidden" id ="hide" value="${r.requritNo }">
    </div>
  	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script>
	function download(fileNo){
		location.href="/resumeFileDown.do?fileNo="+fileNo;
	}
	
	$("#updateMemberLevel").click(function(){
		var memberNo = $(this).attr("memberNo");
		var requritNo = $("#hide").val();
		location.href="/updateMemberLevel.do?memberNo="+memberNo+"&requritNo="+requritNo;
	});
	</script>
</body>
</html>