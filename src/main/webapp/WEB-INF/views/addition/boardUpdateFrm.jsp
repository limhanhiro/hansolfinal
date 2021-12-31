<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정하기</title> 
<!-- include summernote css/js -->
<link rel="stylesheet" href="/resources/additionCss/boardUpdateFrm.css">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 	 <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
 	 <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
	<div class="container">
	<a id="back" class="btn" href="javascript:window.history.back();">뒤로가기</a>
	<form action="/boardUpdate.do" method="post" enctype="multipart/form-data">
				<input type="hidden" id="boardType" name="boardType" value="${boardType }">
				<table class="table" style="width:100%;">
					<tr  style="border-top: 2px solid #064663;">
						<td>제목</td>
						<c:choose>
							<c:when test="${boardType  eq 5 }">
							<td colspan="5">
							<input type="text" id="text" name="boardTitle" class="form-control" value="${b.boardTitle }">
							</td>
							</c:when>
							<c:otherwise>
							<td colspan="3">
							<input type="text" id="text" name="boardTitle" class="form-control" value="${b.boardTitle }">
							</td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<c:choose>
							<c:when test="${boardType  eq 5 }">
							<td>작성자</td>
							<td><input type="text" id="boardWriter" name="boardWriter" value="${sessionScope.m.memberId }" readonly></td>
							 <td>시작일</td>
							 <td>
     						   <input type="date"  id="startDate" name="startDate" value="${b.startDate }">
     						 </td>
     						 <td>종료일</td>
     						 <td>
     						 <input type="date"  id="endDate" name="endDate" value="${b.endDate }">
      						 </td>
							</c:when>
							<c:otherwise>
							<td>작성자</td>
							<td><input type="text" id="boardWriter" name="boardWriter" value="${sessionScope.m.memberId }" readonly></td>
							</c:otherwise>
						</c:choose>
						
					</tr>
					<tr>
					<c:choose>
				   			<c:when test="${boardType  eq 5 }">
				   				<td>썸네일</td>
				   				<td>
									<div id="imageArea" style="margin-top: 10px;">
										<img id="thumbnail" src="/resources/additionImage/${b.filepath }" style="width: 200px;">
									</div>
								</td>	
								<td colspan="5" style="text-align:left;">
								<input type="hidden" name="boardNo" value="${b.boardNo }">
								<input type="hidden" id="status" name="status" value="1">
									<c:choose>
									<c:when test="${not empty b.filename }">
										<span class="delFile">${b.filename }</span>
										<button type="button" id="delBtn" class="btn btn-primary btn-sm delFile">
										삭제
										</button>
										<input type="file" id="addFile" name="addFile" style="display:none;" accept="image/*">
										<input type="hidden" class="oldFilename" name="oldFilename" value="${b.filename }">
										<input type="hidden" class="oldFilepath" name="oldFilepath" value="${b.filepath }">

									</c:when>
									<c:otherwise>
									<input type="file" name="addFile"  style="display:none;" accept="image/*">
										
									</c:otherwise>
									</c:choose>
								</td>
				   			</c:when>
				   			<c:otherwise>
				   				<td>첨부파일</td>
								<td style="text-align:left;">
								<input type="hidden" name="boardNo" value="${b.boardNo }">
								<input type="hidden" name="status" value="1">
									<c:choose>
									<c:when test="${not empty b.filename }">
										<span class="delFile">${b.filename }</span>
										<button type="button" id="delBtn" class="btn btn-primary btn-sm delFile">
										삭제
										</button>
										<input type="file" id="addFile" name="addFile" style="display:none;">
										<input type="hidden" class="oldFilename" name="oldFilename" value="${b.filename }">
										<input type="hidden" class="oldFilepath" name="oldFilepath" value="${b.filepath }">
									</c:when>
									<c:otherwise>
									<input type="file" name="addFile">
									</c:otherwise>
									</c:choose>
								</td> 
				   			</c:otherwise>
				   		</c:choose>
					</tr>
					<c:choose>
						<c:when test="${boardType  eq 1 }">
							<tr>
								<td>고정공지</td>
								<td><input type="checkbox" id="boardFix" name="boardFix"><input type="hidden" id="fixchk" value="${b.boardFix }"></td>
							</tr>
						</c:when>
						<c:when test="${boardType  eq 2 }">
							<tr>
								<td>비밀글</td>
								<td><input type="checkbox" id="boardLevel" name="boardLevel"><input type="hidden" id="levelchk" value="${b.boardLevel }">비밀글</td>
							</tr>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${boardType  eq 5 }">
							<tr>
							<td>내용</td>
							<td id="img" colspan="5">
								<img id="img-view" width="500px">
								<textarea id="summernote" name="boardContent" class="form-control">${b.boardContent }</textarea>
							</td>
							</tr>
							<tr>
								<td colspan="7">
									<button id="updatebtn" type="submit" class="btn btn-block" onclick="return contentChk();">글수정</button>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
							<td>내용</td>
							<td id="img" colspan="3">
								<img id="img-view" width="500px">
								<textarea id="summernote" name="boardContent" class="form-control">${b.boardContent }</textarea>
							</td>
							</tr>
							<tr>
								<td colspan="4">
									<button id="updatebtn" type="submit" class="btn btn-block" onclick="return contentChk();">글수정</button>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
						
					
				</table>
		</form>
	</div>
	<script type="text/javascript">
	$(document).ready(function() {
		var fixchk = $("#fixchk").val();
		if(fixchk==1){
			$("#boardFix").prop('checked',true);
		}
		var levelchk = $("#levelchk").val();
		if(levelchk==1){
			$("#boardLevel").prop('checked',true);
		}
	
    });

	
	
	$(document).on("click",".delFile",function(){
		$('#imageArea').css({ 'display' : 'none' });
		$(".delFile").hide();
		$(this).next().show();
		$("[name=status]").val(2);
    });
	$(function() {
		$("#summernote").summernote({
			height:400,
			lang : "ko-KR",
			callbacks:{
				onImageUpload : function(files) {
					 for (i=0;i<files.length;i++) {
				            uploadSummernoteImageFile(files[i],
				            this);
					 }
				}
			}
		});
	});
	function uploadSummernoteImageFile(file, editor) {
		var form = new FormData();
		form.append("file", file);
		$.ajax({
			url : "/uploadSummernoteImageFile.do",
			type : "post",
			data : form,
			processData : false,
			contentType : false,
			success : function(data){
				//결과로 받은 업로드 경로를 이용해서 에디터에 이미지 추가
				$(editor).summernote("insertImage",data);
			}
		});
	}
	
	function contentChk(){
		if($("#boardFix").is(":checked")){
			$("#boardFix").val(1);
		}else{
			$("#boardFix").val(0);
		}
		if($("#boardLevel").is(":checked")){
			$("#boardLevel").val(1);
		}else{
			$("#boardLevel").val(0);
		}
		var text = $("#text").val();
		var login = $("#boardWriter").val();
		if(login== ""){
			alert("로그인이 필요합니다.");
			return false;
		}
		if(text == "" ){
			alert("제목을 입력하세요.");
			return false;
		}
		if ($('#summernote').summernote('isEmpty')) {
			  alert('글내용을 입력하세요');
			  return false;
			}
		var startdate = $("#startDate").val();
		var enddate = $("#endDate").val();
		if(startdate=="" ||enddate==""){
			alert("날짜를 입력해주세요.");
			return false;
		}
		if(startdate>enddate){
			alert("날짜를 확인해주세요.");
			return false;
		}
		var boardType = $("#boardType").val();
		var status = $("#status").val();
		if(boardType==5 && status==2){
			if( $("#addFile").val() == '' ){
				alert("썸네일을 설정해주세요.");
				return false;
			}
		}
	}
$(function() {
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1;
	var yyyy = today.getFullYear();
	if(dd<10){
	  dd='0'+dd
	} 
	if(mm<10){
	  mm='0'+mm
	} 
	today = yyyy+'-'+mm+'-'+dd;
	$("#startDate").attr("min", today);
	$("#endDate").attr("min", today);
    
	});
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#thumbnail').attr('src', e.target.result); 
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	$(":input[name='addFile']").change(function() {
		if( $(":input[name='addFile']").val() == '' ) {
			$('#thumbnail').attr('src' , '');  
		}
		$('#imageArea').css({ 'display' : '' });
		readURL(this);
	});
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>