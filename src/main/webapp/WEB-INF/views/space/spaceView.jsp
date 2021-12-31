<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공간 상세보기</title>
<link href="resources/spaceCss/space_default.css" rel="stylesheet">
<link href="resources/spaceCss/space_view.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container">
	<h3><img class="i-img" src="resources/spaceImage/search.png" style="width: 40px; ">   상세보기-${s.spaceName } </h3>
		<form action="/spaceRental.do" method="post">
			<input type="hidden" value="${s.spaceNo }" name="spaceNo"
				id="spaceNo"> <input type="hidden" value="${st.stNo }"
				name="stNo">
			<!--이미지 carousel  -->
			<div class="space-img">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Wrapper for slides -->
					<div class="carousel-inner">
						<div class="item active">
							<img class="i-img"
								src="resources/spaceImage/upload/${fv[0].filename }">
						</div>
						<div class="item">
							<img class="i-img"
								src="resources/spaceImage/upload/${fv[1].filename }">
						</div>
						<div class="item">
							<img class="i-img"
								src="resources/spaceImage/upload/${fv[2].filename }">
						</div>
					</div>

					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel"
						data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#myCarousel"
						data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
			</div>
			<!-- 공간 정보 -->
			<div class="space-info">
				<table class="table table-bordered">
					<tr>
						<td colspan="2">${s.spaceName }</td>
					</tr>
					<tr>
						<th>용도</th>
						<td>${s.spacePurpose }</td>
					</tr>
					<tr>
						<th>주요시설</th>
						<td>${s.mainFacility }</td>
					</tr>
					<tr>
						<th>주요물품</th>
						<td>${s.mainProduct }</td>
					</tr>
					<tr>
						<th>수용인원</th>
						<td>최대 ${s.maxPeople }명</td>
					</tr>
					<tr>
						<th>가격</th>
						<td>${s.price }/2시간</td>
					</tr>
				</table>
				<p>
					※ 대관으로 인한 직접적인 수익이 발생하는 경우, 대관이 불가합니다.<br> 규정에 따라 대관이 취소될 수
					있습니다.
				</p>
				<p>※ 회원가입 및 로그인 후, 대관신청이 가능합니다.</p>
				<div class="goRes">
				<a href="/spaceRes.do?spaceNo=${s.spaceNo }" id="goRes">신청 하러
					가기</a>
				</div>
			</div>
			<div class="btn-box">
				<button type="button" class="open-img">이미지 보기</button>
				<button type="button" class="close-img">이미지 닫기</button>
				<button type="button" class="open-review">리뷰 보기</button>
				<button type="button" class="close-review">리뷰 닫기</button>
			</div>
			<!-- 이미지 크게보기  -->
			<div class="big-img">
				<c:forEach items="${fv }" var="fv">
					<img class="info-img"
						src="resources/spaceImage/upload/${fv.filename }">
				</c:forEach>
			</div>
			<!-- 리뷰 보기  -->
			<div class="review-box">
				<h1>Review</h1>
				<c:if test="${fn:length(srList) == 0 }">
					<p>아직 작성 된 리뷰가 없습니다.</p>
				</c:if>
				<c:forEach items="${srList }" var="sr">
					<table class="review-table">
						<tr>
							<th>작성자</th>
							<td id="content" rowspan="2">${sr.srContent }</td>
							<th id="date">작성일 : ${sr.srDate }</th>
						</tr>
						<tr>
							<th><img src="resources/spaceImage/music.png" style="width: 20px; height: 20px; margin-right: 5px;" >    ${sr.memberId }</th>
						</tr>
					</table>
				</c:forEach>
				<div class="more-box">
<%-- 				<c:if test="${count < totalCount}">
					<button type="button" class="moreBtn" id="more" currentCount="5" totalCount="${totalCount }" value="5">더보기</button>
				</c:if> --%>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
		var totalCount = $("#totalCount");

		$("#more").click(
				function() {
					var start = $(this).val();
					console.log("start :"+start);
					$.ajax({
						url : "/moreSpaceReview.do",
						data : {
							start : start,
							spaceNo : $("#spaceNo").val()
						},
						type : "post",
						success : function(data) {
							for (var i = 0; i < data.length; i++) {
								$(".review-box").append(
										"<table class='review-table'><tr><th>작성자</th><td id='content' rowspan ='2'>"
												+ data[i].srContent + "</td><th id='date'>작성일 : "+data[i].srDate+"</th></tr><tr><th><img src='resources/spaceImage/music.png' style='width: 25px; height: 25px; margin-right: 5px;' >"+data[i].memberId+"</th></tr></table>");
							}
							$("#more").val(Number(start)+5);
							var curr = Number($("#more").attr("currentCount"));
							$("#more").attr("currentCount",curr + data.length);
							var totalCount = $("#more").attr("totalCount");
							var currCount = $("#more").attr("currentCount");
							console.log("totalCount : "+totalCount);
							console.log("currCount : "+currCount);
							if(currCount >= totalCount){
								$("#more").css("display","none");
								$("#more").prop("diabled",true);
							}

						}
					});
				});
		$(function() {
			$(".big-img").hide();
			$(".close-img").hide();
			$(".review-box").hide();
			$(".close-review").hide();
			/* $("#more").hide(); */
			/*이미지 보기  */
			$(".open-img").click(function() {
				$(".close-img").show();
				$(".big-img").show();
				$(".open-img").hide();
			});
			$(".close-img").click(function() {
				$(".big-img").hide();
				$(".open-img").show();
				$(".close-img").hide();
			});
			/* 리뷰보기 */
			$(".open-review").click(function() {
				$(".close-review").show();
				$(".review-box").show();
				$(".open-review").hide();
				/* $("#more").show(); */
			});
			$(".close-review").click(function() {
				$(".review-box").hide();
				$(".open-review").show();
				$(".close-review").hide();
				/* $("#more").hide(); */
			});
		});
	</script>
</body>
</html>