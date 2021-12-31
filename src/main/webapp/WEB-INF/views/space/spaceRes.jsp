<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공간 예약</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<link rel="stylesheet"
		href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
	<script type="text/javascript"
		src="/resources/jquery-ui/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="/resources/jquery-ui/jquery-ui-big.css">
	<link href="resources/spaceCss/space_default.css" rel="stylesheet">
	<link href="resources/spaceCss/space_res.css" rel="stylesheet">
	<div class="container">
		<div class="cal">
			<c:if test="${ !empty s.spaceName  }">
				<h3>
					<img class="i-img" src="resources/spaceImage/appointment.png"
						style="width: 40px;"> 신청 현황   -   ${s.spaceName }
				</h3>
			</c:if>
			<c:if test="${ empty s.spaceName  }">
				<h3>
					<img class="i-img" src="resources/spaceImage/appointment.png"
						style="width: 40px;"> 공간을 선택해주세요.
				</h3>
			</c:if>
			<form action="/spaceInfo.do" method="post">
				<input type="hidden" value="${s.spaceNo  }" name="spaceNo">
				<div class="select-btn">
					<c:forEach items="${list }" var="l">
						<c:choose>
							<c:when test="${s.spaceNo eq l.spaceNo }">
								<button id="active" type="button"
									onclick="location.href='/spaceRes.do?spaceNo=${l.spaceNo}'">${l.spaceName }</button>
							</c:when>
							<c:otherwise>
								<button type="button"
									onclick="location.href='/spaceRes.do?spaceNo=${l.spaceNo}'">${l.spaceName }</button>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<!-- 캘린더 코드 -->
				<div id="datepicker"></div>
		</div>
		<div class="time-table">
			<table class="table table-hover">
				<tr>
					<td id="selectTime" colspan="5">시간 선택</td>
				</tr>
				<c:forEach items="${st }" var="st" varStatus="i">
					<tr>
						<td>이용시간<input type="hidden" value="${st.stNo }"></td>
						<td><input type="text" id="startTime"
							value="${st.startTime }" disabled="disabled"></td>
						<td>~</td>
						<td><input type="text" id="endTime" value="${st.endTime }"
							disabled="disabled"></td>
						<td><button id="chkBtn" type="button" class="checkBtn">선택</button>
							<span>마감</span></td>
					</tr>
				</c:forEach>
			</table>
			<table class="table">
				<tr>
					<td>▶ 선택한날짜</td>
					<td colspan="4">
						<input type="text" class="selectDate" disabled="disabled">
						<input type="hidden" class="selectDate" name="rentalDate" > 
					</td>
				</tr>
				<tr>
					<td>▶ 선택시간</td>
					<td><input type="text" name="startTime" disabled="disabled"></td>
					<td>~</td>
					<td><input type="text" name="endTime" disabled="disabled"></td>
				</tr>
			</table>
			<input type="hidden" name="stNo">
			<div id="insert-btn">
						<c:if test="${empty sessionScope.m  }">
							<button class="btn btn-default" type="button"
								onclick="location.href='/loginFrm.do'">로그인 후 예약하기</button>
					</c:if>
				<c:if test="${blackCount > 0}">
					<c:if test="${not empty sessionScope.m }">
						<div class="box">현재 예약이 불가능한 아이디 입니다.</div>
					</c:if>
				</c:if>
				<c:if test="${blackCount == 0}">
					<c:if test="${not empty sessionScope.m }">
						<button onclick="return checkAgree();" class="btn btn-default"
									id="resBtn" type="submit">신청하기</button>
					</c:if>
				</c:if>
			</div>
		</div>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
		function checkAgree() {
			if ($("[name=rentalDate]").val() == "") {
				alert("날짜를 선택 하세요.");
				$("[name=rentalDate]").focus();
				return false;
			}
			if ($("[name=startTime]").val() == "") {
				alert("시간을 선택 하세요.");
				$("[name=startTime]").focus();
				return false;
			}
		}
		$(function() {
			$(".time-table").hide();

		});
		$(function() {
			var today = new Date(); //오늘부터
			var naeil = today.getFullYear()+"-"+(today.getMonth()+1)+"-"+(today.getDate()+1);
			var endDate = new Date(today);
			endDate.setDate(endDate.getDate() + 30); //+30일까지만 예약받음
			$("#datepicker").datepicker(
					{
						//캘린더 기본베이스
						dateFormat : "yy-mm-dd",
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
						dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
						dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
						yearSuffix : '년',
						minDate : naeil,
						maxDate : endDate,
						beforeShowDay : noMondays, //월요일은 휴무일
						onSelect : function(data) {
							$(".selectDate").val(data);
							$(".time-table").show();
							selectResList(data);
						}
					});
		});
		//예약한 시간 값 조회
		function selectResList(selectDate) {
			var spaceNo = $("[name=spaceNo]").val();
			$
					.ajax({
						url : "/selectResList.do",
						data : {
							selectDate : selectDate,
							spaceNo : spaceNo
						},
						type : "get",
						success : function(data) {
							var btn = $(".checkBtn");
							btn.hide();
							btn.next().hide();
							//예약할 수 있는 시간의 개수
							for (var i = 0; i < btn.length; i++) {
								//예약마감이 되었는지 체크를 위한 변수
								var bool = true;
								//이미 예약한 시간의 개수
								for (var j = 0; j < data.length; j++) {
									//만약 예약한 시간과 예약할 수 있는 시간이 같다면
									if (data[j].startTime === btn.eq(i)
											.parent().parent().children().eq(1)
											.children().val()) {
										//예약마감 보여주기
										btn.eq(i).next().show();
										bool = false;
									}
								}
								//예약이 가능할 경우
								if (bool) {
									btn.eq(i).show();
								}
							}
						}
					});
		}
		//월요일 휴무 코드
		function noMondays(date) {
			return [ date.getDay() != 1, '' ];
		}
		$(".checkBtn").click(function() {
			var str = ""
			var tdArr = new Array(); // 배열 선언
			var checkBtn = $(this);
			var tr = checkBtn.parent().parent();
			var td = tr.children();

			var startTime = td.eq(1).find('input').val();
			var endTime = td.eq(3).find('input').val();
			var stNo = td.eq(0).find('input').val();

			// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
			td.each(function(i) {
				tdArr.push(td.eq(i).text());
			});

			$("[name=startTime]").val(startTime);
			$("[name=endTime]").val(endTime);
			$("[name=stNo]").val(stNo);
		});
	</script>
</body>
</html>