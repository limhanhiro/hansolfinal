<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글/댓글</title>
<link rel="stylesheet" href="/resources/additionCss/myFree.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.css">
	<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.js"></script>
	<div class="container" id="container">
			<c:if test="${sessionScope.m.memberLevel eq 0 }">
			<div class="boardName">공지게시판</div>
			<div class="table">
				<table id="noticeb" class="display" style="width:100%">
					<thead>
						<tr id="firtr">
							<td>선택</td>
							<td>번호</td>
							<td>제목</td>
							<td>작성일</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${noticeList }" var="b" varStatus="i">
							<tr>
								<td><input type="checkbox"  class="chkn"></td>
								<td><input type="hidden" value="${b.boardNo }">${i.count }</td>
								<td id="btitle"><a
									href="/boardView.do?boardType=1&boardNo=${b.boardNo}">${b.boardTitle }&nbsp;</a></td>
								<td>${b.regDate }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<button id="btnColor" class="btn btn-danger chkDeleteNotice">공지글삭제</button>
			</div>	
			</c:if>	
			<div class="boardName">소통게시판</div>
			<div id="ftable" class="table">
				<table id="freeb" class="display" style="width:100%">
					<thead>
						<tr id="firtr">
							<td>선택</td>
							<td>번호</td>
							<td>제목</td>
							<td>작성일</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${freeList }" var="b" varStatus="i">
							<tr>
								<td><input type="checkbox" class="chkf"></td>
								<td><input type="hidden" value="${b.boardNo }">${i.count }</td>
								<c:choose>
									<c:when test="${b.boardLevel==2 }">
									<td id="btitle"><a
										href="/boardView.do?boardType=3&boardNo=${b.boardNo}">(관리자 규제중)${b.boardTitle }&nbsp;[${b.commentCount }]</a></td>
									<td>${b.regDate }</td>
									</c:when>
									<c:otherwise>
									<td id="btitle"><a
										href="/boardView.do?boardType=3&boardNo=${b.boardNo}">${b.boardTitle }&nbsp;[${b.commentCount }]</a></td>
									<td>${b.regDate }</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<button id="btnColor" class="btn btn-danger chkDeleteFree">소통글삭제</button>
				</div>
				<div class="boardName">문의게시판</div>
				<div class="table">
				<table id="qnab" class="display" style="width:100%">
						<thead>
							<tr id="firtr">
							 	<td>선택</td>
								<td>번호</td>
								<td>제목</td>
								<td>답변상태</td>
								<td>작성일</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${qnaList }" var="b" varStatus="i">
								<tr>
									<td><input type="checkbox" class="chkq"></td>
									<td><input type="hidden" value="${b.boardNo }">${i.count }</td>
									<td id="btitle"><a
										href="/boardView.do?boardType=2&boardNo=${b.boardNo}">${b.boardTitle }&nbsp;</a></td>
									<c:choose>
										<c:when test="${b.commentCount ne 0}">
										<td id="answerAfter">답변완료</td>
										</c:when>
										<c:otherwise>
										<td id="answerBefore">미답변</td>
										</c:otherwise>
									</c:choose>
									<td>${b.regDate }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<button id="btnColor" class="btn btn-danger chkDeleteQna">문의글삭제</button>
					</div>
					<div class="boardName">댓글</div>
					<div class="table">
					<table id="commentb" class="display" style="width:100%">
						<thead>
							<tr id="firtr">
								<td>선택</td>
								<td>번호</td>
								<td>댓글</td>
								<td>글제목</td>
								<td>작성일</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${commentList }" var="b" varStatus="i">
								<tr>
									<td><button id="btnColor" class="btn btn-danger chkDeleteCmt">삭제</button></td>
									<td><input class="bcNo" type="hidden" value="${b.bcNo }">${i.count }</td>
									<td><input class="bcRef" type="hidden" value="${b.bcRef }">${b.bcContent }</td>
									<td id="btitle"><a href="/boardView.do?boardType=${b.boardType }&boardNo=${b.boardRef }">${b.boardTitle }</a></td>
									<td>${b.regDate }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>
		</div>
	<script type="text/javascript">
	 $(document).ready(function() {
	        $("#noticeb").DataTable({
	        	 "language": { //메뉴한글화
		        		"decimal" : "",
		                "emptyTable" : "쓴 공지글이 없습니다.",
		                "info" : "총 _TOTAL_개   _START_에서 _END_까지 표시",
		                "infoEmpty" : "총 0개",
		                "infoFiltered" : "(전체 _MAX_  중 검색결과)",
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
	        $("#freeb").DataTable({
	        	columnDefs:[
	        		{targets:[0],width:"30px"},
	        		{targets:[1],width:"30px"},
	        		{targets:[2],width:"70%"}
	        	],
	        	 "language": { //메뉴한글화
		        		"decimal" : "",
		                "emptyTable" : "쓴 소통게시글이 없습니다.",
		                "info" : "총 _TOTAL_개   _START_에서 _END_까지 표시",
		                "infoEmpty" : "총 0개",
		                "infoFiltered" : "(전체 _MAX_  중 검색결과)",
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
	        $("#qnab").DataTable({
	        	columnDefs:[
	        		{targets:[0],width:"35px"},
	        		{targets:[1],width:"35px"},
	        		{targets:[2],width:"600px"}
	        	],
	        	 "language": { //메뉴한글화
		        		"decimal" : "",
		                "emptyTable" : "문의내역이 없습니다.",
		                "info" : "총 _TOTAL_개   _START_에서 _END_까지 표시",
		                "infoEmpty" : "총 0개",
		                "infoFiltered" : "(전체 _MAX_  중 검색결과)",
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
	        $("#commentb").DataTable({
	        	columnDefs:[
	        		{targets:[0],width:"35px"},
	        		{targets:[1],width:"35px"},
	        		{targets:[4],width:"100px"}
	        	],
	        	 "language": { //메뉴한글화
		        		"decimal" : "",
		                "emptyTable" : "쓴 댓글이 없습니다.",
		                "info" : "총 _TOTAL_개   _START_에서 _END_까지 표시",
		                "infoEmpty" : "총 0개",
		                "infoFiltered" : "(전체 _MAX_  중 검색결과)",
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
	 });
	   
	 $(".chkDeleteNotice").click(function(){
			var inputs=$(".chkn:checked");
			var num = new Array(); 
			inputs.each(function(idx,item){
				var boardNo = $(item).parent().next().children().val();
				num.push(boardNo);
			});
			if(!inputs.length){
				alert("삭제할 글을 선택해 주세요");
			}else{
			location.href="/boardDelete.do?boardNo=0&boardType=4&num="+num.join("/");
			}
		});
	 $(".chkDeleteFree").click(function(){
			var inputs=$(".chkf:checked");
			var num = new Array(); 
			inputs.each(function(idx,item){
				var boardNo = $(item).parent().next().children().val();
				num.push(boardNo);
			});
			if(!inputs.length){
				alert("삭제할 글을 선택해 주세요");
			}else{
			location.href="/boardDelete.do?boardNo=0&boardType=4&num="+num.join("/");
			}
		});
	 $(".chkDeleteQna").click(function(){
			var inputs=$(".chkq:checked");
			var num = new Array(); 
			inputs.each(function(idx,item){
				var boardNo = $(item).parent().next().children().val();
				num.push(boardNo);
			});
			if(!inputs.length){
				alert("삭제할 글을 선택해 주세요");
			}else{
			location.href="/boardDelete.do?boardNo=0&boardType=4&num="+num.join("/");
			}
		});
	 $(".chkDeleteCmt").click(function(){
		 	var idx=$(".chkDeleteCmt").index(this);
		 	var bcNo=$(".bcNo").eq(idx).val();
		 	var bcRef=$(".bcRef").eq(idx).val();
		 	location.href="/deleteComment.do?boardNo=0&boardType=4&bcNo="+bcNo+"&bcRef="+bcRef;
		});
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>