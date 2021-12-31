<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용게시판</title>
<link href="resources/spaceCss/space_default.css" rel="stylesheet">
<link href="resources/spaceCss/space_boardList.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container">
		<h3>
			<img class="i-img" src="resources/spaceImage/board.png"
				style="width: 40px;"> 사용게시판 
							<c:if test="${!empty sessionScope.m }">
			<button class="writeBtn" type="button" class="btn btn-info btn-lg"
				data-toggle="modal" data-target="#myModal">글쓰기</button>
		</c:if>
		</h3>
		<input type="hidden" id="memberId" value="${sessionScope.m.memberId }">

		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<c:if test="${empty sessionScope.m  }">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">로그인 후 사용 가능 합니다.</h4>
						</div>
						<div class="modal-body">
							<a href="/loginFrm.do">로그인</a>
						</div>
					</c:if>
					<c:if test="${not empty sessionScope.m  }">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">작성할 대관을 선택하세요.</h4>
						</div>

						<div class="modal-body"></div>
					</c:if>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>


		<div class="table-box">
			<table class="table ">
				<tr>
					<th>No.</th>
					<th style="width: 450px;">제목</th>
					<th style="width: 200px;">작성자</th>
					<th style="width: 150px;">작성일</th>
					<th style="width: 150px;">사용공간</th>
				</tr>
				<c:forEach items="${list }" var="l" varStatus="i">
					<tr  class=" t-hover">
						<td style="line-height: 50px;">${start + i.index}</td>
						<td style="line-height: 50px;"><a href="/useBoardView.do?ubNo=${l.ubNo }">${l.ubTitle }</a></td>
						<td style="line-height: 50px;">${l.memberId }</td>
						<td style="line-height: 50px;">${l.ubDate }</td>
						<td style="line-height: 50px;">${l.spaceName }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="page-box">${pageNavi }</div>
	
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
		$(".writeBtn").click(
				function() {
					$.ajax({
						url : "/selectSpaceBoard.do",
						data : {
							memberId : $("#memberId").val()
						},
						type : "get",
						success : function(data) {
							if (data.length > 0) {
								$(".modal-body").empty();
								for (var i = 0; i < data.length; i++) {
									$(".modal-body").append(
											"<a class='choice' href = '/writeSpaceBoard.do?rentalNo="
													+ data[i].rentalNo + "'>"
													+ data[i].spaceName + "/"
													+ data[i].rentalDate
													+ "</a><br>");
								}
							} else {
								$(".modal-body").empty();
								$(".modal-body").append(
										"<p>작성할 대관 내역이 없습니다.</p>")
							}
						}
					});
				});
	</script>
</body>
</html>