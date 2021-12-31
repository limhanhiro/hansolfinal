<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전시 상세보기</title>
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
<link href="resources/hansolCss/hansol_exhibitionView.css" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/jquery-ui/jquery-ui.css">
</head>
<body>
	
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<script type="text/javascript" src="/resources/jquery-ui/jquery-ui.min.js"></script>
	<div class="container">
		<div class="rightSide">
        <div class="topSide">
            <h2>${exb.exhibitionTitle }</h2>
            <div class="star">
            	<c:forEach begin="1" end="${exb.starAvg }" >
					<span><img src="resources/showImage/star-on.png" style="height: 13px;"></span>
				</c:forEach>
				<span>${exb.starAvg }</span>											
            </div>
        </div>
        <div class="middleSide">
            <div class="exhibitionPhoto">
                <img class="photo" src=${exb.exhibitionPhoto }>
            </div>
            <div class="exhibitionSummary">
                <table class="summaryTable" >
                    <tr>
                        <td><strong>전시 기간</strong></td>
                        <td>${exb.exhibitionStart } ~ ${exb.exhibitionEnd }</td>
                    </tr>
                    <tr>
                        <td><strong>전시 시간</strong></td>
                        <td>${exb.exhibitionTimeStart } ~ ${exb.exhibitionTimeEnd }</td>
                    </tr>
                    <tr>
                        <td><strong>연령</strong></td>
                        <td>${exb.exhibitionAge }</td>
                    </tr>
                    <tr>
                        <td><strong>티켓 가격</strong></td>
                        <td>${exb.exhibitionPrice }</td>
                    </tr>
                    <tr>
                        <td><strong>인원선택</strong></td>
                        <td>
                        <div class="count">
                 	        <button type="button" class="count_btn1">-</button>
								<span class="amount" id="amount">1</span>
							<button type="button" class="count_btn1">+</button>
						</div>
						</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="bottomSide">
              <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#home" style="color: #064663;">전시정보</a></li>
                <li><a data-toggle="tab" href="#menu1" style="color: #064663;">예매및취소</a></li>
                <li><a data-toggle="tab" href="#menu2" style="color: #064663;">관람평</a></li>
              </ul>
              <div class="tab-content">
              		<div id="home" class="tab-pane fate in active" >
              			<h3>전시 정보</h3>
              			<div class="detail">${exb.exhibitionDetail }</div>
             	 	</div>
              		<div id="menu1" class="tab-pane fate in" style="width:850px">
              			<h3>취소 환불 규정</h3>
		    			<p>예매는 PC, 모바일, 고객센터 를 통해 신용카드, 카카오페이, 네이버페이 등으로 예매하실 수 있습니다.<br>
                        (단, 상품마다 사용 가능한 결제 수단이 다르게 적용될 수 있으니 상품 상세페이지 안내 사항을 확인해주세요.)<br>
                        	결제 취소시 예매와 선택 좌석이 자동 취소되므로 유의하시기 바랍니다.</p>
                    <h3>티켓수령방법</h3>
                    <p><strong>현장수령</strong><br>
                        티켓은 예매자 본인 수령이 기본 원칙입니다.<br>
                        공연 당일 예매확인서와 예매자의 신분증 을 지참하신 후 공연장 매표소에서 티켓을 수령하시면 됩니다.</p>
                    <h3>환불</h3>
                    <p>예매수수료는 예매 당일 밤 12시 이전까지 환불되며, 그 이후 기간에는 환불되지 않습니다.</p>
              		</div>
              		<div id="menu2" class="tab-pane fate in" style="margin-bottom: 30px;" >
        					 <c:if test="${empty sessionScope.m }">
            					<p>※로그인 후 댓글 작성이 가능합니다※</p>  
            				</c:if>
            				<c:if test="${empty payment }">
            						<p>※전시 구매후 댓글 작성이 가능합니다※</p>  
            				</c:if>		
		    			<div class="reviewBox hideContent">
                	<div id="insert-btn">
		
         <c:set var="check" value="false"/>
         <c:forEach items="${payment }" var="pm">
 			<c:if test="${not check }">
            <c:choose>
            <c:when test ="${not empty sessionScope.m && pm.memberNo eq sessionScope.m.memberNo }">
            	<div class="inputReviewBox">
					<form action="/insertExReview.do" method="post">
						<input type="hidden" name="exReviewWriter" value="${sessionScope.m.memberId }">
						<input type="hidden" name="exhibitionNo" value="${exb.exhibitionNo }">
							<div class="selectStar">
								<p>평점선택</p>
									<select name="exReviewStar">
										<option value="5">5</option>
										<option value="4">4</option>
										<option value="3">3</option>
										<option value="2">2</option>
										<option value="1">1</option>
									</select>
							</div>
						<textarea name="exReviewContent" class="form-control" style="width: 90%;resize: none;"></textarea>
					<button type="submit" class="btn btn-defualt">등록</button>
					</form>
				</div>
				<c:set var="check" value="true"/>
            </c:when>
            <c:otherwise>
            	<p>전시 구매후 댓글 작성이 가능합니다</p>  
            	<c:set var="check" value="true"/>
            </c:otherwise>
            </c:choose>
            </c:if>
         </c:forEach>
      </div>
					<div class="reviewList">
						<c:forEach items="${list }" var="exr" varStatus="i">
							<ul class="reviews">
								<li>
									<p>${exr.exReviewWriter }</p>
									<p>${exr.exReviewDate }</p>
								</li>
								<li>
									<p>${exr.exReviewContentBr }</p>
									<textarea name="exReviewContent" class="form-control updateContent" style="display: none;">${exr.exReviewContent }</textarea>
									<div class="starBox">
										<c:forEach begin="1" end="${exr.exReviewStar }" >
											<span><img src="resources/showImage/star-on.png" style="height: 10px;"></span>											
										</c:forEach>									
									</div>
									<p class="reviewsBtn">
										<c:if test="${sessionScope.m != null }">
											<c:choose>
												<c:when test="${sessionScope.m.memberId == exr.exReviewWriter}">
													<a href="javascript:void(0)" onclick="modifyReview(this,'${exr.exReviewNo }','${exr.exhibitionNo }');">수정</a>
													<a href="javascript:void(0)" onclick="deleteReview(this,'${exr.exReviewNo }','${exr.exhibitionNo }');">삭제</a>
												</c:when>
												<c:when test="${sessionScope.m.memberLevel == 0 }">
													<a href="javascript:void(0)" onclick="deleteReview(this,'${exr.exReviewNo }','${exr.exhibitionNo }');">삭제</a>
												</c:when>
											</c:choose>
										</c:if>
									</p>
								</li>
							</ul>
						</c:forEach>
					</div>
					
                </div>
              		</div>
              </div>
        </div>
    </div>
    <div class="leftSide">
    <div class="fixed">
    	 <div id="datepicker"></div>
    	 <input type="hidden" id="startDay" value="${exb.exhibitionStart }">
    	 <input type="hidden" id="endDay" value="${exb.exhibitionEnd }">
    	 <input type="hidden" class="price" value="${exb.exhibitionPrice }">
    	 <input type="hidden" id="exhibitionNo" value="${exb.exhibitionNo }">
    	 <input type="hidden" id="exhibitionTitle" value="${exb.exhibitionTitle }">
    	 <input type="hidden" id="exhibitionPhoto" value="${exb.exhibitionPhoto }">
    	 <input type="hidden" id="bookDate" value="">
    	 <div class="pp" style="margin-top: 10px;">
    	 <c:if test="${empty sessionScope.m }">
    	 	<button onclick="goLogin();"class="btn" id="goLogin" style="float: right;">로그인하고 구매</button>
    	 </c:if>
    	 <c:if test="${not empty sessionScope.m }">
    	 <span class="totalPrice" id="totalPrice" style="font-size: 20px;">${exb.exhibitionPrice }</span>원
    	 <button onclick="payment();"class="btn" id="payment" style="float: right;">결제하기</button>
    	 </c:if>
    	 </div>
    </div>
    </div>
   
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
 <script>
