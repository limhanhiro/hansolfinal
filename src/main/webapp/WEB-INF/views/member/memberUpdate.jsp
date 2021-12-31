<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="/resources/memberCss/join.css">
<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"	src="http://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
	
	<div class="container">        
        <div class="mypage-title"><span>개</span>인정보관리</div>
        <div class="mypage-container">
				<form action="/memberUpdate.do" class="contentDetail"method="post" id="contentDetail-field" onsubmit="return emailChk()" >
						<table class="inputTbl">
							<tr>
								<td>아이디</td>
								<td><input type="text" class="input" name="memberId"
								value="${sessionScope.m.memberId}" readonly></td>
							</tr>
							<tr>
								<td>이름</td>
								<td><input type="text" class="input short3" name="memberName" 
								value="${sessionScope.m.memberName}" readonly></td>
							</tr>
							<tr>
								<td>비밀번호변경</td>
								<td><a type="text" id="searchidpw" data-toggle="modal" data-target="#sModal">비밀번호 변경하기</a></td>
							</tr>
							
							<tr>
								<td>휴대전화번호</td>
								<td><input type="text" class="input" name="memberPhone" value="${sessionScope.m.memberPhone}" readonly>
								</td>
							</tr>
							<tr>
								<td>생년월일</td>
								<td><input type="text" class="input" id="memberBirthday" name="memberBirthday" class="mypagecontrol" value="${m.memberBirthday}" readonly></td>
							</tr>
							<tr>
								<td>주소입력</td>
								<td><input type="text" id="postcode" class="input short3" name="postcode" value="${m.postcode}" readonly>
									<button onclick="addrSearch();" type="button" class="nextBtn">주소검색</button></td>
							</tr>
							<tr>
								<td></td>
								<td style="padding-top: 5px;"><input type="text"
									id="addressRoad" class="input long" name="addressRoad" value="${m.addressRoad}" readonly>
									<input type="text" id="addressDetail" style="background:#fff; border:1px solid #064663;" class="input long"
									name="addressDetail" value="${m.addressDetail}" ></td>
							</tr>
							<tr>
								<td>이메일</td>
								<td>
								<input type="text" class="input" id="email1" name="email1" value="${email1}" style="background:#fff; border:1px solid #064663;"> @ <input type="text" class="input" id="email2" name="email2" value="${email2}" style="background:#fff; border:1px solid #064663;"> 		
								<button type="button" onclick="checkEmail();" id="btnOpen1" class="nextBtn">중복체크</button>
									<span id="ajaxEmailcheck"></span>
									<div class="agreebox adcheck">
										<span id="authMsg"></span><input type="hidden"  value='1' id="emailchk">
										<div></div>
									</div>
								</td>
							</tr>
						</table>
						<div class="btnBox">
							<button  type="submit" class="nextBtn2">정보수정</button>
						</div>	
				</form>	

				<a href="/deleteMemberFrm.do?memberNo=${m.memberNo}" class="joinbtn">탈퇴하기 ></a>
				<form action="" id="modal1">
				<div id='content' class="modal_window">
					<div class="modal_window_text" id="auth">
						<div>
							<input type='button' value='X' class="close" id='btnClose1' />
						</div>
						<div>
							<!-- 인증 받으면 넘어가는 hidden-->
							<input type="hidden" id="emailcheck">
						</div>
						<div class="input_wrap">
							<div></div>
							<div id="search_input">
								<input type='text' id="authCode" class="search_input"
									placeholder="인증코드입력" /><span id="timeZone"></span>
							</div>
							<div>
								<span></span>
							</div>
						</div>
					</div>
					<div class="modal_window_btn">
						<div>
							<input type='button' value='조회' id='btnCheck1' class="nextBtn" />
						</div>
					</div>
				</div>
				</form>
	</div>	
