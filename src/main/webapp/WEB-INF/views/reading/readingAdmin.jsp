<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/common/adminpageMenu.jsp"/>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap.min.css">
	<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.js"></script>
	<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap.min.js"></script>
	<link href="resources/readingCss/readingAdmin.css" rel="stylesheet">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/jquery-ui/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
	<script type="text/javascript" src="/resources/jquery-ui/jquery-ui.min.js"></script>
		<div class="container">
			<div class="mypage-title"><span>열</span>람실 관리</div>
			<br><br>
			<h4>최근 1주일 예약 내역 조회</h4>
			<table id="table_week" class="table table-striped table-bordered" style="width:100%">
		        <thead>
		            <tr>
		            	<th>선택</th>
		                <th>예약일</th>
		                <th>예약일자</th>
		                <th>좌석번호</th>
		                <th>예약아이디</th>
		                <th>예약자</th>
		                <th>이용시간</th>
		                <th>퇴실유무</th>
		            </tr>
		        </thead>
		        <tbody>
		        	<c:forEach	items="${list }" var="re" varStatus="i">
						<tr>
							<td class="chktd">
								<c:if test="${re.readingCheckOut eq 0}">
									<input type="checkbox" class="chk">
								</c:if>
							</td>
							<td>${re.readingTime }</td>
							<td>${re.readingDay }</td>
							<td>${re.readingNum }</td>
							<td>${re.readingId }</td>
							<td>${re.readingName }</td>
							<td>
								<c:choose>
									<c:when test="${re.readingTy eq 0}">
										종일 09:00 ~ 19:00
									</c:when>
									<c:when test="${re.readingTy eq 1}">
										오전 09:00 ~ 14:00
									</c:when>
									<c:when test="${re.readingTy eq 2}">
										오후 14:00 ~ 19:00
									</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${re.readingCheckOut eq 0}">
										미퇴실
									</c:when>
									<c:when test="${re.readingCheckOut eq 1}">
										퇴실
									</c:when>
									<c:when test="${re.readingCheckOut eq 2}">
										강제퇴실
									</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
		        </tbody>
		        <tfoot>
		        	<tr>
		        		<th colspan="8">
		        			
		        			<button onclick="out();" style="float:right; margin-right:10px">강제퇴실</button>
		        			<button onclick="early();" style="float:right; margin-right:10px">조기퇴실</button>
		        		</th>
		        	</tr>
		        	
		        </tfoot>
			</table>
			
			<br><br>
			<h4>전체 예약 내역 조회</h4>
				<table border="0" cellspacing="5" cellpadding="5">
					<tbody>
						<tr>
            				<td>시작일 : <input type="text" id="datepicker_from" name="min"></td>
            			</tr>
            			<tr>
				            <td>종료일 : <input type="text" id="datepicker_to" name="max"></td>
        				</tr>
    				</tbody>
    			</table>
			<table id="table_period" class="table table-striped table-bordered" style="width:100%">
			<thead>
		            <tr>
		                <th>예약일</th>
		                <th>예약일자</th>
		                <th>좌석번호</th>
		                <th>예약아이디</th>
		                <th>예약자</th>
		                <th>이용시간</th>
		                <th>퇴실유무</th>
		            </tr>
		        </thead>
		        <tbody>
		        	<c:forEach	items="${alllist }" var="allre" varStatus="i">
			        	<tr>
							<td>${allre.readingTime }</td>
							<td>${allre.readingDay }</td>
							<td>${allre.readingNum }</td>
							<td>${allre.readingId }</td>
							<td>${allre.readingName }</td>
							<td>
								<c:choose>
									<c:when test="${allre.readingTy eq 0}">
										종일 09:00 ~ 19:00
									</c:when>
									<c:when test="${allre.readingTy eq 1}">
										오전 09:00 ~ 14:00
									</c:when>
									<c:when test="${allre.readingTy eq 2}">
										오후 14:00 ~ 19:00
									</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${allre.readingCheckOut eq 0}">
										미퇴실
									</c:when>
									<c:when test="${allre.readingCheckOut eq 1}">
										퇴실
									</c:when>
									<c:when test="${allre.readingCheckOut eq 2}">
										강제퇴실
									</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
		        </tbody>
			</table>
			
			<br><br>
			<h4>블랙리스트 조회</h4>
			<table id="table_black" class="table table-striped table-bordered" style="width:100%">
		        <thead>
		            <tr>
		                <th>등록일자</th>
		                <th>해제일자</th>
		                <th>등록ID</th>
		                <th>등록이름</th>
		            </tr>
		        </thead>
		        <tbody>
		        	<c:forEach	items="${black }" var="bl" varStatus="i">
						<tr>
							<td>${bl.blackStart }</td>
							<td>${bl.blackEnd }</td>
							<td>${bl.blackId }</td>
							<td>${bl.memberName }</td>
						</tr>
					</c:forEach>
		        </tbody>
			</table>
			
			<br><br>
					<table id="table_fixtures" class="table table-striped table-bordered" style="width:100%">
					        <thead>
					            <tr>
					                <th>예약일</th>
					                <th>대여일자</th>
					                <th>좌석번호</th>
					                <th>대여아이디</th>
					                <th>대여자</th>
					                <th>충전기</th>
					                <th>독서대</th>
					                <th>담요</th>
					            </tr>
					        </thead>
					        <tbody>
					        	<c:forEach	items="${fi }" var="fi" varStatus="i">
									<tr>
										<td>${fi.fixturesTime }</td>
										<td>${fi.fixturesDay }</td>
										<td>${fi.fixturesNum }</td>
										<td>${fi.fixturesId }</td>
										<td>${fi.fixturesName }</td>
										<td>${fi.fixturesCharger }</td>
										<td>${fi.fixturesTable }</td>
										<td>${fi.fixturesBlanket }</td>
									</tr>
								</c:forEach>
					        </tbody>
						</table>
			<script>
			    $(document).ready(function() {
			        $("#table_week").DataTable({
			        	 order: [[ 2, "asc" ],[ 3, "asc" ]], //정렬
			        	 "language": { //메뉴한글화
				        		"decimal" : "",
				                "emptyTable" : "데이터가 없습니다.",
				                "info" : "총 _TOTAL_명   _START_에서 _END_까지 표시",
				                "infoEmpty" : "0명",
				                "infoFiltered" : "(전체 _MAX_ 명 중 검색결과)",
				                "infoPostFix" : "",
				                "thousands" : ",",
				                "lengthMenu" : "_MENU_ 개씩 보기",
				                "loadingRecords" : "로딩중...",
				                "processing" : "처리중...",
				                "search" : "검색 : ",
				                "zeroRecords" : "검색된 데이터가 없습니다.",
				                "paginate" : {
				                    "first" : "첫 페이지",
				                    "last" : "마지막 페이지",
				                    "next" : "다음",
				                    "previous" : "이전"
				                },
				                "aria" : {
				                    "sortAscending" : " :  오름차순 정렬",
				                    "sortDescending" : " :  내림차순 정렬"
				                }
				            }
			        });
			        $("#table_period").DataTable({
			        	 order: [[ 1, "asc" ],[ 2, "asc" ]], //정렬
			        	 "language": { //메뉴한글화
				        		"decimal" : "",
				                "emptyTable" : "데이터가 없습니다.",
				                "info" : "총 _TOTAL_명   _START_에서 _END_까지 표시",
				                "infoEmpty" : "0명",
				                "infoFiltered" : "(전체 _MAX_ 명 중 검색결과)",
				                "infoPostFix" : "",
				                "thousands" : ",",
				                "lengthMenu" : "_MENU_ 개씩 보기",
				                "loadingRecords" : "로딩중...",
				                "processing" : "처리중...",
				                "search" : "검색 : ",
				                "zeroRecords" : "검색된 데이터가 없습니다.",
				                "paginate" : {
				                    "first" : "첫 페이지",
				                    "last" : "마지막 페이지",
				                    "next" : "다음",
				                    "previous" : "이전"
				                },
				                "aria" : {
				                    "sortAscending" : " :  오름차순 정렬",
				                    "sortDescending" : " :  내림차순 정렬"
				                }
				            }
			        });
			        $("#table_black").DataTable({
			        	 order: [[ 1, "asc" ]],
			        	 "language": { //메뉴한글화
				        		"decimal" : "",
				                "emptyTable" : "데이터가 없습니다.",
				                "info" : "총 _TOTAL_명   _START_에서 _END_까지 표시",
				                "infoEmpty" : "0명",
				                "infoFiltered" : "(전체 _MAX_ 명 중 검색결과)",
				                "infoPostFix" : "",
				                "thousands" : ",",
				                "lengthMenu" : "_MENU_ 개씩 보기",
				                "loadingRecords" : "로딩중...",
				                "processing" : "처리중...",
				                "search" : "검색 : ",
				                "zeroRecords" : "검색된 데이터가 없습니다.",
				                "paginate" : {
				                    "first" : "첫 페이지",
				                    "last" : "마지막 페이지",
				                    "next" : "다음",
				                    "previous" : "이전"
				                },
				                "aria" : {
				                    "sortAscending" : " :  오름차순 정렬",
				                    "sortDescending" : " :  내림차순 정렬"
				                }
				            }
			        });
			        $("#table_fixtures").DataTable({
			        	 order: [[ 1, "asc" ],[ 2, "asc" ]],
			        	 "language": { //메뉴한글화
				        		"decimal" : "",
				                "emptyTable" : "데이터가 없습니다.",
				                "info" : "총 _TOTAL_명   _START_에서 _END_까지 표시",
				                "infoEmpty" : "0명",
				                "infoFiltered" : "(전체 _MAX_ 명 중 검색결과)",
				                "infoPostFix" : "",
				                "thousands" : ",",
				                "lengthMenu" : "_MENU_ 개씩 보기",
				                "loadingRecords" : "로딩중...",
				                "processing" : "처리중...",
				                "search" : "검색 : ",
				                "zeroRecords" : "검색된 데이터가 없습니다.",
				                "paginate" : {
				                    "first" : "첫 페이지",
				                    "last" : "마지막 페이지",
				                    "next" : "다음",
				                    "previous" : "이전"
				                },
				                "aria" : {
				                    "sortAscending" : " :  오름차순 정렬",
				                    "sortDescending" : " :  내림차순 정렬"
				                }
				            }
			        });
			    } );
			    
			    
			    $(function() {
			    	  var oTable = $('#table_period').DataTable(); //매번 붙이기 싫어서
			    	  
			    	  $("#datepicker_from").datepicker({ //시작날짜
			    		  dateFormat : "yy-mm-dd",
							monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월','7월', '8월', '9월', '10월', '11월', '12월' ],
							monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월','7월', '8월', '9월', '10월', '11월', '12월' ],
							dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
							dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
							dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
							yearSuffix : '년',
							"onSelect": function(date) {
							      minDateFilter = new Date(date).getTime(); //datepicker로 선택했을때
							      oTable.draw();//새고로침
							    }
			    	  }).keyup(function() {
			    	    minDateFilter = new Date(this.value).getTime(); //직접입력했을때
			    	    oTable.draw(); //새로고침
			    	  });
			    	  
			    	  $("#datepicker_to").datepicker({ //종료날짜
			    		  dateFormat : "yy-mm-dd",
							monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월','7월', '8월', '9월', '10월', '11월', '12월' ],
							monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월','7월', '8월', '9월', '10월', '11월', '12월' ],
							dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
							dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
							dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
							yearSuffix : '년',
							"onSelect": function(date) {
							      maxDateFilter = new Date(date).getTime();
							      oTable.draw();
							    }
			    	  }).keyup(function() {
			    	    maxDateFilter = new Date(this.value).getTime();
			    	    oTable.draw();
			    	  });

			    	});
			    
			    minDateFilter = ""; //없으면 오류남 아마 기본형식인 느낌
			    maxDateFilter = "";

			    $.fn.dataTableExt.afnFiltering.push(
			      function(oSettings, aData, iDataIndex) {
			        if (typeof aData._date == 'undefined') {
			          aData._date = new Date(aData[1]).getTime(); //예약일자 위치가 두번째라 aData[1]
			        }

			        if (minDateFilter && !isNaN(minDateFilter)) {
			          if (aData._date < minDateFilter) {
			            return false;
			          }
			        }

			        if (maxDateFilter && !isNaN(maxDateFilter)) {
			          if (aData._date > maxDateFilter) {
			            return false;
			          }
			        }

			        return true;
			      }
			    );
			    
			    function out(){
					var inputs = $(".chk:checked");
			    	var readingDay = new Array();
			    	var readingId = new Array();
			    	
					var today = new Date();
					var year = today.getFullYear();
				    var month = ("0" + (1 + today.getMonth())).slice(-2);
				    var day = ("0" + today.getDate()).slice(-2);
					var str = year+"-"+month+"-"+day;
					
					var form = $("<form action='/outAndBlackList.do' method='post'></form>");
				    inputs.each(function(idx,item){
						var day = $(item).parent().next().next().html();
						readingDay.push(day);
						form.append($("<input type='hidden' name='dayList' value='"+day+"'>"));
						var id = $(item).parent().next().next().next().next().html();
						readingId.push(id);
						form.append($("<input type='hidden' name='idList' value='"+id+"'>"));
					});
					$("body").append(form);
					if(str!=readingDay[0]){
						alert("오늘 내역만 수정할 수 있습니다.")
					}else{
				   		form.submit();
					}
			    };
		
			    function early(){
					var inputs = $(".chk:checked");
			    	var readingDay = new Array();
			    	var readingId = new Array();
			    	
					var today = new Date();
					var year = today.getFullYear();
				    var month = ("0" + (1 + today.getMonth())).slice(-2);
				    var day = ("0" + today.getDate()).slice(-2);
					var str = year+"-"+month+"-"+day;
		
					var form = $("<form action='/earlyOut.do' method='post'></form>");
			    	inputs.each(function(idx,item){
						var day = $(item).parent().next().next().html();
						readingDay.push(day);
						form.append($("<input type='hidden' name='dayList' value='"+day+"'>"));
						var id = $(item).parent().next().next().next().next().html();
						readingId.push(id);
						form.append($("<input type='hidden' name='idList' value='"+id+"'>"));
					});
					$("body").append(form);
					if(str!=readingDay[0]){
						alert("오늘 내역만 수정할 수 있습니다.")
					}else{
				   		form.submit();
					}
			    };
			    
			</script>
		</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>