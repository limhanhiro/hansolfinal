<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제기준</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
	<div class="container">        
        <div class="mypage-title"><span>회</span>원탈퇴 </div>
        <div class="mypage-container" style="">
        <p class="cb" style="display:none;"><span>${list.size() }</span></p>
			<div class="deletem" style="display:none;">
				탈퇴하시겠습니까?
				<a href="/deleteMember.do?memberNo=${m.memberNo}">
				<br>넹 바로할래요</a><br>
				<a href="/">아뇨,다시생각해볼래요</a>
			</div>
			
			<c:if test="${list.size() != 0}">
				<c:forEach items="${list}" var="md" >
					<c:choose>
						<c:when test="${md.selectNo eq 1}">
						<div class="delete_box">
							<div class="l-box">
		 						<a href="#">진행중인 공연 예매가 있습니다.</a>	
		                      	<p>예약번호 : ${md.reserveNo}</p>
								<p>공연제목 : ${md.reserveTitle}</p>
		                        <p>예약날짜 : ${md.reserveDate}</p>              
		                    </div>
		                    <div class="r-box">
		                      	<button class="nextBtn" onclick="deletemShow(this,'${md.reserveNo}');">취소하기</button>
							</div>
						</div>
						</c:when>
						<c:when test="${md.selectNo eq 2}">
							<div class="delete_box">
							<div class="l-box">
		 						<a href="#">대관진행이 있습니다.</a>	
		                      	<p>예약번호 : ${md.reserveNo}</p>
								<p>대관장소 : ${md.reserveTitle}</p>
		                        <p>예약날짜 : ${md.reserveDate}</p>              
		                    </div>
		                    <div class="r-box">
		                        <button class="nextBtn" onclick="deletemSpace(this,'${md.reserveNo}');">취소하기</button>
							</div>
							</div>
						</c:when>
						<c:when test="${md.selectNo eq 3}">
						<div class="delete_box">
							<div class="l-box">
		 						<a href="#">예약된 열람실이 있습니다.</a>	
		                      	<p>예약번호 : ${md.reserveNo}</p>
								<p>공연제목 : ${md.reserveTitle}</p>
		                        <p>예약날짜 : ${md.reserveDate}</p>              
		                    </div>
		                    <div class="r-box">
		                        <button class="nextBtn" onclick="deletemRead(this,'${md.reserveNo}');">취소하기</button>
							</div>
						</div>
						</c:when>
						<c:when test="${md.selectNo eq 4}">
												<div class="delete_box">
							<div class="l-box">
		 						<a href="#">수강중인 수업이 있습니다.</a>	
		                      	<p>예약번호 : ${md.reserveNo}</p>
								<p>공연제목 : ${md.reserveTitle}</p>
		                        <p>예약날짜 : ${md.reserveDate}</p>              
		                    </div>
		                    <div class="r-box">
		                        <button class="nextBtn" onclick="deletemAcademy(this,'${md.reserveNo}');">취소하기</button>
							</div>
						</div>
						</c:when>
						<c:when test="${md.selectNo eq 5}">
												<div class="delete_box">
							<div class="l-box">
		 						<a href="#">전시예매 내역이 있습니다.</a>	
		                      	<p>예약번호 : ${md.reserveNo}</p>
								<p>공연제목 : ${md.reserveTitle}</p>
		                        <p>예약날짜 : ${md.reserveDate}</p>              
		                    </div>
		                    <div class="r-box">
		                        <button class="nextBtn" onclick="deletemExhibition(this,'${md.reserveNo}');">취소하기</button>
							</div>
						</div>
						</c:when>
					</c:choose>
				</c:forEach>	
			</c:if>
		
        </div>
	</div>
	<script>
	function deletemShow(obj, reserveNo) {
		var md_tbl = '';
		$.ajax({
			url : "/deletemShow.do",
			data : {reserveNo : reserveNo},
			type : "post",
			success : function(data) {
				if(data == 0){
					alert("삭제실패");
				}else{
					alert("삭제성공");
					$(obj).parent().parent().fadeOut(300,function(){
						$(this).remove();
						$('.cb>span').html($('.cb>span').html()-1);
						deleteBox();
					})
				}
			}
		});
	}
	function deletemSpace(obj, reserveNo) {
		var md_tbl = '';
		$.ajax({
			url : "/deletemSpace.do",
			data : {reserveNo : reserveNo},
			type : "post",
			success : function(data) {
				if(data == 0){
					alert("삭제실패");
				}else{
					alert("삭제성공");
					$(obj).parent().parent().fadeOut(300,function(){
						$('.cb>span').html($('.cb>span').html()-1);
						$(this).remove();
						deleteBox();
					})
				}
			}
		});
	}
	function deletemRead(obj, reserveNo) {
		var md_tbl = '';
		$.ajax({
			url : "/deletemRead.do",
			data : {reserveNo : reserveNo},
			type : "post",
			success : function(data) {
				if(data == 0){
					alert("삭제실패");
				}else{
					alert("삭제성공");
					$(obj).parent().parent().fadeOut(300,function(){
						$('.cb>span').html($('.cb>span').html()-1);
						$(this).remove();
						deleteBox();
					})
				}
			}
		});
	}
	function deleteBox(){
		if($('.cb>span').html() == 0){
			$('.deletem').css('display','block');
		}
	}
	function deletemAcademy(obj, reserveNo) {
		var md_tbl = '';
		$.ajax({
			url : "/deletemAcademy.do",
			data : {reserveNo : reserveNo},
			type : "post",
			success : function(data) {
				if(data == 0){
					alert("삭제실패");
				}else{
					alert("삭제성공");
					$(obj).parent().parent().fadeOut(300,function(){
						$('.cb>span').html($('.cb>span').html()-1);
						$(this).remove();
						deleteBox();
					})
				}
			}
		});
	}
	function deletemExhibition(obj, reserveNo) {
		var md_tbl = '';
		$.ajax({
			url : "/deletemExhibition.do",
			data : {reserveNo : reserveNo},
			type : "post",
			success : function(data) {
				if(data == 0){
					alert("삭제실패");
				}else{
					alert("삭제성공");
					$(obj).parent().parent().fadeOut(300,function(){
						$('.cb>span').html($('.cb>span').html()-1);
						$(this).remove();
						deleteBox();
					})
				}
			}
		});
	}
	deleteBox();
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
</body>
<style>
.delete_box{
	border-radius: 15px;
	border: 1px solid #064663;
	display : flex;
	justify-content: space-around;
	align-items: center;
	padding-top : 20px;
	padding-bottom : 20px;
	margin-bottom: 3px;
}
.l-box{
 	width:60%;
 	
}
.l-box>p{
	margin-bottom: 0;
}
.l-box>a{
    text-decoration: none;
    font-weight: bold;
    color:#064663;
}
.l-box>*{
	margin-bottom: 5px;
	margin-top:5px;
}
.r-box{
	width:20%;
	display: flex;
	justify-content: center;
	align-items: center;
}
.nextBtn {
    width: 80px;
    height: 35px;
    margin-left:10px;
    background-color: #fff;
    border: none;
    outline: 1px solid;
    cursor: pointer;
    color: #064663;
    font-size: 14px;
}
.nextBtn:hover{
	transition-duration:1s;
	color: #fff;
	background-color: #064663;
}
</style>
</html>