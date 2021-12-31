<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="container">
        <h2>학생 목록 보기</h2>
        <table class="table table-bordered">
          <thead>
            <tr>
              <th>#번호</th>
              <th>수강생 이름</th>
              <th>연락처</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>for</td>
              <td>each</td>
              <td>문</td>
            </tr>
            <tr>
              <td>jstl</td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td>사용</td>
              <td></td>
              <td></td>
            </tr>
          </tbody>
        </table>
      </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>