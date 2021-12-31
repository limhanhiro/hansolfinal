<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title> 
<!-- include summernote css/js -->
<link rel="stylesheet" href="/resources/additionCss/boardWriteFrm.css">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
  <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
	<div class="container">
	<a id="back" class="btn" href="javascript:window.history.back();">뒤로가기</a>
	<form action="/boardWrite.do" method="post" enctype="multipart/form-data">
				<table class="table" style="width:100%;">
					<tr style="border-top: 2px solid #064663;">
						<td>제목</td>
						<td colspan="9">
							<input type="text" id="text" name="boardTitle" class="form-control">
							<input type="hidden" id="boardType" name="boardType" value="${boardType }">
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td ><input type="text" id="boardWriter" name="boardWriter" value="${sessionScope.m.memberId }" readonly></td>
						<c:choose>
							<c:when test="${boardType eq 2}">
							<td>
							<input type="checkbox" id="boardLevel" name="boardLevel">비밀글
							<input type="hidden" id="boardFix" name="boardFix" value="0">
							<td>
							</c:when>
							<c:when test="${boardType eq 1}">
							<td>
							<input type="checkbox" id="boardFix" name="boardFix">고정공지
							<input type="hidden" id="boardLevel" name="boardLevel" value="0">
							<td>
							</c:when>
							<c:otherwise>
							<td>
							<input type="hidden" id="boardFix" name="boardFix" value="0">
							<input type="hidden" id="boardLevel" name="boardLevel" value="0">
							<td>
							</c:otherwise>
						</c:choose>
						<c:if test="${boardType eq 5 }">
						 	<td>시작일</td>
							 <td>
     						  <input type="date"  id="startDate" name="startDate">
     						 </td>
     						 <td>종료일</td>
     						 <td>
     							 <input type="date"  id="endDate" name="endDate">
      						 </td>
						</c:if>
						<c:if test="${boardType != 5 }">
							<td>첨부파일</td>
									<td style="text-align:left;">
									<input type="file" name="addFile">
							</td> 
						</c:if>
						</tr>
						<c:if test="${boardType eq 5 }">
						<tr>
							<td>썸네일</td>
							<td colspan="4">
							<div id="imageArea" style="margin-top: 10px; display: none">
								<img id="thumbnail" style="width: 200px;">
							</div>
							</td> 
							<td colspan="5" style="text-align:left;">
								<input type="file" id="addFile" name="addFile" accept="image/*">
							</td>
							
						</tr>	
						</c:if>
					<tr>
						<td>내용</td>
						<td id="img" colspan="9">
							<img id="img-view" width="500px">
							<textarea id="summernote" name="boardContent" class="form-control"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="10">
							<button type="submit" id="btnColor" class="btn btn-block btnColor" onclick="return contentChk();">글등록</button>
						</td>
					</tr>
				</table>
		</form>
	</div>
	<script type="text/javascript">
	/*  function loadImg(obj){
		var files = obj.files; //input type=file 에서 선택한 파일을 배열로 가져옴 files속성은 무조건 배열
		console.log(files);
		if(files.length != 0){ //첨부파일 있는경우
			for(i=0;i<files.length;i++){
			var reader =new FileReader();//파일에 대한 정보를 읽어오는 객체
			reader.readAsDataURL(files[i]); //파일 경로를 읽어옴
			//경로를 다 읽어오면 실행할 함수 설정
			reader.onload = function(e) {
				var img = $('<img>', { 
                    'src' : e.target.result,
                     'width' : '500px'}); 			
				$("#img").prepend(img);
				$("#img").prepend('<br>');
			}
			}
		}else{  //첨부파일 없는경우
			$("#img-view").attr("src","");
		}
	} */
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
		if($("#boardLevel").is(":checked")){
			$("#boardLevel").val(1);
		}else{
			$("#boardLevel").val(0);
		}
		if($("#boardFix").is(":checked")){
			$("#boardFix").val(1);
		}else{
			$("#boardFix").val(0);
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
			  alert('글내용을 입력하세요.');
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
		console.log(boardType);
		if(boardType==5 ){
			if( $("#addFile").val() == ''){
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