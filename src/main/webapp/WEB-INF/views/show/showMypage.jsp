<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="/resources/showCss/showMypage.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
	
	<div class="container">        
        <div class="mypage-title"><span>공</span>연예매내역</div>
        <div class="mypage-container">
        	<div class="reservNavi">
        		<div><h4>예매내역</h4></div>
	    		<div><h4>지난예매내역</h4></div>
	    		<div><h4>취소내역</h4></div>
        	</div>
        	<c:set var="today" value="<%=new Date()%>" />
        	<fmt:formatDate value="${today}" type="date" var="today" pattern="yyyy-MM-dd"/>
	        	<c:forEach items="${list }" var="r">
	        		<c:choose>
	        			<c:when test="${r.reservCancel == 1}">
	        				<div class="cancel">
	        					<div class="reservBox">
	        						<h4>공연명 : ${r.showName }</h4>
	        						<h5>공연일 : ${r.showDate }</h5>
	        						<button class="btn btn-default btn-sm" onclick="deleteReserv('${r.reservNo }');">내역삭제</button>
	        					</div>
	        				</div>
	        			</c:when>
	        			<c:when test="${r.reservCancel == 0 && r.showDate>=today}">
	        				<div class="notCancel">
	        					<div class="reservBox">
	        						<h4>공연명 : ${r.showName }</h4>
	        						<h5>공연일 : ${r.showDate }</h5>
	        						<h5>예매수 : ${r.ticketNum }</h5>
	        						<h5>결제금액 : ${r.payment }</h5>
	        						<c:choose>
	        							<c:when test="${r.reservPay == 1 }">
			        						<button onclick="showSeat('${r.reservNo}');" type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal">좌석보기</button>
			        						<button class="btn btn-danger btn-sm" onclick="cancelReserv('${r.reservNo }');">예매취소</button>
	        							</c:when>
	        							<c:otherwise>
	        								<input type="hidden" value="${r.showName }">
	        								<input type="hidden" value="${r.payment }">
	        								<button class="payment btn btn-danger btn-sm">결제하기</button>
	        								<input type="hidden" value="${r.reservNo }">
	        								<button class="btn btn-danger btn-sm" onclick="cancelReserv('${r.reservNo }');">예매취소</button>
	        							</c:otherwise>
	        						</c:choose>
	        					</div>
	        					<!-- Modal -->
								  <div class="modal fade" id="myModal" role="dialog">
								    <div class="modal-dialog">
								    
								      <!-- Modal content-->
								      <div class="modal-content">
								        <div class="modal-header">
								          <button type="button" class="close" data-dismiss="modal">&times;</button>
								          <h3 class="modal-title">예매좌석</h3>
								        </div>
								        <div class="modal-body">
								          <div class="floorWrapper">
									        <div class="floor">
									            <div class="firstCol">
									            	<c:forEach begin="1" end="15" varStatus="i">
									            		<div class="row">
									            			<c:choose>
									            				<c:when test="${i.index < 5 }">
									            					<c:forEach begin="1" end="${i.index+3 }" varStatus="j">
											            				<div class="seats">
																			
																			<div id="seat">
											                        			
											                        			<input type="hidden" value="A-${i.index }-${j.index}">
											                        		</div>
											                        		
											                    		</div>
											            			</c:forEach>
									            				</c:when>
									            				<c:when test="${i.index < 7 }">
									            					<c:forEach begin="1" end="7" varStatus="j">
											            				<div class="seats">
											                        		<div id="seat">
											                        			
											                        			<input type="hidden" value="A-${i.index }-${j.index}">
											                        		</div>
											                    		</div>
											            			</c:forEach>
									            				</c:when>
									            				<c:when test="${i.index < 9 }">
									            					<c:forEach begin="1" end="8" varStatus="j">
											            				<div class="seats">
											                        		<div id="seat">
											                        			
											                        			<input type="hidden" value="A-${i.index }-${j.index}">
											                        		</div>
											                    		</div>
											            			</c:forEach>
									            				</c:when>
									            				<c:when test="${i.index < 11 }">
									            					<c:forEach begin="1" end="9" varStatus="j">
											            				<div class="seats">
											                        		<div id="seat">
											                        			
											                        			<input type="hidden" value="A-${i.index }-${j.index}">
											                        		</div>
											                    		</div>
											            			</c:forEach>
									            				</c:when>
									            				<c:otherwise>
									            					<c:forEach begin="1" end="10" varStatus="j">
											            				<div class="seats">
											                        		<div id="seat">
											                        			
											                        			<input type="hidden" value="A-${i.index }-${j.index}">
											                        		</div>
											                    		</div>
											            			</c:forEach>
									            				</c:otherwise>
									            			</c:choose>
									            		</div>
									            	</c:forEach>
									            </div>
									            <div class="secondCol">
									                <c:forEach begin="1" end="15" varStatus="i">
									            		<div class="row">
									            			<c:choose>
									            				<c:when test="${i.index % 2 ==1 }">
											            			<c:forEach begin="1" end="12" varStatus="j">
											            				<div class="seats">
											                        		<div id="seat">
											                        			
											                        			<input type="hidden" value="B-${i.index }-${j.index}">
											                        		</div>
											                    		</div>
											            			</c:forEach>
									            				</c:when>
									            				<c:otherwise>
									            					<c:forEach begin="1" end="11" varStatus="j">
									            						<div class="seats">
											                        		<div id="seat">
											                        			
											                        			<input type="hidden" value="B-${i.index }-${j.index}">
											                        		</div>
											                    		</div>
											            			</c:forEach>
									            				</c:otherwise>
									            			</c:choose>
									            		</div>
									            	</c:forEach>
									            </div>
									            <div class="thirdCol">
									                <c:forEach begin="1" end="15" varStatus="i">
									            		<div class="row">
									            			<c:choose>
									            				<c:when test="${i.index < 5 }">
									            					<c:forEach begin="1" end="${i.index+3 }" varStatus="j">
											            				<div class="seats">
											                        		<div id="seat">
											                        			
											                        			<input type="hidden" value="C-${i.index }-${j.index}">
											                        		</div>
											                    		</div>
											            			</c:forEach>
									            				</c:when>
									            				<c:when test="${i.index < 7 }">
									            					<c:forEach begin="1" end="7" varStatus="j">
											            				<div class="seats">
											                        		<div id="seat">
											                        			
											                        			<input type="hidden" value="C-${i.index }-${j.index}">
											                        		</div>
											                    		</div>
											            			</c:forEach>
									            				</c:when>
									            				<c:when test="${i.index < 9 }">
									            					<c:forEach begin="1" end="8" varStatus="j">
											            				<div class="seats">
											                        		<div id="seat">
											                        			
											                        			<input type="hidden" value="C-${i.index }-${j.index}">
											                        		</div>
											                    		</div>
											            			</c:forEach>
									            				</c:when>
									            				<c:when test="${i.index < 11 }">
									            					<c:forEach begin="1" end="9" varStatus="j">
											            				<div class="seats">
											                        		<div id="seat">
											                        			
											                        			<input type="hidden" value="C-${i.index }-${j.index}">
											                        		</div>
											                    		</div>
											            			</c:forEach>
									            				</c:when>
									            				<c:otherwise>
									            					<c:forEach begin="1" end="10" varStatus="j">
											            				<div class="seats">
											                        		<div id="seat">
											                        			<input type="hidden" value="C-${i.index }-${j.index}">
											                        		</div>
											                    		</div>
											            			</c:forEach>
									            				</c:otherwise>
									            			</c:choose>
									            		</div>
									            	</c:forEach>
									            </div>
									        </div>
								        </div>
								        	<div id="mySeat">
								        		
								        	</div>
								        
								        <div class="modal-footer">
								          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								        </div>
								      </div>
								      </div>
								      
								    </div>
								  </div>
	        				</div>
	        			</c:when>
	        			<c:otherwise>
	        				<div class="last">
	        					<div class="reservBox">
	        						<h4>공연명 : ${r.showName }</h4>
	        						<h5>공연일 : ${r.showDate }</h5>
	        						<h5>예매수 : ${r.ticketNum }</h5>
	        						<h5>결제금액 : ${r.payment }</h5>
	        						<c:if test="${r.reviewStatus == 0 }">
		        						<button class="btn btn-default btn-sm" onclick="writeReview('${r.reservNo}');">관람평작성</button>
	        						</c:if>
	        						<button class="btn btn-danger btn-sm" onclick="deleteReserv('${r.reservNo }');">내역삭제</button>
	        					</div>
	        				</div>
	        			</c:otherwise>
	        		</c:choose>
	        	</c:forEach>
        </div>
    </div>
    <script>
    	function writeReview(reservNo) {
			var newWindow = open("/checkReview.do?reservNo="+reservNo,"review", "height=500,width=580,top=200,left=200,location=no,toolbars=no");
		}
    
		function cancelReserv(reservNo) {
	    	if(confirm("예매를 취소하시겠습니까?")){
				location.href="/reservCancel.do?reservNo="+reservNo+"&memberId=${sessionScope.m.memberId}";
			}
		}
		function deleteReserv(reservNo) {
	    	if(confirm("내역을 삭제하시겠습니까?")){
				location.href="/deleteReserv.do?reservNo="+reservNo+"&memberId=${sessionScope.m.memberId}";
			}
		}
		$(function() {
			
			$(".reservNavi>div").click(function() {
				$(".reservNavi>div").children().removeClass("selec");
	            $(this).children().addClass("selec");
	            $(".reservNavi").nextAll().hide();
	            if($(this).index() == 0){
	                $(".notCancel").show();
	            }else if($(this).index() == 1){
	            	$(".last").show();
	            }else{
	                $(".cancel").show();
	            }
			});
			$(".reservNavi>div").first().click();
			
		});
		
			var allSeat = 413;
		function showSeat(reservNo) {
			$("#mySeat").empty();
			for (var i= 0; i < allSeat; i++) {
				$("#seat>input").eq(i).parent().removeAttr("style");
			}
			$.ajax({
				url: "/showSeat.do",
				data: {reservNo:reservNo},
				type: "post",
				success: function(data) {
					$("#mySeat").append("<h3>선택좌석</h3>");
					var h4 = $("<h4>");
					for(var i=0; i<data.length; i++){
						for (var j = 0; j < allSeat; j++) {
							if(data[i].seatNo == $("#seat>input").eq(j).val()){
								$("#seat>input").eq(j).parent().css("background-color", "#9354ED");
								count = j+1;
								break;
							}
						}
						h4.append(data[i].seatNo);
						if(i < data.length-1){
							h4.append(" / ");
						}
						$("#mySeat").append(h4);
					}
				}
			});
		}
		$(".payment").click(function() {
			var d = new Date();
			var date = d.getFullYear()+""+(d.getMonth()+1)+""+d.getDate()+""+d.getHours()+""+d.getMinutes()+""+d.getSeconds();
			var showName = $(this).prev().prev().val();
			var price = $(this).prev().val();
			IMP.init("imp76831421");	//결제 API 사용을 위해 가맹점 식별코드 입력
			IMP.request_pay({
				merchant_uid : showName+"_"+date,	//거래 아이디
				name : showName,				//결제 이름 설정
				amount : price,	//결제 금액
				buyer_email : "${sessionScope.m.memberEmail}",	//구매자 이메일
				buyer_name : "${sessionScope.m.memberName}",	//구매자 이름
				buyer_phone : "${sessionScope.m.memberPhone}",	//구매자 전화번호
				buyer_addr : "${sessionScope.m.addressRoad}",	//구매자 주소
				buyer_postcode : "${sessionScope.m.postcode}" 	//구매자 우편번호
			}, function(rsp) {
				if(rsp.success){
					//DB결제정보 update
					alert("결제 성공");
					//console.log("카드 승인번호 : "+rsp.apply_num);
					var reservNo = $(this).next().val();
					location.href="/paymentSuccess.do?reservNo="+reservNo;
				}else{
					alert("결제 실패");
				}
			});
		});
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>