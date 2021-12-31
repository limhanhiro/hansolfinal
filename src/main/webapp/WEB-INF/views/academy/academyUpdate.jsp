<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아카데미 수정</title>
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
  		 <h2>수업 수정하기</h2>
    <form action="/academyUpdate.do" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <h3><span class="line">수</span>업명</h3>
        <input type="hidden" name="academyNo" value="${a.academyNo }">
        <input type="text" class="form-control" id="academyTitle" name="academyTitle" value="${a.academyTitle }" required>
      </div>
       <div class="form-group">
        <h3><span class="line">수</span>업 대표사진</h3>
        <input type="file"  id="academyfile"  name="upfile" accept="image/*">
        <input type="hidden" name="academyPhoto" value="${a.academyPhoto }">
        <div id="imageArea" style="margin-top: 10px;">
        	<img id="thumbnail" src="${a.academyPhoto }" style="width: 200px;">
        </div>
      </div>
      <h3><span class="line">수</span>업 기간</h3>
      <div class="form-group col-sm-6">
        <h4>시작일</h4>
        <input type="text" class="form-control" id="datepicker" name="academyStart" value="${a.academyStart }" required>
      </div>
      <div class="form-group col-sm-6">
        <h4>종료일</h4>
        <input type="text" class="form-control" id="datepicker2" name="academyEnd" value="${a.academyEnd }" required>
      </div>
      <div class="form-group">
        <h3><span class="line">카</span>테고리</h3>
        <select class="form-control" id="category" name="academyCategory" required>
          <option value="음악">음악</option>
          <option value="미술">미술</option>
          <option value="무용">무용</option>
          <option value="독서">독서</option>
          <option value="육아">육아</option>
        </select>
      </div>
      <div class="form-group">
        <h3><span class="line">장</span>소</h3>
        <select class="form-control" id="place" name="academyPlace" required>
          <option value="무지다교육관101호">무지다교육관101호</option>
          <option value="무지다교육관102호">무지다교육관102호</option>
          <option value="무지다교육관201호">무지다교육관201호</option>
          <option value="무지다교육관202호">무지다교육관202호</option>
        </select>
      </div>
         <div class="form-group">
          <h3><span class="line">담</span>당 강사</h3>
          <input type="text" class="form-control" id="academyTeacher"  name="academyTeacher" value="${a.academyTeacher }" readonly>
        </div>
      <div class="form-group">
        <h3><span class="line">수</span>업료</h3>
        <input type="text" class="form-control" id="academyPrice" name="academyPrice" value="${a.academyPrice }" readonly>
      </div>
      <div class="form-group">
        <h3><span class="line">상</span>세 설명</h3>
         <textarea id="summernote" class="form-control" name="academyDetail">${a.academyDetail }</textarea>
      </div>
      <button type="submit" class="btn" style="float:right">등록하기</button>
    </form>
    <input type="hidden" id="selectCategory" value="${a.academyCategory }">
    <input type="hidden" id="selectPlace" value="${a.academyPlace }">
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
$(document).ready(function(){
	var category = $("#selectCategory").val();
	var place = $("#selectPlace").val();
	$("#category").val(category).prop("selected",true);
	$("#place").val(place).prop("selected",true);
});
/*function setThumbnail(event) { 
	var reader = new FileReader(); 
	reader.onload = function(event) {
		console.log(event.target.result);
		$("#thumbnail").attr("src",event.target.result);
		var img = document.createElement("img"); 
		img.setAttribute("src", event.target.result);
		img.setAttribute("css", event.target.result);
		document.querySelector("div#image_container").appendChild(img);
		}; 
		reader.readAsDataURL(event.target.files[0]); 
	}
*/
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
	$('#thumbnail').attr('src' , '');  
	$('#thumbnail').css({ 'display' : '' });
	readURL(this);
});
$('#summernote').summernote({
	  height: 300,                 // set editor height
	  minHeight: null,             // set minimum height of editor
	  maxHeight: null,             // set maximum height of editor
	  focus: true,                  // set focus to editable area after initializing summernote
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
		url : "/uploadImageAcademy.do",
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