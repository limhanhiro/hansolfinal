<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아카데미 관리자 페이지</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="/resources/hansolCss/hansol_academyAdmin.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/jquery-ui/jquery-ui.css">
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<script type="text/javascript" src="/resources/jquery-ui/jquery-ui.min.js"></script>
	<jsp:include page="/WEB-INF/views/common/adminpageMenu.jsp"/>
	<div class="container">        
        <div class="mypage-title"><span>수업</span>관리</div>
        <div class="mypage-container">
        	<div class="listNavi">
	    		<div><h4>진행중인 수업</h4></div>
	    		<div><h4>지난 수업</h4></div>
	    		<div><h4>삭제 수업</h4></div>
	    	</div>
			<div class="academyBox">
			<c:if test="${empty list }">
			<h4>진행 중인 수업이  없습니다</h4>
			</c:if>
	        	<c:forEach items="${list }" var="ac">
	        		<div class="academyList">
		                <img src="${ac.academyPhoto }" class="poster">
		                <div style="width: 800px;">
			                <h4><strong>수업명 : ${ac.academyTitle }</strong></h4>
			                <h4>담당 선생님 : ${ac.academyTeacher }</h4>
			                <p>전시기간 : ${ac.academyStart } ~ ${ac.academyEnd }</p>	 
			                <a href="/academyView.do?academyNo=${ac.academyNo }" class="btn btn-default">상세보기</a>
		                </div>
		                <div class="reservList">
		                		<button class="btn countStudent" style="margin-left: 5px" academyNo="${ac.academyNo }" onfocus="this.blur()">학생수 조회</button>
		                	<div class="academy">
		                	</div>
		                </div>
		                <div>
		                	<button  class="btn deleteAcademy" academyNo="${ac.academyNo }">수업 삭제</button>
		         
		                </div>
	        		</div>
	        	</c:forEach>
        	</div>
        	<div class="lastAcademyBox">
        	<c:if test="${empty last }">
			<h4>기간이 지난 수업이  없습니다</h4>
			</c:if>
	        	<c:forEach items="${last }" var="acl">
	        		<div class="academyList">
		                <img src="${acl.academyPhoto }" class="poster">
		                <div style="width: 800px;">
			               	<h4><strong>수업명 : ${acl.academyTitle }</strong></h4>
			                <h4>담당 선생님 : ${acl.academyTeacher }</h4>
			                <p>수업기간 : ${acl.academyStart } ~ ${acl.academyEnd }</p>	 
			                <a href="/academyView.do?academyNo=${acl.academyNo }" class="btn btn-default">상세보기</a>
		                </div>
		                 <div class="reservList">
		                		<button class="btn countStudent" style="margin-left: 5px" academyNo="${acl.academyNo }" onfocus="this.blur()">학생수 조회</button>
		                	<div class="academy">
		                	</div>
		                </div>
		                <div>
		                	<button class="btn deleteAcademy" academyNo="${acl.academyNo }">수업 삭제</button>
		                	
		                </div>
	        		</div>
	        	</c:forEach>
        	</div>
        	<div class="cancelAcademyBox">
        	<c:if test="${empty cancel }">
			<h4>내린 지난 수업이  없습니다</h4>
			</c:if>
	        	<c:forEach items="${cancel }" var="acc">
	        		<div class="academyList">
		                <img src="${acc.academyPhoto }" class="poster">
		                <div style="width: 800px;">
			                <h4><strong>수업명 : ${acc.academyTitle }</strong></h4>
			                <h4>담당 선생님 : ${acc.academyTeacher }</h4>
			                <p>수업기간 : ${acc.academyStart } ~ ${acc.academyEnd }</p>	 
			                <a href="/academyView.do?academyNo=${acc.academyNo }" class="btn btn-default">상세보기</a>
		                </div>
		                <div>
		                	<button class="btn btn-danger revivalAcademy" academyNo="${acc.academyNo }" style="margin-right: 20px;">수업 소생</button>
		                	<button type = "button" class ="btn refundStudent" data-toggle="modal" data-target="#myModal" academyNo="${acc.academyNo }" onfocus="this.blur()">환불 회원 보기</button>
		                </div>
	        		</div>
	        	</c:forEach>
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
        </div>
	</div>
	<script>

	$(".refundStudent").click(function(){
		var academyNo = $(this).attr("academyNo");
		$.ajax({
			url : "/refundStudentView.do",
			data : {academyNo:academyNo},
			success : function(data){
				$(".modal-body").empty();
				var modal = "";
				if(data.length < 1){
					modal += "<p>환불이 필요한 회원이 없습니다</p>";
					$(".modal-body").append(modal);
				}else{
					modal += "<table class='table table-bordered table-hover'><tr><th>주문번호</th><th>이름</th><th>이메일</th></tr>";
					for( var i=0; i<data.length; i++ ){
						modal += "<tr><td>"+data[i].paymentNo+"</td>";
						modal += "<td>"+data[i].memberName+"</td>";
						modal += "<td>"+data[i].memberEmail+"</td>";
						modal += "</tr>";
					}
					modal += "</table>";
					$(".modal-body").append(modal);
				}
			}			
		});
	});
	$(".revivalAcademy").click(function(){
		var academyNo = $(this).attr("academyNo");
		swal({
			  title: "수업 살리기",
			  text: "수업을 살리겠습니까??",
			  icon: "success",
			  buttons: true,
			  dangerMode: true,
			})
			.then((email) => {
			  if (email) {
				  location.href="/revivalAcademy.do?academyNo="+academyNo;
			  } else {
			    swal("수업 소생 취소");
			  }
		});
	});
		$(".deleteAcademy").click(function(){
			var academyNo = $(this).attr("academyNo");
    	swal({
			  title: "수업 내리기",
			  text: "수업을  내리시겠습니까??",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((email) => {
			  if (email) {
				  location.href="/deleteAcademy.do?academyNo="+academyNo;
			  } else {
			    swal("수업 종료 취소");
			  }
			});
		});
		$(".countStudent").click(function(){
			var academyNo = $(this).attr("academyNo");
			var message = "";
			var idx = $(".countStudent").index(this);
			$(".academy").eq(idx).empty();
			$.ajax({
				url : "/countingStar.do",
				data : {academyNo:academyNo},
				success : function(data){
					if(data == "0"){
						$(".academy").eq(idx).append("<h4>수강중인 학생이 없습니다.</h4>");
					}else{
						$(".academy").eq(idx).append("<h4>수강중인 학생:"+data+"명</h4>");
					}
					
				}
			});
		});
		$(function() {
		$(".listNavi>div").click(function() {
			$(".listNavi>div").children().removeClass("selec");
            $(this).children().addClass("selec");
            $(".listNavi").nextAll().hide();
            if($(this).index() == 0){
                $(".academyBox").show();
            }else if($(this).index() == 1){
            	$(".lastAcademyBox").show();
            }else{
                $(".cancelAcademyBox").show();
            }
		});
			$(".listNavi>div").first().click();
		});
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>