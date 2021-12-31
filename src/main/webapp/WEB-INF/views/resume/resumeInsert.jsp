<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원 하기</title>
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<div class="container">
		<h2>강사 지원하기</h2>
    <form action="/resumeInsert.do" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <h3><span class="line">지</span>원하시는 공고</h3>
        <input type="hidden" name="requritNo" value="${requritNo }">
        <input type="hidden" name="memberNo" value="${sessionScope.m.memberNo }">
        <input type="text" class="form-control" id="resumeTitle" value="${requritTitle }" readonly>
      </div>
      <div class="form-group">
        <h3><span class="line">성</span>별</h3>
        <select class="form-control" id="resumeGender" name="resumeGender" required>
          <option value="남자">남자</option>
          <option value="여자">여자</option>
        </select>
      </div>
      <div class="form-group">
          <h3><span class="line">연</span>락받으실 연락처</h3>
          <input type="text" class="form-control" id="resumePhone"  name="resumePhone" required>
      </div>
      <div class="form-group">
        <h3><span class="line">이</span>력서 첨부</h3>
         <label><input type="file" name="upfiles" required>이력서 첨부</label>
         <label><input type="file" name="upfiles" required>경력기술서 첨부</label>
      </div>
      <div class="form-group">
        <h3><span class="line">간</span>단 자기소개</h3>
        <textarea id="summernote" class="form-control" name="resumeDetail" required></textarea>
      </div>
       <button type="submit" class="btn" style="float:right">등록하기</button>
    </form>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
$('#summernote').summernote({
	  height: 300,                 // set editor height
	  minHeight: null,             // set minimum height of editor
	  maxHeight: null,             // set maximum height of editor
	  focus: true,                  // set focus to editable area after initializing summernote
	  lang : "ko-KR",
	  callbacks:{
			onImageUpload : function(files) {
				uploadImage(files[0],this);
			}
		}
	});
	$(document).ready(function() {
		  $('#summernote').summernote();
		});
function uploadImage(file,editor) {
	//form과 같은 효과를 내는 객체
	var form = new FormData();
	form.append("file",file);
	$.ajax({
		url : "/uploadImageResume.do",
		type : "post",
		data : form,
		processData : false,
		contentType : false,
		success : function(data) {
			//결과로 받은 업로드 경로를 이용해서 에디터에 이미지 추가
			$(editor).summernote("insertImage",data, function($image) {
				$image.css("width", "100%");
			});
		}
	});
}
</script>
</html>