<%@page import="show.vo.ShowAndReview"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%
    	ShowAndReview snr = (ShowAndReview)request.getAttribute("snr");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${snr.s.showName }</title>
<link href="resources/showCss/show_view.css" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/jquery-ui/jquery-ui-big.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<script type="text/javascript" src="/resources/jquery-ui/jquery-ui.min.js"></script>
    <div class="container">
        <div class="summary">
            <div class="summaryTop">
                <h1>${snr.s.showName }</h1>
                <c:if test="${snr.getS().getShowStar() != 0 }">
	                <%for(int i=0; i<Math.round(snr.getS().getShowStar()); i++){ %>
	                <span><img src="resources/showImage/star-on.png"></span>
	                <%} %>
	                <%for(int i=0; i<5-Math.round(snr.getS().getShowStar()); i++){ %>
	                <span><img src="resources/showImage/star-off.png"></span>
	                <%} %>
	                <span id="reviewAvg">${snr.s.showStar }</span>
                </c:if>
            </div>
            <div class="summaryBottom">
                <div class="poster">
                    <img src="${snr.s.filepath}" class="poster">
                </div>
                <div class="info">
                    <table>
                        <tr>
                            <td>장소</td>
                            <td>${snr.s.showHall }</td>
                        </tr>
                        <tr>
                            <td>공연기간</td>
                            <td>${snr.s.showStart } ~ ${snr.s.showEnd }</td>
                        </tr>
                        <tr>
                            <td>공연시간</td>
                            <td>${snr.s.showTime }</td>
                        </tr>
                        <tr>
                            <td>관람연령</td>
                            <c:choose>
                            	<c:when test="${snr.s.showAge > 0 }">
                            		<td>${snr.s.showAge }세 이상 관람가</td>
                            	</c:when>
                            	<c:otherwise>
                            		<td>전체 관람가</td>
                            	</c:otherwise>
                            </c:choose>
                        </tr>
                        <tr>
                            <td>가격</td>
                            <td>
                            	<c:choose>
			                		<c:when test="${snr.s.showSeat == 0 }">
			                			<h4>전좌석 ${snr.s.showPrice } 원</h4>
			                		</c:when>
			                		<c:otherwise>
			                			<h4>VIP석 <%=Math.round(snr.getS().getShowPrice()*1.5) %> 원</h4>
			                			<h4>R석 <%=Math.round(snr.getS().getShowPrice()*1.3) %> 원</h4>
			                			<h4>S석 ${snr.s.showPrice } 원</h4>
			                			<h4>A석 <%=Math.round(snr.getS().getShowPrice()*0.7) %> 원</h4>
			                		</c:otherwise>
			                	</c:choose>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="controllBox">
        	<c:if test="${sessionScope.m.memberLevel == 0 }">
	            <a href="/updateShowFrm.do?showNo=${snr.s.showNo}" class="btn btn-primary">수정</a>
	            <a href="javascript:void(0)" onclick="deleteShow('${snr.s.showNo}')" class="btn btn-primary">삭제</a>
        	</c:if>
        </div>
        <div class="infoWrapper">
            <div class="showInfo">
                <div class="showNavi">
                    <div><h3>공연정보</h3></div>
                    <div><h3>예매및취소</h3></div>
                    <div><h3>관람평</h3></div>
                </div>
                <div class="showContent hideContent">
					${snr.s.showContent }
                </div>
                <div class="sideInfo hideContent">
                   	 <h3>예매</h3>
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
                <div class="reviewBox hideContent">
					
					<div class="reviewList">
						<c:forEach items="${snr.list }" var="sr" varStatus="i">
							<ul class="reviews">
								<li>
									<p>${sr.reviewWriter }</p>
									<p>${sr.reviewDate }</p>
								</li>
								<li>
									<p>${sr.reviewContentBr }</p>
									<textarea name="reviewContent" class="form-control updateContent" style="display: none;">${sr.reviewContent }</textarea>
									<div class="starBox">
										<c:forEach begin="1" end="${sr.star }" >
											<span><img src="resources/showImage/star-on.png" style="height: 10px;"></span>											
										</c:forEach>									
									</div>
									<p class="reviewsBtn">
										<c:if test="${sessionScope.m != null }">
											<c:choose>
												<c:when test="${sessionScope.m.memberId == sr.reviewWriter}">
													<a href="javascript:void(0)" onclick="modifyReview(this,'${sr.reviewNo }','${snr.s.showNo }');">수정</a>
													<a href="javascript:void(0)" onclick="deleteReview(this,'${sr.reviewNo }','${snr.s.showNo }');">삭제</a>
												</c:when>
												<c:when test="${sessionScope.m.memberLevel == 0 }">
													<a href="javascript:void(0)" onclick="deleteReview(this,'${sr.reviewNo }','${snr.s.showNo }');">삭제</a>
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
            <div class="reserv">
                <div id="datepicker"></div>
                <form action="/selectSeat.do" method="post" onsubmit="return check()">
	                <input type="hidden" name="showDate">
	                <input type="hidden" name="showNo" value="${snr.s.showNo }">
	                <input type="hidden" name="memberId" value="${sessionScope.m.memberId }">
	                <h3>티켓 정보</h3>
	                <div class="ticketPrice">
	                	<c:choose>
	                		<c:when test="${snr.s.showSeat == 0 }">
	                			<h4>전좌석 ${snr.s.showPrice } 원</h4>
	                		</c:when>
	                		<c:otherwise>
	                			<h4>VIP석 <%=Math.round(snr.getS().getShowPrice()*1.5) %> 원</h4>
	                			<h4>R석 <%=Math.round(snr.getS().getShowPrice()*1.3) %> 원</h4>
	                			<h4>S석 ${snr.s.showPrice } 원</h4>
	                			<h4>A석 <%=Math.round(snr.getS().getShowPrice()*0.7) %> 원</h4>
	                		</c:otherwise>
	                	</c:choose>
	                </div>
	                <c:if test="${not empty sessionScope.m }">
	                	<input type="submit" class="btn btn-danger btn-lg reservBtn" value="예매하기">
	                </c:if>
                </form>
                <c:if test="${empty sessionScope.m }">
                	<a href="/loginFrm.do" class="btn btn-danger btn-lg reservBtn">로그인하고 예매하기</a>
                </c:if>
            </div>
        </div>
        
    </div>
    <script>
    	function check() {
			if($("input[name=showDate]").val() == ""){
				alert("날짜를 선택해주세요");
				return false;
			}else{
				var showDate = $("input[name=showDate]").val();
				var showNo = $("input[name=showNo]").val()
				var result;
				$.ajax({
					url: "/checkSoldOut.do",
					type: "post",
					async: false,
					data: {showDate:showDate, showNo:showNo},
					success: function(data) {
						seats = 413 - data;
						if(seats>0){
							result = true;
						}else{
							alert("해당 일자에 좌석이 매진되었습니다.");
							result = false;
						}
					}
				});
				return result;
			}
		}
    
    
	    $(function() {
	    	var showNo = ${snr.s.showNo};
	    	var memberNo = 1;
	        $(".showNavi>div").click(function() {
	            $(".showNavi>div").removeClass("selec");
	            $(this).addClass("selec");
	            $(".showNavi").nextAll().addClass("hideContent");
	            if($(this).index() == 0){
	                $(".showContent").removeClass("hideContent");
	            }else if($(this).index() == 1){
	                $(".sideInfo").removeClass("hideContent");
	            }else if($(this).index() == 2){
	                $(".reviewBox").removeClass("hideContent");
	            }
	        });
	        $(".showNavi>div").first().click();
	        
	        var d = new Date();
	        var today = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
	        var endDate = "${snr.s.showEnd}";
	        var startDate = "${snr.s.showStart}";
	        if(today<startDate){
	        	$("#datepicker").datepicker({
		            dateFormat: "yy-mm-dd",
		            monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
		            monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
		            dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		            dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		            dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		            yearSuffix : '년',
		            minDate: startDate,
		            maxDate: endDate,
		            beforeShowDay: noMondays //월요일은 휴무일
		        });
	        }else{
	        	$("#datepicker").datepicker({
		            dateFormat: "yy-mm-dd",
		            monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
		            monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
		            dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		            dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		            dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		            yearSuffix : '년',
		            minDate: today,
		            maxDate: endDate,
		            beforeShowDay: noMondays //월요일은 휴무일
		        });
	        }
	        
		    function noMondays(date) {
		    	return [date.getDay() != 1, ''];
		    };
	
	        $("#datepicker").change(function() {
				selectDate = $(this).val();
				$(".slide").fadeOut();
				$("input[name=showDate]").val(selectDate);
	        });
	        
//	        $("input[name=showDate]").val($("#datepicker").datepicker("setDate", today).val());

	    });
	    
	    function deleteShow(showNo) {
	    	if(confirm("공연을 삭제하시겠습니까?")){
				location.href="/deleteShow.do?showNo="+showNo;
			}
		}
	    
	    function modifyReview(obj,reviewNo,showNo) {
			//textarea를 화면에 표현
			$(obj).parents("li").children().filter(".updateContent").show();
			//기존 본문 내용을 숨김
			$(obj).parents("li").children().first().hide();
			$(obj).parents("li").children().filter(".starBox").hide();
			//수정 -> 수정완료
			$(obj).html('수정완료');
			$(obj).attr("onclick", "modifyComplete(this, '"+reviewNo+"', '"+showNo+"')");
			//삭제 -> 취소
			$(obj).next().html('취소');
			$(obj).next().attr("onclick", "modifyCancel(this, '"+reviewNo+"', '"+showNo+"');");
			//답글달기 버튼 숨기기
			$(obj).next().next().hide();
		}
		function modifyCancel(obj,reviewNo,showNo) {
			//textarea 숨김
			$(obj).parents("li").children().first().show();
			$(obj).parents("li").children().filter(".starBox").show();
			//기존 본문내용을 화면에 다시 표현
			$(obj).parents("li").children().filter(".updateContent").hide();
			//수정완료 -> 수정
			$(obj).prev().html('수정');
			$(obj).prev().attr("onclick", "modifyReview(this, '"+reviewNo+"', '"+showNo+"');");
			//취소 -> 삭제
			$(obj).html('삭제');
			$(obj).attr("onclick", "deleteReview(this, '"+reviewNo+"', '"+showNo+"');");
			//답글달기 버튼 보이기
			$(obj).next().show();
		}
		function modifyComplete(obj,reviewNo,showNo){
			var form = $("<form action='/updateReview.do' method='post'></form>");
			//form안에 수정 번호 설정
			form.append($("<input type='text' name='reviewNo' value='"+reviewNo+"'>"));
			//form에 공연 번호 설정
			form.append($("<input type='text' name='showNo' value='"+showNo+"'>"));
			//수정한 내용을 설정
			form.append($(obj).parents("li").children().filter(".updateContent"));
			//전송할 form태그를 현재 페이지에 추가
			$("body").append(form);
			//form태그 전송
			form.submit();
			
		}
		function deleteReview(obj,reviewNo,showNo){
			if(confirm("관람평 삭제시 재등록 불가합니다. 관람평을 삭제하시겠습니까?")){
				location.href="/deleteReview.do?reviewNo="+reviewNo+"&showNo="+showNo;
			}
		}
    </script>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>