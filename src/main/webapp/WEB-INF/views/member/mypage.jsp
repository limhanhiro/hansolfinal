<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
	
	<div class="container">        
        <div class="mypage-title"><span>개</span>인정보관리</div>
        <div class="mypage-container">
        	<div class="white-box">
				<div class="gray-box pw-confirm mgt30">
					<form action="/pwCheck.do" method="post">
					<h4 class="tit">비밀번호 확인</h4>
					<dl class="mgt10">
						<dt>
							<p>개인정보보호를 위하여 비밀번호를 다시 한 번 확인합니다.</p>
							<p>비밀번호는 타인에게 노출되지 않도록 주의 해주시기 바랍니다.</p>
						</dt>
						<dd>
							<input type="password" class="pw-confirm" id="pw_con_chk_password" name="memberPassword" placeholder="비밀번호를 입력하세요." >
							<input type="submit" class="msbtn"value="확인">
							<input type="hidden" name="memberId" value="${sessionScope.m.memberId}">
						</dd>
					</dl>
					</form>
				</div>
        	</div>
        </div>
    </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<style>
.white-box {
    background: #fff;
    padding: 35px 0;
}
.gray-box {
    padding: 40px;
    background: #064663;
    border-radius: 20px;
    color:#fff;
}
.mgt10 {
    margin-top: 30px !important;
}

.pw-confirm{
    background: #064663;
    border-style:none;
    border-bottom:solid 2px #cacaca;
    border-collapse:collapse;
}
input{
	color: #e79b36; 
}
.pw-confirm input:focus {
    outline: none;
    padding-bottom : 5px;
/*     border-radius: 10px 10px 0 0; */
	border-bottom : 2px solid #e79b36;
/*     box-shadow: 0 1px 0 0 #e79b36; */
}
dd {
    float: right;
    margin-top: -50px;
    margin-right: 150px;
}
</style>

</html>