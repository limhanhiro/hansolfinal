<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공고 등록</title>
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script><!-- 달력 선언 -->
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<div class="container">
    <h2>공고 등록하기</h2>
    <form action="/requritInsert.do" method="post">
      <div class="form-group">
        <h3><span class="line">공</span>고명</h3>
        <input type="text" class="form-control" id="requritTitle" placeholder="공고명을 입력해주세요" name="requritTitle" required>
      </div>
      <h3><span class="line">공</span>고 기간</h3>
      <div class="form-group col-sm-6">
        <h4>시작일</h4>
        <input type="text" class="form-control" id="datepicker" name="requritStart" required>
      </div>
      <div class="form-group col-sm-6">
        <h4>종료일</h4>
        <input type="text" class="form-control" id="datepicker2" name="requritEnd" required>
      </div>
      <div class="form-group">
        <h3><span class="line">경</span>력 사항</h3>
        <input type="text" class="form-control" id="resumecareer" placeholder="경력사항을 입력해주세요" name="requritCareer" required>
      </div>
       <div class="form-group">
        <h3><span class="line">성</span>별</h3>
        <select class="form-control" id="requritGender" name="requritGender" required>
         <option value="성별무관">성별무관</option>
          <option value="남자">남자</option>
          <option value="여자">여자</option>
        </select>
      </div>
         <div class="form-group">
          <h3>직종</h3>
          <input type="text" class="form-control" id="requritField" placeholder="직종을 입력해주세요" name="requritField" required>
        </div>
     <div class="form-group">
        <h3><span class="line">고</span>용 형태</h3>
        <select class="form-control" id="employeeType" name="employeeType" required>
          <option value="정규직">정규직</option>
          <option value="계약직">계약직</option>
        </select>
      </div>
      <div>
        <h3><span class="line">상</span>세 설명</h3>
       <textarea id="summernote" class="form-control" name="requritDetail" required></textarea>
      </div><br>
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
	  focus: true ,                 // set focus to editable area after initializing summernote
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
		url : "/uploadImageRequrit.do",
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
$(function() {
	
    var date = new Date();
    $( "#datepicker" ).datepicker({
        dateFormat: "yy-mm-dd",
        monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
        monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
        dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
        dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
        dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
        yearSuffix : '년',
        minDate: date
    });
    $( "#datepicker2" ).datepicker({
        dateFormat: "yy-mm-dd",
        monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
        monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
        dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
        dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
        dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
        yearSuffix : '년',
        minDate: date
    });
    
});	
</script>
</html>