function goLogin(){
	location.href="/loginFrm.do";
}
 		function payment(){
 			var bookDate = $("#bookDate").val();
 			var paymentPrice = Number($("#totalPrice").html()); 
 			var paymentQuantity = Number($("#amount").html()); 
 			var exhibitionNo = Number($("#exhibitionNo").val());
 			var exhibitionTitle = $("#exhibitionTitle").val();
 			var exhibitionPhoto = $("#exhibitionPhoto").val();
 			var paymentSelect = 1; // 전시결제는 1 , 강좌결제는 2
 			var form = $("<form action='/exhibitionPaymentFrm.do' method='post'></form>");
 			form.append($("<input type='text' name='paymentQuantity' value='"+paymentQuantity+"'>"));
 			form.append($("<input type='text' name='paymentPrice' value='"+paymentPrice+"'>"));
 			form.append($("<input type='text' name='exhibitionNo' value='"+exhibitionNo+"'>"));
 			form.append($("<input type='text' name='paymentSelect' value='"+paymentSelect+"'>"));
 			form.append($("<input type='text' name='exhibitionTitle' value='"+exhibitionTitle+"'>"));
 			form.append($("<input type='text' name='exhibitionPhoto' value='"+exhibitionPhoto+"'>"));
 			form.append($("<input type='text' name='bookDate' value='"+bookDate+"'>"));
			$("body").append(form);
			form.submit();
 		}
 
	    $(function() {
	        var start = $("#startDay").val();
	        var end = $("#endDay").val();
	    	
	        var today = new Date();
	        var endDate = end;
	        $("#datepicker").datepicker({
	            dateFormat: "yy-mm-dd",
	            monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ], 
	            monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
	            dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
	            dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
	            dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
	            yearSuffix : '년',
 	            minDate: start,
	            maxDate: endDate,
	            beforeShowDay : noMondays, //월요일은 휴무일
	            onSelect : function(data){
	            	$("#bookDate").val(data);
	            }
	        });
	        $("#bookDate").val($("#datepicker").datepicker("setDate", today).val());
	        $("#datepicker").change(function() {
				selectDate = $(this).val();
				$(".slide").fadeOut();
				$("input[name=date]").val(selectDate);
	        });
	      //월요일 휴무 코드
			 function noMondays(date) {
	    		return [date.getDay() != 1, ''];
	 		}
			

	        
	        //$("#datepicker").datepicker("onselect", today);
	        
			//$(".ui-datepicker-calendar>tbody>tr>td>a").css("background-color", "black").css("color", "#fff");
	        
	    });
	    $(".count>button").click(function(){
			var currAmount = Number($(".amount").html()); 
			if($(this).html() == "+") { 
				$(".amount").html(++currAmount);
				if($("#amount").html()>10){
					alert("최대 10인 까지만 가능합니다.");
					$("#amount").html(10);
				}
			}else{
				if(currAmount != 1){ 
					$(".amount").html(--currAmount);					
				}
			}
			var price = Number($(".price").val()); 
			$(".totalPrice").html(currAmount*price);
			$("#amount").val(currAmount);
			
		});
	    function modifyReview(obj,exReviewNo,exhibitionNo) {
			//textarea를 화면에 표현
			$(obj).parents("li").children().filter(".updateContent").show();
			//기존 본문 내용을 숨김
			$(obj).parents("li").children().first().hide();
			$(obj).parents("li").children().filter(".starBox").hide();
			//수정 -> 수정완료
			$(obj).html('수정완료');
			$(obj).attr("onclick", "modifyComplete(this, '"+exReviewNo+"', '"+exhibitionNo+"')");
			//삭제 -> 취소
			$(obj).next().html('취소');
			$(obj).next().attr("onclick", "modifyCancel(this, '"+exReviewNo+"', '"+exhibitionNo+"');");
			//답글달기 버튼 숨기기
			$(obj).next().next().hide();
		}
		function modifyCancel(obj,exReviewNo,exhibitionNo) {
			//textarea 숨김
			$(obj).parents("li").children().first().show();
			$(obj).parents("li").children().filter(".starBox").show();
			//기존 본문내용을 화면에 다시 표현
			$(obj).parents("li").children().filter(".updateContent").hide();
			//수정완료 -> 수정
			$(obj).prev().html('수정');
			$(obj).prev().attr("onclick", "modifyReview(this, '"+exReviewNo+"', '"+exhibitionNo+"');");
			//취소 -> 삭제
			$(obj).html('삭제');
			$(obj).attr("onclick", "deleteReview(this, '"+exReviewNo+"', '"+exhibitionNo+"');");
			//답글달기 버튼 보이기
			$(obj).next().show();
		}
		function modifyComplete(obj,exReviewNo,exhibitionNo){
			var form = $("<form action='/updateExReview.do' method='post'></form>");
			//form안에 수정 번호 설정
			form.append($("<input type='text' name='exReviewNo' value='"+exReviewNo+"'>"));
			//form에 공연 번호 설정
			form.append($("<input type='text' name='exhibitionNo' value='"+exhibitionNo+"'>"));
			//수정한 내용을 설정
			form.append($(obj).parents("li").children().filter(".updateContent"));
			//전송할 form태그를 현재 페이지에 추가
			$("body").append(form);
			//form태그 전송
			form.submit();
			
		}
		function deleteReview(obj,exReviewNo,exhibitionNo){
			var exReviewStatus = 1;
			if(confirm("관람평을 삭제하시겠습니까?")){
				location.href="/deleteExReview.do?exReviewNo="+exReviewNo+"&exhibitionNo="+exhibitionNo;
			}
		}
    </script>
</html>