</div>
	<script>
	function emailChk() {
		console.log($("#emailchk").val()); 
		if ($("#emailchk").val() == '1' && $("#email1") != '') {
				return true;
			} else {
				return false;
			}
		}
	$('#email1').change(function (){
		$("#emailchk").val('0');
	});
	$('#email2').change(function (){
		$("#emailchk").val('0');
	});
	function addrSearch() {
		new daum.Postcode({
			oncomplete : function(data) {
				$("#postcode").val(data.zonecode);
				$("#addressRoad").val(data.roadAddress);
				$("#addressDetail").focus();
			}
		}).open();
	}
	
	function checkEmail() {
		if ($('#emailchk').val() != '1'){
		var memberEmail = $('#email1').val() + '@' + $('#email2').val();
		$.ajax({
					url : "/ajaxEmailCheck.do",
					data : {memberEmail : memberEmail},
					type : "post",
					success : function(data) {
						if (data == 0) {
							$("#ajaxEmailcheck").html("");/* 
							$("#emailchk").val('1'); */
							console.log(memberEmail);
							//아이디 사용가능시 MODAL창 인증버튼시 팝업
							var btnOpen1 = document
									.getElementById('btnOpen1');
							var btnCheck1 = document
									.getElementById('btnCheck1');
							var btnClose1 = document
									.getElementById('btnClose1');

							// email check modal 창을 감춤
							var closeRtn1 = function() {
								var modal1 = document
										.getElementById('modal1');
								modal1.style.display = 'none';

							}
							// email check modal 창을 보여줌

							var modal1 = document.getElementById('modal1');
							var email = $('#email1').val() + '@'
									+ $('#email2').val();
							
							modal1.style.display = 'block';
							var mailCode = '';
							$.ajax({
								url : "/sendMail.do",
								data : {email : email},
								type : "post",
								success : function(data) {
									mailCode = data;
									authTime();
								}
							});

							btnCheck1.onclick = closeRtn1;
							btnClose1.onclick = closeRtn1;
							
							

							var intervalId;
							function authTime() {
								$("#timeZone")
										.html(
												"<span id='min'>3</span> : <span id='sec'>00</span>");
								intervalId = window.setInterval(function() {
									timeCount();
								}, 1000);
							}
							function timeCount() {
								var min = Number($("#min").html());
								var sec = $("#sec").html();
								if (sec == "00") {
									if (min == 0) {
										mailCode = null;
										clearInterval(intervalId);
									} else {
										$("#min").html(--min);
										$("#sec").html(59);

									}
								} else {
									var newSec = Number(sec);
									newSec--;
									if (newSec < 10) {
										$("#sec").html("0" + newSec);
									} else {
										$("#sec").html(newSec);
									}
								}
							}
							$("#btnCheck1").click(function() {
								if (mailCode == null) {
									$("#authMsg").html("인증 실패");
									$("#authMsg").css("color", "#BDB19A");
									$("#emailchk").val('2');
								} else {
									if ($("#authCode").val() == mailCode) {
										$("#authMsg").html("인증성공");
										$("#authMsg").css("color", "#BDB19A"); //여기다가 인증추가를 해야함
										$("#emailchk").val('1');
										
										clearInterval(intervalId);
										$("#timeZone").empty();
										$("#emailcheck").val('1');

									} else {
										$("#authMsg").html("인증코드를 확인하세요");
										$("#authMsg").css("color", "#BDB19A");
										$("#emailchk").val('2');
									}
								}

							})

						} else if (data == 1) {
							$("#ajaxEmailcheck").html("이미 사용중인 이메일 입니다.");
							$("#ajaxEmailcheck").css("color", "#BDB19A");
						}
					}
				});
		}
	};

	</script>
	
	
			<div class="modal" id="sModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h3 class="modal-title">새비밀번호입력</h3>
                    </div>
                    <!-- 이메일인증 modal -->
                    <div class="modal-body">
						<form action="/updatePassword.do" method="post">
							<fieldset>
									<label for="memberPassword" class="reg"> PW </label>
									<input type="password" class="input" name="memberPassword" id="memberPassword"><span id="pw-detail">(“”-+/\:; 제외)</span> <span id="pwChkRule"></span><br><br>
									<label for="pw_re" class="reg"> 확인 </label><input type="password" class="input" name="pw_re" id="chkpw"> <span id="pwChk"></span>
									<input type="submit" class="nextBtn"  value="변경">
									<input type="hidden" name="memberId" id="memberId" value="${sessionScope.m.memberId}">
									
							</fieldset>
						</form>
						</div>
						
					</div>
                  </div>
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
					obj.style.border = "1px solid #e79b36";
					pwCheck = false;
				} else {
					pwChk.innerHTML = "패스워드가 일치합니다.";
					pwChk.style.color = "#563D39";
					obj.style.border = "1px solid #e79b36";
					pwCheck = true;
				}
			}
			var memberPwchk = true;
			$("[name=memberPassword]").eq(0).keyup(function() {
				var memberPassword = $(this).val();
				// (알파벳 하나)(숫자 하나)(특수문자 하나)(문자열)
				 var regExpPw = /(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,20}/; 
				/*  var regExpPw = /^[a-zA-Z0-9]{8,12}$/; */
				 
				if (regExpPw.test(memberPassword)){
					$('#pwChkRule').html("사용가능한 비밀번호입니다.");
					$('#pwChkRule').css('color' ,"#e79b36");
					memberPwchk = true;
					
				}else{
					$('#pwChkRule').html("5자 이상 영문,숫자,특수문자로 입력");
					$('#pwChkRule').css('color' ,"#e79b36");
					memberPwchk = false;
				}
			});
			</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<style>
a:hover {
    color: #e79b36;
    text-decoration: underline;
    text-underline-position: under;
}
.joinbtn{
	float:right;
	border:none;
	font-size:15px;
    text-decoration: none;
	color:#064663;
	padding:7px;
	border-radius: 15px;
	margin: 0px 80px;
    font-weight: 800;
}
</style>
</html>