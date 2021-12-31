<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소통게시판</title>
<script src="https://kit.fontawesome.com/4054b6ceaa.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/additionCss/freeView.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container" id="container">
		<input id="loginId" type="hidden" value="${sessionScope.m.memberId }">
		<input type="hidden" id="boardNo" value="${b.boardNo }">
		<div id="btns">
			<a class="btn btnColor ncolor" href="/additionBoard.do?boardType=3&reqPage=1">글목록</a>


			<c:choose>
				<c:when test="${sessionScope.m.memberLevel eq 0 && sessionScope.m.memberId == b.boardWriter}">
					<c:choose>
						<c:when test="${b.boardLevel eq 2 }">
							<a class="btn btnColor basicColor" href="/removeRegulationBoard.do?boardNo=${b.boardNo }">규제풀기</a>
						</c:when>
						<c:otherwise>
							<a class="btn btnColor basicColor" href="/regulationBoard.do?boardNo=${b.boardNo }">규제하기</a>
						</c:otherwise>
					</c:choose>
					<a class="btn btnColor basicColor" href="/boardDelete.do?num=&boardType=3&boardNo=${b.boardNo }">글삭제</a>
					<a class="btn btnColor basicColor" href="/boardUpdateFrm.do?boardType=3&boardNo=${b.boardNo }">글수정</a>
				</c:when>
				<c:when test="${sessionScope.m.memberId == b.boardWriter}"> <!--글쓴이 일반회원 글삭제 글수정  -->
					<a class="btn btnColor basicColor" href="/boardDelete.do?num=&boardType=3&boardNo=${b.boardNo }">글삭제</a>
					<a class="btn btnColor basicColor" href="/boardUpdateFrm.do?boardType=3&boardNo=${b.boardNo }">글수정</a>
				</c:when>
				<c:when test="${sessionScope.m.memberLevel eq 0 }">
						<c:choose>
						<c:when test="${b.boardLevel eq 2 }">
							<a id="regu" class="btn btnColor basicColor" href="/removeRegulationBoard.do?boardNo=${b.boardNo }">규제풀기</a>
							</c:when>
							<c:otherwise>
							<a  class="btn btnColor basicColor" href="/regulationBoard.do?boardNo=${b.boardNo }">규제하기</a>
							</c:otherwise>
						</c:choose>
					<a class="btn btnColor basicColor" href="/boardDelete.do?num=&boardType=3&boardNo=${b.boardNo }">글삭제</a>
				</c:when>
				
				<c:otherwise>
				</c:otherwise>
			</c:choose>
			
		</div>
		<div id="table">
		
			<table id="table1" class="table">
				<c:choose>
					<c:when test="${b.boardLevel eq 2 }">
					<tr>
						<td id="boardTitle" colspan="7"><span id="ban">(관리자 규제중)</span>${b.boardTitle }</td>
					</tr>
					</c:when>
					<c:otherwise>
					<tr>
						<td id="boardTitle" colspan="7">${b.boardTitle }</td>
					</tr>
					</c:otherwise>
				</c:choose>
				
				<tr>
					<td>${b.boardWriter }</td>
					<td>조회수</td>
					<td>${b.readCount }</td>
					<td>작성일</td>
					<td>${b.regDate }</td>
					<td>댓글수</td>
					<td>${b.commentCount }</td>
				</tr>
				<c:if test="${not empty b.filename }">
				<tr>
					<td>첨부파일</td>
					<td colspan="6">
						<a class="btnColor" href="/fileDown.do?filepath=${b.filepath }&filename=${b.filename }">${b.filename }</a>
					</td>
				</tr>
				</c:if>
				<tr>
					<td colspan="7"><div style="min-height: 200px;">${b.boardContent }</div>
						<div id="likechk">
					    <input type="radio" value="like" name="likechk" id="like" onclick="return check(0);"><label for="like" ><i class="fas fa-thumbs-up"><span id="likeResult" >&nbsp;${l.likeSum }</span>&nbsp;&nbsp;좋아요</i></label>
					    <input type="radio" value="dislike" name="likechk" id="dislike" onclick="return check(1);"><label for="dislike"><i class="fas fa-thumbs-down"><span id="dislikeResult">&nbsp;${l.dislikeSum }</span>&nbsp;&nbsp;싫어요</i></label>
					    </div>
					</td>
				</tr>
			</table>
			
			
			
			<!-- 댓글쓰기창 로그인 되있을때 -->
			
				<div class="inputCommentBox">
					<form action="/insertComment.do?boardType=3" method="post">
						<ul>
							<li>
								<i class="far fa-comment-dots fa-3x"></i>
							</li>
							<li>
								<input type="hidden" name="bcLevel" value="1">
								<input type="hidden" name="bcWriter" value="${sessionScope.m.memberId }">
								<input type="hidden" name="boardRef" value="${b.boardNo }">
								<input type="hidden" name="bcRef" value="0">
								<input type="hidden" name="bcidRef" value="">
								<textarea id="comment" name="bcContent" class="form-control"></textarea>
							</li>
							<li>
								<button type="submit" id="submitBtn" class="btn btn-primary btn-lg btn-block" onclick="return commentChk();">등록</button>
							</li>
						</ul>
					</form>
				</div>

			
			<!-- 댓글출력 -->
			<div class="commentBox">
				<c:forEach items="${list }" var="bc">
					<!-- ncLevel ==1 일반댓글인 경우 -->
					<c:if test="${bc.bcLevel eq 1 }">
						<ul class="comments">
							<li>
								<p>${bc.bcWriter }</p>
								<p>${bc.regDate }</p>
							</li>
							<li>
								<p>${bc.bcContentBr }</p>
								<textarea name="bcContent" class="form-control" style="display:none;">${bc.bcContentBr }</textarea><!-- 수정시보임 -->
								<p class="commentsBtn">
									<c:if test="${sessionScope.m.memberId eq bc.bcWriter }">
										<a href="javascript:void(0)"  class="btnColor" onclick="modifyComment(this,'${bc.bcNo }','${b.boardNo }','${bc.bcRef }','${bc.bcDel }');">수정</a>
										<a href="javascript:void(0)" class="btnColor" onclick="deleteComment(this,'${bc.bcNo }','${b.boardNo }','${bc.bcRef }','${bc.bcDel }');">삭제</a>
									</c:if>
									<a href="javascript:void(0)" class="recShow btnColor">답글달기</a>
									<input class="delchk" type="hidden" value="${bc.bcDel }">
								</p>
								<form action="/insertComment.do?boardType=3" class="recoment" method="post"> <!-- recoment 클래스가 안보이게 하는 속성 -->
									<input type="hidden" name="bcLevel" value="2">
									<input type="hidden" name="bcWriter" value="${sessionScope.m.memberId }"> <!--로그인 된 아이디로 변경해야함 -->
									<input type="hidden" name="boardRef" value="${b.boardNo }">
									<input type="hidden" name="bcRef" value="${bc.bcNo }">
									<input type="hidden" name="bcidRef" value=""> 
									<textarea id="bcContent" name="bcContent" class="bcContent form-control"></textarea> 
									<div>
										<button type="submit" class="recomment btn btn-outline-primary">등록</button>
										<button type="reset" class="btn btn-outline-primary recCancel">취소</button>
									</div>
								</form>
							</li>
						</ul>
						<!-- 대댓글 시작 -->
						<c:forEach items="${list }" var="bcc">
							<c:if test="${bcc.bcLevel eq 2 && bc.bcNo eq bcc.bcRef }">
								<ul class="recomments">
									<li>
										<i class="fas fa-arrow-right"></i><!-- 화살표 -->
									</li>
									<li>
										<p>${bcc.bcWriter }</p>
										<p>${bcc.regDate }</p>
									</li>
									<li>
										<c:choose>
											<c:when test="${not empty bcc.bcidRef }">
											<p><span id="tag">@${bcc.bcidRef}</span> ${bcc.bcContentBr }</p>
											</c:when>
											<c:otherwise>
											<p>${bcc.bcContentBr }</p>
											</c:otherwise>
										</c:choose>
										<textarea name="bcContent" class="form-control" style="display:none;">${bcc.bcContentBr }</textarea>
										<p class="commentsBtn">
											<c:if test="${sessionScope.m.memberId eq bcc.bcWriter }">
												<a href="javascript:void(0)" class="btnColor" onclick="modifyComment(this,'${bcc.bcNo }','${b.boardNo }','${bcc.bcRef }','${bcc.bcDel }');">수정</a>
												<a href="javascript:void(0)" class="btnColor"class="btn btnColor" onclick="deleteComment(this,'${bcc.bcNo }','${b.boardNo }','${bcc.bcRef }');">삭제</a>
											</c:if>	
												<a href="javascript:void(0)" class="recShow btnColor">답글달기</a>
										</p>
										<form action="/insertComment.do?boardType=3" class="recoment" method="post"> <!-- recoment 클래스가 안보이게 하는 속성 -->
											<input type="hidden" name="bcLevel" value="2">
											<input type="hidden" name="bcWriter" value="${sessionScope.m.memberId }"> <!--로그인 된 아이디로 변경해야함 -->
											<input type="hidden" name="boardRef" value="${b.boardNo }">
											<input type="hidden" name="bcRef" value="${bc.bcNo }">
											<input type="hidden" name="bcidRef" value="${bcc.bcWriter} "> 
											<textarea name="bcContent" class="bcContent form-control"></textarea> 
											<div>
												<button type="submit" class="recomment btn btn-outline-primary">등록</button>
												<button type="reset" class="btn btn-outline-primary recCancel">취소</button>
											</div>
										</form>
									</li>
								</ul>
							</c:if>
						</c:forEach>
					</c:if>
				</c:forEach>
			</div>
			
			<div><span class="nextTitle">다음글</span>&nbsp;
				<a href="/boardView.do?boardType=3&boardNo=${info.nextNo}" onclick="return chkNext();">
				<input type="hidden" id="next" value="${info.nextNo }">${info.nextTitle }
				</a>
			</div>
			<div><span class="nextTitle">이전글</span>&nbsp;
				<a href="/boardView.do?boardType=3&boardNo=${info.prevNo}" onclick="return chkPrev();">
				<input type="hidden" id="prev" value="${info.prevNo }">${info.prevTitle }
				</a>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		 var checkNum;
		 var alreadyLike;
	 $(document).ready(function() {
			var loginId = $("#loginId").val();
			var boardNo = $("#boardNo").val();
			if(loginId != ""){
				$.ajax({
					url : "/selectLikeChk.do",
					data : {boardNo:boardNo,memberId:loginId},
					success : function(data){
							if(data.likeSum==1){
								checkNum=0;
								alreadyLike=1;
								$("#like").prop('checked',true);
							}else if(data.dislikeSum==1){
								checkNum=1;
								alreadyLike=1;
								$("#dislike").prop('checked',true);
							}
					}
				});	   
			}
			
	    });
	
	function check(num){
		var loginId = $("#loginId").val();
		if(loginId == ""){
			alert("로그인 후 이용하실 수 있습니다.");
			return false;
		}
		var boardNo = $("#boardNo").val();
		var obj = $('input:radio[name="likechk"]');
		if(checkNum==num){//취소함
		obj.eq(num).prop('checked',false);
		checkNum = null;
		alreadyLike=0;
			$.ajax({
				url : "/boardDislike.do",
				data : {memberId:loginId,boardNo:boardNo},
				success : function(data){
					if(data=="0"){
						console.log("성공");
					}else if(data=="1"){
						console.log("실패");
					}
					
					$.ajax({
						url : "/selectLikeSum.do",
						data : {boardNo:boardNo},
						success : function(data){
							$("#likeResult").empty();
							$("#dislikeResult").empty();
							if(data!="0"){
							$("#likeResult").append("&nbsp;"+data.likeSum);
							$("#dislikeResult").append("&nbsp;"+data.dislikeSum);
							}
						}
					});
					
				}
			});
		
		
		}else{ //새로 누름
		if(alreadyLike==1){
			return false;
		}
		checkNum = num;
			$.ajax({
				url : "/boardLike.do",
				data : {memberId:loginId,boardNo:boardNo,checkNum:checkNum},
				success : function(data){
					if(data=="0"){
						console.log("성공");
						alreadyLike=1;
					}else if(data=="1"){
						console.log("실패");
					}
					
					$.ajax({
						url : "/selectLikeSum.do",
						data : {boardNo:boardNo},
						success : function(data){
							$("#likeResult").empty();
							$("#dislikeResult").empty();
							$("#likeResult").append("&nbsp;"+data.likeSum);
							$("#dislikeResult").append("&nbsp;"+data.dislikeSum);
						}
					});
				}
			});
		}
	}
	
	
	$(document).on("click",".recomment",function(){
		var idx=$(".recomment").index(this);
		var bcContent=$(".bcContent").eq(idx).val();
		if(bcContent==""){
			alert("내용을 입력하세요.");
			return false;
		}
    });
	
	
	//답댓글 등록창 켜기
	$(".recShow").click(function(){
		var loginId = $("#loginId").val();
		if(loginId == ""){
			alert("로그인 후 이용하실 수 있습니다.");
			return false;
		}
		//몇번째 답글달기 버튼을 클릭했는지
		var idx=$(".recShow").index(this);
		var delchk= $(".delchk").eq(idx).val();
		if(delchk==1){
			return false;
		}
		$(this).hide();
		$(".recoment").eq(idx).css("display","flex");
	});
	
	//답댓글 등록창 끄기
	$(".recCancel").click(function(){
		var idx=$(".recCancel").index(this);
		$(".recoment").eq(idx).css("display","none");
		$(".recShow").eq(idx).show();
	});
	
	//댓글삭제
	function deleteComment(obj,bcNo,boardNo,bcRef,bcDel){
		if(bcDel==1){
			return false;
		}
		if(confirm("댓글을 삭제하시겠습니까?")){
			location.href="/deleteComment.do?boardType=3&bcNo="+bcNo+"&boardNo="+boardNo+"&bcRef="+bcRef;
		}
	}
	
	//댓글수정창띄움
	function modifyComment(obj,bcNo,boardNo,bcRef,bcDel){
		//textarea를 화면에 표현
		if(bcDel==1){
			return false;
		}
		$(obj).parent().prev().show();
		//기존본문 내용 숨김
		$(obj).parent().prev().prev().hide();
		//수정>수정완료
		$(obj).html('수정완료');
		$(obj).attr("onclick","modifyComplete(this,'"+bcNo+"','"+boardNo+"');");
		//삭제 > 취소
		$(obj).next().html('취소');
		$(obj).next().attr("onclick","modifyCancel(this,'"+bcNo+"','"+boardNo+"','"+bcRef+"');");
		//답글달기버튼 숨기기
		$(obj).next().next().hide();
		
	}
	
	//수정취소
	function modifyCancel(obj,bcNo,boardNo,bcRef){
		//textarea숨김
		$(obj).parent().prev().hide();
		//기존 본문내용을 화면에 다시 표현
		$(obj).parent().prev().prev().show();
		//수정완료 > 수정
		$(obj).prev().html("수정");
		$(obj).prev().attr("onclick","modifyComment(this,'"+bcNo+"','"+boardNo+"');");
		//취소 >삭제
		$(obj).html("삭제");
		$(obj).attr("onclick","deleteComment(this,'"+bcNo+"','"+boardNo+"','"+bcRef+"');");
		//답글달기 버튼 화면에 표현
		$(obj).next().show();
	}
	
	//수정제출
	function modifyComplete(obj,bcNo,boardNo){ /* 자바스크립트이용 */
			var content=$(obj).parent().prev().val();
			if(content==""){
				alert("내용을 입력하세요.");
				return false;
			}
			//새로운 form생성
			var form =$("<form action='/updateComment.do?boardType=3' method='post'></form>");
			//폼안에 수정댓글번호 설정
			form.append($("<input type='text' name='bcNo' value='"+bcNo+"'>"));
			//폼안에 공지사항번호설정
			form.append($("<input type='text' name='boardNo' value='"+boardNo+"'>"));
			//수정한 댓글내용 설정 텍스트에리아 추가
			form.append($(obj).parent().prev());
			//전송할 폼태그 현재페이지(바디태그)에 추가
			$("body").append(form);
			//폼태그 전송
			form.submit();
		} 
	
	function commentChk(){
		var loginId = $("#loginId").val();
		var comment = $("#comment").val();
		if(loginId == ""){
			alert("로그인 후 이용하실 수 있습니다.");
			return false;
		}
		if(comment == ""){
			alert("내용을 입력하세요.");
			return false;
		}
	}
	
	function chkPrev(){
		var prev = $("#prev").val();
		if(prev==0){
			return false;
		}
	}
	function chkNext(){
		var next = $("#next").val();
		if(next==0){
			return false;
		}
	}
	
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>