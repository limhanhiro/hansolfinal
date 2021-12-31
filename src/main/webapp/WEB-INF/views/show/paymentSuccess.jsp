<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.container>h1{
    text-align: center;
}
.reservation>h1{
    margin: 0;
}
.reservation>table{
    border-spacing: 10px;
    border-collapse: separate;
}
.reservation th{
    font-size: 20px;
}
.reservation td{
    padding-left: 20px;
}
</style>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container">
		<h1>예매 완료</h1>
        <div class="reservation">
            <h1>예매 정보</h1>
            <hr>
            <table>
                <tr>
                    <th>예매자</th>
                    <td>
						${sr.memberId }
                    </td>
                </tr>
                <tr>
                    <th>예매일</th>
                    <td>
                    	${sr.reservDate }
                    </td>
                </tr>
                <tr>
                    <th>공연명</th>
                    <td>
                    	${show.showName }
                    </td>
                </tr>
                <tr>
                    <th>공연장</th>
                    <td>
                    	${show.showHall }
                    </td>
                </tr>
                <tr>
                    <th>관람일시</th>
                    <td>
                    	${sr.showDate }
                    </td>
                </tr>
                <tr>
                    <th>티켓 매수</th>
                    <td>
                    	${list.size() }
                    	(좌석 : 
                    	<c:forEach items="${list }" var="s" varStatus="i">
                    		${s.seatNo }
                    	</c:forEach>
                    	)
                    </td>
                </tr>
                <tr>
                    <th>결제 금액</th>
                    <td>
                    	<%-- <c:if test=""> --%>
	                    	${list.size()*list[0].seatPrice }
                    	<%-- </c:if> --%>
                    </td>
                </tr>
                <tr>
                    <th>수령방법</th>
                    <td>
                    	현장수령
                    </td>
                </tr>
            </table>
            <div style="text-align: right;">
	            <a href="/main.do" class="btn btn-default">메인으로</a>
            </div>
        </div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>