<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전시 목록</title>
 	<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
    <link href="resources/hansolCss/hansol_exhibition.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 <div class="container">
	 	<c:if test="${sessionScope.m.memberLevel eq 0 }">
			<button class="btn hsBtn1" id="exhibitionInsert" style="margin-top: 20px;" onfocus="this.blur()">전시 등록하기</button>
		</c:if>
		<c:if test="${empty list }">
			<h3 style="margin-top: 200px;">진행중인 전시가 없습니다</h3>
		</c:if>
		<ul class="mainmenu">
		<c:forEach items="${list  }" var="ex" >
			<li class="exhibition">
				<div class="exhibitionImg">
					<a href="/exhibitionView.do?exhibitionNo=${ex.exhibitionNo }"> 
					<img src="${ex.exhibitionPhoto }">
					</a>
				</div>
 				<div class="info">
					<p data-toggle="tooltip" title="${ex.exhibitionTitle }">${ex.exhibitionTitle }</p>
					<p>전시 기간: ${ex.exhibitionStart } ~ ${ex.exhibitionEnd }</p>
					<p>전시 시간 : ${ex.exhibitionTimeStart } ~ ${ex.exhibitionTimeEnd }</p>
					<p>장소 : 무지다 미술관 </p>
					<p>수업료 : ${ex.exhibitionPrice }</p>
					<c:if test="${sessionScope.m.memberLevel eq 0 }"> 
					<div class="infoButton">
						<button class="btn exhibitionView" exhibitionNo="${ex.exhibitionNo }" onfocus="this.blur()">상세보기</button><button class="btn exhibitionUpdate" exhibitionNo="${ex.exhibitionNo }" onfocus="this.blur()">수정하기</button>
					</div>
					</c:if>
				</div>	
			</li>
		</c:forEach>
		</ul>
		<c:if test="${count < totalCount}">
		<button class="btn moreBtn" id="more" currentCount="4" totalCount="${totalCount }" value="4" onfocus="this.blur()">더보기 </button>
		</c:if>
		<input type="hidden" id="totalCount" value="${totalCount }">
		<input type="hidden" id="memberLevel" value="${sessionScope.m.memberLevel }">
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script>
		$(document).on(function(){
		  $('[data-toggle="tooltip"]').tooltip({placement: "bottom"});  
		});
		var totalCount = $("#totalCount");
		$(document).on("click",".exhibitionView",function(){
			var exhibitionNo = $(this).attr("exhibitionNo");
			location.href="/exhibitionView.do?exhibitionNo="+exhibitionNo;
		});
		$(document).on("click",".exhibitionUpdate",function(){
			var exhibitionNo = $(this).attr("exhibitionNo");
			location.href="/exhibitionUpdateFrm.do?exhibitionNo="+exhibitionNo;
		});
		$(document).on("click",".exhibitionDelete",function(){
			var exhibitionNo = $(this).attr("exhibitionNo");
			location.href="/exhibitionDelete.do?exhibitionNo="+exhibitionNo;
		});
		$("#more").click(function(){
			var start = $(this).val();
			var memberLevel = $("#memberLevel").val();
			$.ajax({
				url : "/moreExhibition.do",
				data : {start:start},
				success : function(data){
					var moreLi = "";
					for(var i=0;i<data.length;i++){
						var moreLi = "";
						moreLi += "<li class='exhibition'>";
						moreLi += "<div class='exhibitionImg'>"
						moreLi += "<a href='/exhibitionView.do?exhibitionNo="+data[i].exhibitionNo+"'>";
						moreLi += "<img src='"+data[i].exhibitionPhoto+"'></a></div>";
						moreLi += "<div class='info'>";
						moreLi += "<p data-toggle='tooltip' title='"+data[i].exhibitionTitle+"'>"+data[i].exhibitionTitle+"</p>";
						moreLi += "<p>전시 기간: "+data[i].exhibitionStart+"~"+data[i].exhibitionEnd+"</p>";
						moreLi += "<p>전시 시간: "+data[i].exhibitionTimeStart+"~"+data[i].exhibitionTimeEnd+"</p>";
						moreLi += "<p>장소: 무지다 미술관</p>";
						moreLi += "<p>금액: "+data[i].exhibitionPrice+"</p>";
						if(memberLevel == ""){
							moreLi += "</div></div></li>";
						}else{
						if(memberLevel == 0){
							moreLi += "<div class = 'infoButton'>";
							moreLi += "<button class='btn exhibitionView' exhibitionNo='"+data[i].exhibitionNo+"' onfocus='this.blur()'>상세보기</button><button class='btn exhibitionUpdate' exhibitionNo='"+data[i].exhibitionNo+"' onfocus='this.blur()'>수정하기</button>";
							moreLi += "</div></div></li>";
						}else{
							moreLi += "</div></div></li>";
						}
						}
						$(".mainmenu").append(moreLi);
					}
					$("#more").val(Number(start)+2);
					var curr = Number($("#more").attr("currentCount"));
					$("#more").attr("currentCount",curr + data.length);
					var totalCount = $("#more").attr("totalCount");
					var currCount = $("#more").attr("currentCount");
					if(currCount == totalCount){
						$("#more").css("display","none");
						$("#more").prop("diabled",true);
					}
					
				}
			});
		});
		$("#exhibitionInsert").click(function(){
			location.href= "/exhibitionFrm.do";
		});
	</script>
</body>
</html>