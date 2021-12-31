<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 지원한 목록</title>
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
<link href="resources/hansolCss/hansol_requritList.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 <div class="container">
        <h2 style="margin-top: 100px; margin-bottom: 50px;"><span class="line">내가</span>지원한 공고</h2>
       
        <table id="tableee" class="table table-hover">
              <tr id="firstTr">
                  <th>#번호</th>
                  <th>공고명 </th>
                  <th>내이력서보기</th>
              </tr>
          	<c:forEach items="${list }" var="rs" varStatus="i">
             	<tr id="secTr">
				   <td>${i.index +1 }</td>
				   <c:if test="${rs.resumeCancel eq 1 }">
				   <td>공고가 삭제 되었습니다</td>
				   </c:if>
				   <c:if test="${rs.resumeCancel eq 0 }">
				   <td><a href="/requritView.do?requritNo=${rs.requritNo }" style="text-decoration: none;">${rs.requritTitle }</a></td>
				   </c:if>
				   <td><a href="/resumeView.do?resumeNo=${rs.resumeNo }" style="text-decoration: none;">이력서 보기</a></td>
			   </tr>
			 </c:forEach>
          </table>
        </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>