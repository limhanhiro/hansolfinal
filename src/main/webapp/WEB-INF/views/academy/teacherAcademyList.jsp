<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선생님 전용 페이지</title>
 	<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
    <link href="resources/hansolCss/hansol_academy.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 <div class="container">
	 <c:if test="${empty list }">
			<h3 style="margin-top: 200px;">진행중인 전시가 없습니다</h3>
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
					<p>${a.academyTitle }</p>
					<p>기간: ${a.academyStart } ~ ${a.academyEnd }</p>
					<p>강사 : ${a.academyTeacher }</p>
					<p>수업료 : ${a.academyPrice } 원</p>
					<p>
						<button type = "button" class ="btn studentView" data-toggle="modal" data-target="#myModal" academyNo="${a.academyNo }" onfocus="this.blur()">참여인원보기</button>
					</p>
					<div class="infoButton">
						<button class="btn academyView" academyNo="${a.academyNo }" onfocus="this.blur()">상세보기</button><button class="btn academyUpdate" academyNo="${a.academyNo }" onfocus="this.blur()">수정하기</button>
					</div>
				</div>	
			</li>
		</c:forEach>
		</ul>
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
		$(document).on("click",".academyView",function(){
			var academyNo = $(this).attr("academyNo");
			location.href="/academyView.do?academyNo="+academyNo;
		});
		$(document).on("click",".academyUpdate",function(){
			var academyNo = $(this).attr("academyNo");
			location.href="/academyUpdateFrm.do?academyNo="+academyNo;
		});
	</script>
</body>
</html>