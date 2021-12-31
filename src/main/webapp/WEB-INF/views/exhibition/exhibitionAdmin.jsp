<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전시 관리자 페이지</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="/resources/hansolCss/hansol_exhibitionAdmin.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/jquery-ui/jquery-ui.css">
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<script type="text/javascript" src="/resources/jquery-ui/jquery-ui.min.js"></script>
	<jsp:include page="/WEB-INF/views/common/adminpageMenu.jsp"/>
	<div class="container">        
        <div class="mypage-title"><span>전시</span>관리</div>
        <div class="mypage-container">
        	<div class="listNavi">
	    		<div><h4>진행중인 전시</h4></div>
	    		<div><h4>지난 전시</h4></div>
	    		<div><h4>삭제한 전시</h4></div>
	    	</div>
			<div class="exhibitionBox">
			<c:if test="${empty list }">
			<h4>진행중인 전시가 없습니다</h4>
			</c:if>
	        	<c:forEach items="${list }" var="ex">
	        		<div class="exhibitionList">
		                <img src="${ex.exhibitionPhoto }" class="poster">
		                <div style="width: 800px;">
			                <h4><strong>전시명 : ${ex.exhibitionTitle }</strong></h4>
			                <h4>장소 : 무지다 미술관</h4>
			                <p>전시기간 : ${ex.exhibitionStart } ~ ${ex.exhibitionEnd }</p>	 
			                <a href="/exhibitionView.do?exhibitionNo=${ex.exhibitionNo }" class="btn btn-default">상세보기</a>
		                </div>
		                <div class="reservList">
		                	<input type="text" class="datepicker form-control" placeholder="날짜선택">
		                	<input type="hidden" value="${ex.exhibitionStart }">
		                	<input type="hidden" value="${ex.exhibitionEnd }">
		                	<input type="hidden" value="${ex.exhibitionNo }">
		                	<div class="exhibition"></div>
		                </div>
		                <div>
		                	<button  class="btn deleteExhibition" exhibitionNo="${ex.exhibitionNo }" >전시삭제</button>
		                </div>
	        		</div>
	        	</c:forEach>
        	</div>
        	<div class="lastExhibitionBox">
        	<c:if test="${empty last }">
			<h4>기간이 지난 전시가 없습니다</h4>
			</c:if>
	        	<c:forEach items="${last }" var="exl">
	        		<div class="exhibitionList">
		                <img src="${exl.exhibitionPhoto }" class="poster">
		                <div style="width: 800px;">
			                <h4><strong>전시명 : ${exl.exhibitionTitle }</strong></h4>
			                <h4>장소 : 무지다 미술관</h4>
			                <p>전시기간 : ${exl.exhibitionStart } ~ ${exl.exhibitionEnd }</p>	 
			                <a href="/exhibitionView.do?exhibitionNo=${exl.exhibitionNo }" class="btn btn-default">상세보기</a>
		                </div>
		                <div>
		                	<button  class="btn deleteExhibition" exhibitionNo="${exl.exhibitionNo }">전시삭제</button>
		                </div>
	        		</div>
	        	</c:forEach>
        	</div>
        	<div class="deleteExhibitionBox">
        		<c:if test="${empty cancel }">
					<h4>내린 전시가 없습니다</h4>
				</c:if>
	        	<c:forEach items="${cancel }" var="exc">
	        		<div class="exhibitionList">
		                <img src="${exc.exhibitionPhoto }" class="poster">
		                <div style="width: 800px;">
			                <h4><strong>전시명 : ${exc.exhibitionTitle }</strong></h4>
			                <h4>장소 : 무지다 미술관</h4>
			                <p>전시기간 : ${exc.exhibitionStart } ~ ${exc.exhibitionEnd }</p>	 
			                <a href="/exhibitionView.do?exhibitionNo=${exc.exhibitionNo }" class="btn btn-default">상세보기</a>
		                </div>
		                <div>
		                	<button class="btn btn-danger revivalExhibition" exhibitionNo="${exc.exhibitionNo }" style="margin-right: 20px;">전시소생</button>
		                	<button type = "button" class ="btn refundMember" data-toggle="modal" data-target="#myModal" exhibitionNo="${exc.exhibitionNo }">환불 회원 보기</button>
		                </div>
	        		</div>
	        	</c:forEach>
        	</div>
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
	<script>
		$(".refundMember").click(function(){
			var exhibitionNo = $(this).attr("exhibitionNo");
			$.ajax({
				url : "/refundMemberView.do",
				data : {exhibitionNo:exhibitionNo},
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
		$(".revivalExhibition").click(function(){
			var exhibitionNo = $(this).attr("exhibitionNo");
			swal({
				  title: "전시 살리기",
				  text: "전시를 살리겠습니까??",
				  icon: "success",
				  buttons: true,
				  dangerMode: true,
				})
				.then((email) => {
				  if (email) {
					  location.href="/revivalExhibition.do?exhibitionNo="+exhibitionNo;
				  } else {
				    swal("전시 소생 취소");
				  }
			});
		});
 		$(".deleteExhibition").click(function(){
 			var exhibitionNo = $(this).attr("exhibitionNo");
	    	swal({
				  title: "전시 내리기",
				  text: "전시를 종료 하시겠습니까??",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((email) => {
				  if (email) {
					  location.href="/deleteExhibition.do?exhibitionNo="+exhibitionNo;
				  } else {
				    swal("전시 종료 취소");
				  }
			});
 		});
		$(function() {
			$(".datepicker").focusin(function() {
				var start = $(this).next().val();
				var end = $(this).next().next().val();
				$(this).datepicker({
		            dateFormat: "yy-mm-dd",
		            monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
		            monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
		            dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		            dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		            dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		            yearSuffix : '년',
		            minDate: start,
		            maxDate: end,
		            beforeShowDay: noMondays //월요일은 휴무일
		        });
			    function noMondays(date) {
			    	return [date.getDay() != 1, ''];
			    };
			});
			
			$(".datepicker").change(function() {
				var exhibitionDate = $(this).val();
				var exhibitionNo = $(this).next().next().next().val();
				var idx = $(".datepicker").index(this);
				$(".exhibition").eq(idx).empty();
				$.ajax({
					url: "/checkPaymentExhibition.do",
					data: {exhibitionDate:exhibitionDate, exhibitionNo:exhibitionNo},
					type: "post",
					success: function(data) {
						if(data == "0"){
							$(".exhibition").eq(idx).append("<h4>전시예매정보가 없습니다.</h4>");
						}else{
							$(".exhibition").eq(idx).append("<h4>예매수:"+data+"명</h4>");
							//var p = $("<p>");
							//p.append(" 예매수 : "+data);
							//$(".exhibition").eq(idx).append(p);
							//$(".exhibition").scrollTop(innerHeight);
						}
						
					}
				});
			});

			$(".listNavi>div").click(function() {
				$(".listNavi>div").children().removeClass("selec");
	            $(this).children().addClass("selec");
	            $(".listNavi").nextAll().hide();
	            if($(this).index() == 0){
	                $(".exhibitionBox").show();
	            }else if($(this).index() == 1){
	            	$(".lastExhibitionBox").show();
	            }else{
	                $(".deleteExhibitionBox").show();
	            }
			});
			$(".listNavi>div").first().click();
		});
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>