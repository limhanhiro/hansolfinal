<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아카데미 목록</title>
 	<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
    <link href="resources/hansolCss/hansol_academy.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 <div class="container">
	 <!-- 카테고리  -->
		<div class="category">
			<ul id="gnb">
				<li class="cate_btn all">
					<a href="/academyList.do?reqPage=4&category=all">
						# 전체
					</a>
				</li>
				<c:forEach items="${acList}" var="acc">
					<li class="cate_btn">
						<a class="categorysearch" category="${acc.academyCategory }">																	
	                    	# ${acc.academyCategory}
	                    </a>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="search">
			<div class="search_text">
			</div>
				<div class="search_bar">
					<input type="text" id="keyWord" placeholder="원하는 수업명 또는 내용을 입력해주세요.">
					<button id="search" type="button" class="search_btn"><img src="/resources/exhibitionImage/icon/search.png"></button>
				</div>
		</div>
		<c:if test="${sessionScope.m.memberLevel eq 0 }">
			<button class="btn" id="insertAcademy" onfocus="this.blur()">수업 등록하기</button>
		</c:if>
		<ul class="mainmenu">
		<c:forEach items="${list }" var="a" >
			<li class="academy">
				<div class="academyImg">
					<a href="/academyView.do?academyNo=${a.academyNo }"> 
					<img src="${a.academyPhoto }">
					</a>
				</div>
 				<div class="info">
					<p data-toggle="tooltip" title="${a.academyTitle }">${a.academyTitle }</p>
					<p>기간: ${a.academyStart } ~ ${a.academyEnd }</p>
					<p>강사 : ${a.academyTeacher }</p>
					<p>수업료 : ${a.academyPrice } 원</p>
					<p>
					<c:if test="${sessionScope.m.memberLevel eq 0 }"> 
						<button type = "button" class ="btn studentView" data-toggle="modal" data-target="#myModal" academyNo="${a.academyNo }" onfocus="this.blur()">참여인원보기</button>
					</c:if>
					</p>
					<c:if test="${sessionScope.m.memberLevel eq 0 }"> 
					<div class="infoButton">
						<button class="btn academyView" academyNo="${a.academyNo }" onfocus="this.blur()">상세보기</button><button class="btn academyUpdate" academyNo="${a.academyNo }" onfocus="this.blur()">수정하기</button>
					</div>
					</c:if>
				</div>	
			</li>
		</c:forEach>
		</ul>
		<c:if test="${count < totalCount}">
		<button class="btn moreBtn" id="more" currentCount="4" totalCount="${totalCount }" value="4" search="all" onfocus="this.blur()">더보기</button>
		</c:if>
		<input type="hidden" id="totalCount" value="${totalCount }">
		<input type="hidden" id="memberLevel" value="${sessionScope.m.memberLevel }">
		<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog" style="width: 700px;">
    
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">수강중인 학생 목록</h4>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
      
    </div>
  </div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script>
		var totalCount = $("#totalCount");
		var memberLevel = $("#memberLevel").val();
		$(document).on(function(){
			  $('[data-toggle="tooltip"]').tooltip({placement: "bottom"});  
			});
		$(document).on("click",".studentView",function(){
			var academyNo = $(this).attr("academyNo");
			$.ajax({
				url : "/studentView.do",
				data : {academyNo:academyNo},
				success : function(data){
					$(".modal-body").empty();
					var modal = "";
					if(data.length < 1){
						modal += "<p>아직 수강중인 학생이 없습니다</p>";
						$(".modal-body").append(modal);
					}else{
						modal += "<table class='table table-bordered table-hover'><tr><th>No.</th><th>학생이름</th><th>연락처</th><th>상태</th></tr>";
						for( var i=0; i<data.length; i++ ){
							modal += "<tr><td>"+data[i].count+"</td>";
							modal += "<td>"+data[i].memberName+"</td>";
							modal += "<td>"+data[i].memberEmail+"</td>";
							if(data[i].paymentCancel == 1){
								modal += "<td>수강 취소</td>";
							}else{
								modal += "<td>진행중</td>";
							}
							modal += "</tr>";
						}
						modal += "</table>";
						$(".modal-body").append(modal);
					}
				}			
			});
		});
		//$(document).on("click",".btn",function(){
		//});
		$(document).on("click",".academyView",function(){
			var academyNo = $(this).attr("academyNo");
			location.href="/academyView.do?academyNo="+academyNo;
		});
		$(document).on("click",".academyUpdate",function(){
			var academyNo = $(this).attr("academyNo");
			location.href="/academyUpdateFrm.do?academyNo="+academyNo;
		});
		$(document).on("click",".academyDelete",function(){
			var academyNo = $(this).attr("academyNo");
			location.href="/academyDelete.do?academyNo="+academyNo;
		});
		$("#more").click(function(){
			var memberLevel = $("#memberLevel").val();
			var start = $(this).val();
			var category = $("#more").attr("search");
			var type = $("#more").attr("class");
			if(type == "btn moreBtn"){
			$.ajax({
				url : "/moreAcademy.do",
				data : {start:start,category:category},
				success : function(data){
					for(var i=0;i<data.length;i++){
						var moreLi = "";
						moreLi += "<li class='academy'>";
						moreLi += "<div class='academyImg'>"
						moreLi += "<a href='/academyView.do?academyNo="+data[i].academyNo+"'>";
						moreLi += "<img src='"+data[i].academyPhoto+"'></a></div>";
						moreLi += "<div class='info'>";
						moreLi += "<p data-toggle='tooltip' title='"+data[i].academyTitle+"'>"+data[i].academyTitle+"</p>";
						moreLi += "<p>수업 기간: "+data[i].academyStart+"~"+data[i].academyEnd+"</p>";
						moreLi += "<p>강사: "+data[i].academyTeacher+"</p>";
						moreLi += "<p>수업료: "+data[i].academyPrice+"원</p>";
						moreLi += "<p>"
						if(memberLevel == ""){
							moreLi += "</div></div></li>";
						}else{
						if(memberLevel == 0){
						moreLi += "<button type ='button' class ='btn studentView' data-toggle='modal' data-target='#myModal' academyNo='"+data[i].academyNo+"' onfocus='this.blur()'>참여인원보기</button>";
						}
						moreLi += "</p><div class = 'infoButton'>";
						if(memberLevel == 0){
						moreLi += "<button class='btn academyView' academyNo='"+data[i].academyNo+"'onfocus='this.blur()'>상세보기</button><button class='btn academyUpdate' academyNo='"+data[i].academyNo+"' onfocus='this.blur()'>수정하기</button>";
						}
						moreLi += "</div></div></li>";
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
						$("#more").val(4);
					}
					
				}
			});
		}else{
			$.ajax({
				url : "/searchMoreAcademy.do",
				data : {start:start,category:category},
				success : function(data){
					for(var i=0;i<data.length;i++){
						var moreLi = "";
						moreLi += "<li class='academy'>";
						moreLi += "<div class='academyImg'>"
						moreLi += "<a href='/academyView.do?academyNo="+data[i].academyNo+"'>";
						moreLi += "<img src='"+data[i].academyPhoto+"'></a></div>";
						moreLi += "<div class='info'>";
						moreLi += "<p data-toggle='tooltip' title='"+data[i].academyTitle+"'>"+data[i].academyTitle+"</p>";
						moreLi += "<p>수업 기간: "+data[i].academyStart+"~"+data[i].academyEnd+"</p>";
						moreLi += "<p>강사: "+data[i].academyTeacher+"</p>";
						moreLi += "<p>수업료: "+data[i].academyPrice+"원</p>";
						moreLi += "<p>"
							if(memberLevel == ""){
								moreLi += "</div></div></li>";
							}else{
							if(memberLevel == 0){
							moreLi += "<button type ='button' class ='btn studentView' data-toggle='modal' data-target='#myModal' academyNo='"+data[i].academyNo+"' onfocus='this.blur()'>참여인원보기</button>";
							}
							moreLi += "</p><div class = 'infoButton'>";
							if(memberLevel == 0){
							moreLi += "<button class='btn academyView' academyNo='"+data[i].academyNo+"' onfocus='this.blur()'>상세보기</button><button class='btn academyUpdate' academyNo='"+data[i].academyNo+"' onfocus='this.blur()'>수정하기</button>";
							}
							moreLi += "</div></div></li>";
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
						$("#more").val(4);
					}
					
				}
			});
		}
		});
		$(".categorysearch").click(function(){
			$("#more").removeClass("searchMore");
			$("#more").addClass("moreBtn");
			$("#more").html("더보기");
			$("#more").css("display","block");
			$("#more").attr("currentCount",4);
			var reqPage = 4;
			var category = $(this).attr("category");
			$.ajax({
				url : "/categoryAcademy.do",
				data : {category:category,reqPage:reqPage},
				success : function(data){
					if(data.length < 1){
						$(".mainmenu").empty();
						var none = " <span class='nonebox'><img src='/resources/exhibitionImage/icon/comingsoon.png'><h3>원하시는 조건의 수업이  없습니다.</h3></span>";
						$("#more").css("display","none");
						$("#more").prop("diabled",true);
						$("#more").val(4);
						$(".mainmenu").append(none);
					}else{
					$(".mainmenu").empty();
					for(var i=0;i<data.length;i++){
						var moreLi = "";
						moreLi += "<li class='academy'>";
						moreLi += "<div class='academyImg'>"
						moreLi += "<a href='/academyView.do?academyNo="+data[i].academyNo+"'>";
						moreLi += "<img src='"+data[i].academyPhoto+"'></a></div>";
						moreLi += "<div class='info'>";
						moreLi += "<p data-toggle='tooltip' title='"+data[i].academyTitle+"'>"+data[i].academyTitle+"</p>";
						moreLi += "<p>수업 기간: "+data[i].academyStart+"~"+data[i].academyEnd+"</p>";
						moreLi += "<p>강사: "+data[i].academyTeacher+"</p>";
						moreLi += "<p>수업료: "+data[i].academyPrice+"원</p>";
						moreLi += "<p>"
							if(memberLevel == ""){
								moreLi += "</div></div></li>";
							}else{
							if(memberLevel == 0){
							moreLi += "<button type ='button' class ='btn studentView' data-toggle='modal' data-target='#myModal' academyNo='"+data[i].academyNo+"' onfocus='this.blur()'>참여인원보기</button>";
							}
							moreLi += "</p><div class = 'infoButton'>";
							if(memberLevel == 0){
							moreLi += "<button class='btn academyView' academyNo='"+data[i].academyNo+"' onfocus='this.blur()'>상세보기</button><button class='btn academyUpdate' academyNo='"+data[i].academyNo+"' onfocus='this.blur()'>수정하기</button>";
							}
							moreLi += "</div></div></li>";
							}
						$(".mainmenu").append(moreLi);
					}
					var totalCount = data[0].totalCount;
					$("#more").attr("totalCount",totalCount);
					$("#more").attr("search",category);
					var search = $("#more").attr("search");
					totalCount = $("#more").attr("totalCount");
					var currCount = $("#more").attr("currentCount");
					if(totalCount <= 4){
						$("#more").css("display","none");
						$("#more").prop("diabled",true);
					}
				}
				}
			});
		});
		$("#search").click(function(){
			$("#more").css("display","block");
			$("#more").attr("currentCount",4);
			var reqPage = 4;
			var keyWord = $("#keyWord").val();
			$.ajax({
				url : "/searchAcademy.do",
				data : {keyWord:keyWord,reqPage:reqPage},
				success : function(data){
					if(data.length < 1){
						$(".mainmenu").empty();
						var none = " <span class='nonebox'><img src='/resources/exhibitionImage/icon/comingsoon.png'><h3>원하시는 조건의 수업이  없습니다.</h3></span>";
						$("#more").css("display","none");
						$("#more").prop("diabled",true);
						$("#more").val(4);
						$(".mainmenu").append(none);
					}else{
					$(".mainmenu").empty();
					for(var i=0;i<data.length;i++){
						var moreLi = "";
						moreLi += "<li class='academy'>";
						moreLi += "<div class='academyImg'>"
						moreLi += "<a href='/academyView.do?academyNo="+data[i].academyNo+"'>";
						moreLi += "<img src='"+data[i].academyPhoto+"'></a></div>";
						moreLi += "<div class='info'>";
						moreLi += "<p data-toggle='tooltip' title='"+data[i].academyTitle+"'>"+data[i].academyTitle+"</p>";
						moreLi += "<p>수업 기간: "+data[i].academyStart+"~"+data[i].academyEnd+"</p>";
						moreLi += "<p>강사: "+data[i].academyTeacher+"</p>";
						moreLi += "<p>수업료: "+data[i].academyPrice+"원</p>";
						moreLi += "<p> "
							if(memberLevel == ""){
								moreLi += "</div></div></li>";
							}else{
							if(memberLevel == 0 ){
							moreLi += "<button type ='button' class ='btn studentView' data-toggle='modal' data-target='#myModal' academyNo='"+data[i].academyNo+"' onfocus='this.blur()'>참여인원보기</button>";
							}
							moreLi += "</p><div class = 'infoButton'>";
							if(memberLevel == 0){
							moreLi += "<button class='btn academyView' academyNo='"+data[i].academyNo+"' onfocus='this.blur()'>상세보기</button><button class='btn academyUpdate' academyNo='"+data[i].academyNo+"' onfocus='this.blur()'>수정하기</button>";
							}
							moreLi += "</div></div></li>";
							}
						$(".mainmenu").append(moreLi);
					}
					var totalCount = data[0].totalCount;
					$("#more").attr("totalCount",totalCount);
					$("#more").attr("search",keyWord);
					var search = $("#more").attr("search");
					totalCount = $("#more").attr("totalCount");
					var currCount = $("#more").attr("currentCount");
					if(totalCount <= 4){
						$("#more").css("display","none");
						$("#more").prop("diabled",true);
						
					}else{
						$("#more").html("검색 결과 더보기");
						$("#more").addClass("searchMore");
						$("#more").removeClass("moreBtn");
					}
				}
				}
			});
			
		});
		$(document).ready(function(){
			$("#gnb li").removeClass("on");
			$(".all").closest("li").addClass("on");
			$(".categorysearch").click(function(){
				$(".search_text").empty();
				var category = $(this).attr("category");
				var title = "";
				$("#gnb li").removeClass("on");
				$(this).closest("li").addClass("on");
				$(".search_bar").css("display","none");
				title += "<h1 style='margin-left : 50px;'><span class='line'>"+category+"</span></h1>";
				$("#insertAcademy").css("margin-top","87px")
				$(".search_text").append(title);
			});
			
		});
		$("#insertAcademy").click(function(){
			location.href= "/academyFrm.do";
		});
	</script>
</body>
</html>