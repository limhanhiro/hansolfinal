<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트</title> 
<link rel="stylesheet" href="/resources/additionCss/event.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container">
	<input type="hidden" id="memberLevel" value="${sessionScope.m.memberLevel }">
	<input type="hidden" id="memberId" value="${sessionScope.m.memberId }">
		<fieldset>
			<c:if test="${sessionScope.m.memberLevel==0 }">
				<div>
					<a href="/boardWriteFrm.do?boardType=5" id="writeBtn" class="btn btn-info writeBtn">글쓰기</a>
				</div>
			</c:if>
			<div class="news-title-box">
				<ul class="bg7">
					<li>당첨안내문자를 받으실 수 있도록 마이페이지 > 개인정보관리에서 본인의 휴대폰번호를 꼭 확인해주세요.</li>
				</ul>
			</div>
						<div class="photoWrapper">

						</div>
			
			
			
			
			<div id="btnBack">
			<button class="btn btn-outline-info" currentCount="0" 
			totalCount="${totalCount }" value="1" id="more-btn">이벤트 더보기</button>
			</div>
			<!--totalCount : 전체게시물 수
				currentCount : 실제로 가져온 게시물 수 
				value : 요청한 게시물 수(reqPage) -->
				
		</fieldset>
	</div>
	<script>
		$("#more-btn").click(function(){
			var start=$(this).val();
			$.ajax({
				url : "/eventMore.do",
				data : {start:start},
				type : "post",
				success : function(data){
					for(var i=0;i<data.length;i++){
						var p = data[i];
						var html ="";
						if(p.filepath!=null){
						html += "<div class='eventContent'>";
						html += "<a class='showchk' href='/boardView.do?boardType=5&boardNo="+p.boardNo+"'class='img'><img class='eventImg' src='/resources/additionImage/"+p.filepath+"' ></a>";
						html += "<h3 class='tit'>"+p.boardTitle+"</h3>";
						html += "<dl><dt>&nbsp;이벤트 기간</dt><dd>"+p.startDate+" ~ "+p.endDate+"</dd></dl>";
						html += "<dl><dt>&nbsp;당첨자 발표</dt><dd>"+p.endDate+"</dd></dl></div>";
						html += "<input type='hidden' class='announce' value="+p.endDate+">";
						$(".photoWrapper").append(html);
						}
					
					}
					//가지고 온 데이터를 화면에 출력한 후 다음 요청을 위한 값 변경
					$("#more-btn").val(Number(start)+3); //3
					//지금까지 읽오온 게시물의 수를 변경(읽어온 배열의 길이만큼 기존값에 더함)
					var curr=Number($("#more-btn").attr("currentCount")); //0
					$("#more-btn").attr("currentCount",curr+data.length); //2
					//전체게시물수 
					var totalCount = $("#more-btn").attr("totalCount");//4
					var currCount = $("#more-btn").attr("currentCount"); //2
					console.log(totalCount);
					console.log(currCount);
					if(totalCount==currCount){
						$("#more-btn").prop("disabled",true);
					}
			}
		});
		});
		$(function(){
			$("#more-btn").click();
		});
	
		$(document).on("click",".showchk",function(){
			var memberId=$("#memberId").val();
			if(memberId=="admin"){
				return true;
			}
			var idx=$(".showchk").index(this);
			var announce= $(".announce").eq(idx).val();
			var date = new Date();
	        var year = date.getFullYear().toString();
	        var month = date.getMonth() + 1;
	        month = month < 10 ? '0' + month.toString() : month.toString();
	        var day = date.getDate();
	        day = day < 10 ? '0' + day.toString() : day.toString();
	        date= year +'-'+ month+'-'+ day ;
			console.log(date);
			console.log(announce);
			if(date>announce){
				alert("종료된 이벤트 입니다");
				return false;
			}
			
			
	    });
		
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>