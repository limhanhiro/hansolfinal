<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전시 수정</title>
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
		  <h2>전시 등록하기</h2>
  <form action="/exhibitionUpdate.do" method="post" enctype="multipart/form-data">
    <div class="form-group">
      <h3><span class="line">전</span>시제목</h3>
      <input type="hidden" name="exhibitionNo" value="${ex.exhibitionNo }">
      <input type="text" class="form-control" id="exhibitionTitle" value="${ex.exhibitionTitle }" name="exhibitionTitle" required>
    </div>
     <div class="form-group">
        <h3><span class="line">전</span>시 대표사진</h3>
        <input type="file"  id="exhibitionPhoto"  name="upfile" accept="image/*">
        <input type="hidden" name="exhibitionPhoto" value="${ex.exhibitionPhoto }">
        <div id="imageArea" style="margin-top: 10px;">
        	<img id="thumbnail" src="${ex.exhibitionPhoto }" style="width: 200px;">
        </div>

      </div>
    <h3><span class="line">전</span>시 기간</h3>
    <div class="form-group col-sm-6">
      <h4>시작일</h4>
      <input type="text" class="form-control" id="datepicker" name="exhibitionStart" value="${ex.exhibitionStart }" required>
    </div>
    <div class="form-group col-sm-6">
      <h4>종료일</h4>
      <input type="text" class="form-control" id="datepicker2" name="exhibitionEnd" value="${ex.exhibitionEnd }" required>
    </div>
    <div class="form-group">
        <h3><span class="line">관</span>람 연령</h3>
        <select class="form-control" id="exhibitionAge" name="exhibitionAge" required>
          <option value="전체관람">전체관람</option>
          <option value="12세 이상">12세 이상</option>
          <option value="15세 이상">15세 이상</option>
          <option value="19세 이상">19세 이상</option>
        </select>
      </div>
       <h3><span class="line">전</span>시 시간</h3>
    <div class="form-group col-sm-6">
      <h4>시작시간</h4>
      <select class="form-control" id="exhibitionTimeStart" name="exhibitionTimeStart" required>
      	  <option value="08:00">08:00</option>
          <option value="09:00">09:00</option>
          <option value="10:00">10:00</option>
        </select>
    </div>
    <div class="form-group col-sm-6">
      <h4>종료시간</h4>
      <select class="form-control" id="exhibitionTimeEnd" name="exhibitionTimeEnd" required>
          <option value="16:00">16:00</option>
          <option value="17:00">17:00</option>
          <option value="18:00">18:00</option>
        </select>
    </div>
    <div class="form-group">
      <h3><span class="line">가</span>격</h3>
      <input type="text" class="form-control" id="exhibitionPrice" name="exhibitionPrice" value="${ex.exhibitionPrice }" readonly>
    </div>
    <div class="form-group">
      <h3><span class="line">상</span>세설명</h3>
     <textarea id="summernote" class="form-control" name="exhibitionDetail" required>
     ${ex.exhibitionDetail }
     </textarea>
    </div>
        <button type="submit" class="btn" style="float:right">등록하기</button>
  </form>
</div>
<input type="hidden" id="selectStartTime" value="${ex.exhibitionTimeStart }">
<input type="hidden" id="selectEndTime" value="${ex.exhibitionTimeEnd }">
<input type="hidden" id="selectAge" value="${ex.exhibitionAge }">
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
$(document).ready(function(){
	var startTime = $("#selectStartTime").val();
	var endTime = $("#selectEndTime").val();
	var age = $("#selectAge").val();
	$("#exhibitionTimeStart").val(startTime).prop("selected",true);
	$("#exhibitionTimeEnd").val(endTime).prop("selected",true);
	$("#exhibitionAge").val(age).prop("selected",true);
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

$(":input[name='upfile']").change(function() {
	if( $(":input[name='upfile']").val() == '' ) {
		$('#thumbnail').attr('src' , '');  
	}
	$('#imageArea').css({ 'display' : '' });
	readURL(this);
});
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
		url : "/uploadImageExhibition.do",
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