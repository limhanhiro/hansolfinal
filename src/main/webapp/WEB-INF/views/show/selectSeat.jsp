<%@page import="show.vo.Seat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%
    	ArrayList<Seat> list = (ArrayList<Seat>)request.getAttribute("list");
    	ArrayList<String> seatList = new ArrayList<String>();
    	if(list.isEmpty()){
    		seatList.add("nope");
    	}else{
	    	for(int i=0;i<list.size(); i++){
	    		seatList.add(list.get(i).getSeatNo());
	    	}    		
    	}
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택</title>
<link href="resources/showCss/show_seat.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container">
		<div class="title">
			<h1><strong>좌석 선택</strong></h1>
			<c:if test="${s.showName.length() > 13 }">
				<h2>${s.showName.substring(0,10) }... / </h2>
			</c:if>
			<c:if test="${s.showName.length() <= 13 }">
				<h2>${s.showName } / </h2>
			</c:if>
			<h2>${s.showHall } / </h2>
			<h2>${sr.showDate }</h2>
		</div>
		<div>
		<h1 class="stage">STAGE</h1>
		</div>
		<div class="floorWrapper">
	        <div class="floor">
	            <div class="firstCol">
	            	<c:forEach begin="1" end="15" varStatus="i">
	            		<div class="row">
	            			<c:choose>
	            				<c:when test="${i.index < 5 }">
	            					<c:forEach begin="1" end="${i.index+3 }" varStatus="j">
			            				<div class="seats">
											<!-- 테스트 -->
											<div id="seat" onclick="choose(this);">
			                        			${j.index }
			                        			<input type="hidden" value="A-${i.index }-${j.index}">
			                        		</div>
			                        		<!-- 테스트 -->
			                    		</div>
			            			</c:forEach>
	            				</c:when>
	            				<c:when test="${i.index < 7 }">
	            					<c:forEach begin="1" end="7" varStatus="j">
			            				<div class="seats">
			                        		<div id="seat" onclick="choose(this);">
			                        			${j.index }
			                        			<input type="hidden" value="A-${i.index }-${j.index}">
			                        		</div>
			                    		</div>
			            			</c:forEach>
	            				</c:when>
	            				<c:when test="${i.index < 9 }">
	            					<c:forEach begin="1" end="8" varStatus="j">
			            				<div class="seats">
			                        		<div id="seat" onclick="choose(this);">
			                        			${j.index }
			                        			<input type="hidden" value="A-${i.index }-${j.index}">
			                        		</div>
			                    		</div>
			            			</c:forEach>
	            				</c:when>
	            				<c:when test="${i.index < 11 }">
	            					<c:forEach begin="1" end="9" varStatus="j">
			            				<div class="seats">
			                        		<div id="seat" onclick="choose(this);">
			                        			${j.index }
			                        			<input type="hidden" value="A-${i.index }-${j.index}">
			                        		</div>
			                    		</div>
			            			</c:forEach>
	            				</c:when>
	            				<c:otherwise>
	            					<c:forEach begin="1" end="10" varStatus="j">
			            				<div class="seats">
			                        		<div id="seat" onclick="choose(this);">
			                        			${j.index }
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
			                        		<div id="seat" onclick="choose(this);">
			                        			${j.index }
			                        			<input type="hidden" value="B-${i.index }-${j.index}">
			                        		</div>
			                    		</div>
			            			</c:forEach>
	            				</c:when>
	            				<c:otherwise>
	            					<c:forEach begin="1" end="11" varStatus="j">
	            						<div class="seats">
			                        		<div id="seat" onclick="choose(this);">
			                        			${j.index }
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
			                        		<div id="seat" onclick="choose(this);">
			                        			${j.index }
			                        			<input type="hidden" value="C-${i.index }-${j.index}">
			                        		</div>
			                    		</div>
			            			</c:forEach>
	            				</c:when>
	            				<c:when test="${i.index < 7 }">
	            					<c:forEach begin="1" end="7" varStatus="j">
			            				<div class="seats">
			                        		<div id="seat" onclick="choose(this);">
			                        			${j.index }
			                        			<input type="hidden" value="C-${i.index }-${j.index}">
			                        		</div>
			                    		</div>
			            			</c:forEach>
	            				</c:when>
	            				<c:when test="${i.index < 9 }">
	            					<c:forEach begin="1" end="8" varStatus="j">
			            				<div class="seats">
			                        		<div id="seat" onclick="choose(this);">
			                        			${j.index }
			                        			<input type="hidden" value="C-${i.index }-${j.index}">
			                        		</div>
			                    		</div>
			            			</c:forEach>
	            				</c:when>
	            				<c:when test="${i.index < 11 }">
	            					<c:forEach begin="1" end="9" varStatus="j">
			            				<div class="seats">
			                        		<div id="seat" onclick="choose(this);">
			                        			${j.index }
			                        			<input type="hidden" value="C-${i.index }-${j.index}">
			                        		</div>
			                    		</div>
			            			</c:forEach>
	            				</c:when>
	            				<c:otherwise>
	            					<c:forEach begin="1" end="10" varStatus="j">
			            				<div class="seats">
			                        		<div id="seat" onclick="choose(this);">
			                        			${j.index }
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
	        <div class="reservInfo">
	        	<c:if test="${s.showSeat == 1 }">
		        	<div class="seatDiv">
		        		<div style="background-color:#E3C4FF; ">VIP</div>
		        		<div style="background-color:#BCE067; ">R</div>
		        		<div style="background-color:#EDD200; ">S</div>
		        		<div style="background-color:#F15F5F; ">A</div>
		        	</div>	        	
	        	</c:if>
	        	<div><h1><strong>선택 좌석</strong></h1></div>
	            <div class="selectSeat"></div>
	            <button class="btn btn-danger" onclick="reservation();">예매하기</button>
	        </div>
		
		</div>
    </div>
    <script>
		$(function() {
			var allSeat = 413;
			
			var showSeat = ${s.showSeat};
  			if(showSeat == 1){
  				for (var i = 0; i < allSeat; i++) {
					var seat = $("#seat>input").eq(i).val();
					var col = seat.substring(0,seat.indexOf("-"));
					var row = seat.substring(seat.indexOf("-")+1, seat.lastIndexOf("-"));
					var no = seat.substring(seat.lastIndexOf("-")+1);
					
					if(row < 8){
						if(col=="A" && ((row>3 && row<7 && no==1)||(row==7 && no<3)) || col=="C" && ((row>3 && row<7 && no==7)||(row==7 && no>6))){
							$("#seat>input").eq(i).parent().css("background-color", "#BCE067");
						}else{
							$("#seat>input").eq(i).parent().css("background-color", "#E3C4FF");
						}
					}else if(row<11){
						$("#seat>input").eq(i).parent().css("background-color", "#BCE067");
					}else if(row<14){
						$("#seat>input").eq(i).parent().css("background-color", "#EDD200");
					}else{
						$("#seat>input").eq(i).parent().css("background-color", "#F15F5F");
					}
					
					
				}
  			}
			
			
			var seatList = new Array();

			<%if(!seatList.get(0).equals("nope")){%>
			var count = 0;
			<%for(String str : seatList){%>
				seatList[count++] = "<%=str%>";
			<%}%>
			<%}%>
			seatList.sort();
 			
 			
  			for(var i=0; i<seatList.length; i++){
 				var seat = seatList[i];
 				for(var j=0; j<allSeat; j++){
 					if($("#seat>input").eq(j).val() == seat){
 						$("#seat>input").eq(j).parent().removeAttr("onclick").css("background-color", "#818181").css("color", "#616161").css("cursor", "default");
 						break;
 					}
 				}
 			}
  			
  			
		});

    
        var count=0;
        var arr = new Array();
        var bkColor = new Array();
        var levelArr = new Array();
        function choose(obj){
        	if(arr.length == 5){
        		alert("한 번에 최대 5좌석만 구매가능합니다.");
        	}else{
        		var seatNo = $(obj).children().val();
        		var showNo = ${s.showNo};
        		var showDate = "${sr.showDate}"
        		var result = 0;
        		$.ajax({
        			url: "/checkSeat.do",
        			type: "post",
        			data: {seatNo:seatNo, showNo:showNo, showDate:showDate},
        			success: function(data) {
						if(data == ""){
							bkColor.push($(obj).css("background-color"));
							if($(obj).css("background-color") == "rgb(227, 196, 255)"){
								levelArr.push("vip");
							}else if($(obj).css("background-color") == "rgb(188, 224, 103)"){
								levelArr.push("r");
							}else if($(obj).css("background-color") == "rgb(241, 95, 95)"){
								levelArr.push("a");
							}else{
								levelArr.push("s");
							}
							$(obj).css("background-color", "#563D39");
				            $(obj).attr("onclick", "cancel(this);");
				            count++;
				            arr.push($(obj).children().val());
				            var h3 = $("<h3>");
				            h3.append($(obj).children().val());
				            $(".selectSeat").append(h3);
				            $(".selectSeat").scrollTop(innerHeight);
						}else{
							alert("이미 선택된 좌석입니다.");
						}
					}
        		});
	            
        	}
        }
        function cancel(obj){
            $(obj).attr("onclick", "choose(this);");
            count--;
            $(".selectSeat").empty();
            for(var i=0; i<arr.length; i++){
                if(arr[i] == $(obj).children().val()){
                    arr.splice(i,1);
                    $(obj).css("background-color", bkColor[i]);
                    bkColor.splice(i,1);
                    levelArr.splice(i,1);
                }
                var h3 = $("<h3>");
                h3.append(arr[i]);
                $(".selectSeat").append(h3);
            }
        }
        
		function reservation(){
			if(arr[0] == null){
				alert("좌석을 선택하세요");
			}else{
				var memberId = "${sessionScope.m.memberId}";
				var showDate = "${sr.showDate}"
				var form = $("<form action='/reservation.do' method='post'></form>");
				//공연 번호 설정
				form.append($("<input type='text' name='showNo' value='"+${s.showNo}+"'>"));
				//예매자 아이디 설정
				form.append($("<input type='text' name='memberId' value='"+memberId+"'>"));
				//좌석 가격 설정
				form.append($("<input type='text' name='seatPrice' value='"+${s.showPrice}+"'>"));
				//예약 날짜 설정
				form.append($("<input type='text' name='showDate' value='"+showDate+"'>"));
				// 선택한 좌석 번호들 설정
				for(var i=0; i<arr.length; i++){
					form.append($("<input type='text' name='seatList' value='"+arr[i]+"'>"));
					form.append($("<input type='text' name='levelList' value='"+levelArr[i]+"'>"));
				}
				//전송할 form태그를 현재 페이지에 추가
				$("body").append(form);
				//form태그 전송
				form.submit();
			}
		}
		
		$(document).ready(function() {
		    $(window).on('beforeunload', function(){
		        return "Any changes will be lost";
		    });
		    // Form Submit
		    $(document).on("submit", "form", function(event){
		        // disable warning
		        $(window).off('beforeunload');
		    });
		});
		
    </script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>