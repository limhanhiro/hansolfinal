<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원자 목록</title>
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
<link href="resources/hansolCss/hansol_requritList.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 <div class="container">
        <h2 style="margin-top: 100px; margin-bottom: 50px;"><span class="line">지원</span>자 리스트</h2>
       <c:choose>
       <c:when test="${empty list }">
       	<h2 style="margin: 0 auto;">아직 지원자 가 없습니다</h2>
       </c:when>
       <c:when test="${not empty list }">
        <table id="tableee" class="table table-hover">
              <tr id="firstTr">
                  <th>#번호</th>
                  <th>이름 </th>
                  <th>성별</th>
                  <th>연락처</th>
              </tr>
          	<c:forEach items="${list }" var="rs" varStatus="i">
             	<tr id="secTr">
				   <td>${i.index +1 }</td>
				   <td><a href="/resumeView.do?resumeNo=${rs.resumeNo }">${rs.memberName }</a></td>
				   <td>${rs.resumeGender }</td>
				   <td>${rs.resumePhone }</td>
			   </tr>
			 </c:forEach>
          </table>
        </c:when>
        </c:choose>  
        </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>