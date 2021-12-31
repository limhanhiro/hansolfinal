<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디비번찾기</title>
<link rel="stylesheet" href="/resources/memberCss/login.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container">
		<div class="login-title"><span>비밀</span>번호 변경</div>
		<div class="login-box" style="width:600px">
		<form action="/searchidpw.do" method="post">
			<fieldset>
					<label for ="memberId" class="reg">ID</label><input type="text" name="memberId" value="${sessionScope.m.memberId}"><br><br>
					<label for="memberPassword" class="reg"> PW </label>
					<input type="password" class="input" name="memberPassword" id="memberPassword"> <span id="pw-detail"> 8~12자 이내 영문,숫자,특수문자(“”-+/\:; 제외)</span> <span id="pwChkRule"></span><br><br>
					<label for="pw_re" class="reg"> 확인 </label>
					<input type="password" class="input" name="pw_re" id="chkpw" onfocusout="chkPw(this);"> <span id="pwChk"></span>
					<input type="submit" value="변경">
					<input type="hidden" name="memberEmail" value="${sessionScope.m.memberEmail}">
				</fieldset>
		</form>
	</div>
	</div>
	<script>
	//비밀번호 여부
	function chkPw(obj) {
		var pwChk = document.getElementById("pwChk");
		var pw = document.getElementsByName("memberPassword")[0].value;
		var pwRe = obj.value;
	
		
			
		if (pwRe == "") {
			pwChk.innerHTML = "";
			pwCheck = false;
		} else if (pw != pwRe) {
			pwChk.innerHTML = "패스워드가 일치하지 않습니다.";
			pwChk.style.color = "red";
			obj.style.border = "1px solid red";
			pwCheck = false;
		} else {
			pwChk.innerHTML = "패스워드가 일치합니다.";
			pwChk.style.color = "#1f4787";
			obj.style.border = "1px solid #1f4787";
			pwCheck = true;
		}
	}
	var memberPwchk = true;
	$("[name=memberPassword]").eq(0).keyup(function() {
		var memberPassword = $(this).val();
		// (알파벳 하나)(숫자 하나)(특수문자 하나)(문자열)
		 var regExpPw = /(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,12}/; 
		/*  var regExpPw = /^[a-zA-Z0-9]{8,12}$/; */
		 
		if (regExpPw.test(memberPassword)){
			$('#pwChkRule').html("사용가능한 비밀번호입니다.");
			$('#pwChkRule').css('color' ,"#1f4787");
			memberPwchk = true;
			
		}else{
			$('#pwChkRule').html("비밀번호는  8~12자 이내 영문,숫자,특수문자로 입력해주세요.");
			$('#pwChkRule').css('color' ,"red");
			memberPwchk = false;
		}
	});
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>