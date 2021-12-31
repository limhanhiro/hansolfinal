<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공연 목록</title>
    <link href="resources/showCss/show_list.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="container">
        <div class="showSearchBox">
	        <c:if test="${sessionScope.m.memberLevel == 0 }">
	            <a href="/insertShowFrm.do" class="btn btn-danger">공연 추가</a>
	        </c:if>
        </div>
        <div class="showList">
        	<c:forEach items="${list }" var="s">
	            <div class="showInfo">
	                <div>
		                <img src="${s.filepath }" class="poster">
		                <h2>${s.showName }</h2>
	                </div>
	                <div>
		                <h4>${s.showHall }</h4>
		                <p>${s.showStart } ~ ${s.showEnd }</p>
	                </div>
	                <div class="sModal">
                    	<a href="/showView.do?showNo=${s.showNo }">상세</a>
                	</div>
	            </div>        	
        	</c:forEach>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>