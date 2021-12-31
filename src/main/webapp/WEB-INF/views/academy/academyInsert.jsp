<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아카데미 등록</title>
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
  		 <h2>수업 등록하기</h2>
    <form action="/academyInsert.do" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <h3><span class="line">수</span>업명</h3>
        <input type="text" class="form-control" id="academyTitle" placeholder="수업명을 입력해주세요" name="academyTitle" required>
      </div>
       <div class="form-group">
        <h3><span class="line">수</span>업 대표사진</h3>
        <input type="file"  id="academyfile"  name="upfile" accept="image/*" required>
        <div id="imageArea" style="margin-top: 10px; display: none">
        	<img id="thumbnail" style="width: 200px;">
        </div>
      </div>
      <h3><span class="line">수</span>업 기간</h3>
      <div class="form-group col-sm-6">
        <h4>시작일</h4>
        <input type="text" class="form-control" id="datepicker" name="academyStart" required>
      </div>
      <div class="form-group col-sm-6">
        <h4>종료일</h4>
        <input type="text" class="form-control" id="datepicker2" name="academyEnd" required>
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
          <input type="text" class="form-control" id="academyTeacher" placeholder="담당 강사이름을 입력해주세요" name="academyTeacher" required><span id="teacherChk"></span>
        </div>
      <div class="form-group">
        <h3><span class="line">수</span>업료</h3>
        <input type="text" class="form-control" id="academyPrice" placeholder="수업료를 입력해주세요" name="academyPrice" required>
      </div>
      <div class="form-group">
        <h3><span class="line">상</span>세 설명</h3>
         <textarea id="summernote" class="form-control" name="academyDetail" required></textarea>
      </div>
       <button type="submit" id ="checkT" class="btn" style="float:right" flag="0">등록하기</button>
    </form>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
$("#checkT").click(function(){
	if ($('#checkT').attr("flag") == "0"){
	    alert("선생님 회원 확인해 주시기 바랍니다.");
	    $('#academyTeacher').focus();
	    return false;
	 }
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
$("[name=academyTeacher]").keyup(function(){
	var academyTeacher = $(this).val();
	$.ajax({
		url : "/teacherCheck.do",
		data : {academyTeacher:academyTeacher},
		success:function(data){
			if(data==2){
				$("#teacherChk").html("승인된 선생님 입니다");
				$("#teacherChk").css("color","blue");
				$("#checkT").attr("flag","1");
			}else{
				$("#teacherChk").html("선생님 회원이 아닙니다");
				$("#teacherChk").css("color","red");
				$("#checkT").attr("flag","0");
			}
		}
	})
});
</script>
</html>