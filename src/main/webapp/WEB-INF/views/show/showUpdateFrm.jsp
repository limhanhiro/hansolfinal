<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공연 등록</title>
<link href="resources/showCss/show_insert.css" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<div class="container">
        
        <form action="/updateShow.do" method="post" enctype="multipart/form-data">
        	<input type="hidden" name="showNo" value="${s.showNo }">
            <table>
                <tr>
                    <th>공연 이름</th>
                    <td colspan="3">
                        <input type="text" class="form-control" name="showName" value="${s.showName }">
                    </td>
                </tr>
                <tr>
                    <th>공연 장소</th>
                    <td colspan="3">
                        <input type="text" class="form-control" name="showHall" value="${s.showHall }">
                    </td>
                </tr>
                <tr>
                    <th>공연 시작일</th>
                    <td>
                        <input type="date" class="form-control" name="showStart" value="${s.showStart }">
                    </td>
                    <th>공연 종료일</th>
                    <td>
                        <input type="date" class="form-control" name="showEnd" value="${s.showEnd }">
                    </td>
                </tr>
                <tr>
                    <th>공연 포스터</th>
                    <td>
                        <input type="hidden" name="status" value="1">
						<c:choose>
							<c:when test="${s.filepath != null }">
								<img src="/resources/showImage/file.png" width="16px" class="delFile">
								<span class="delFile">${s.filepath }</span>
								<button type="button" id="delBtn" class="btn btn-primary btn-sm delFile">삭제</button>
								<input type="file" name="upfile" style="display: none;">
								<input type="hidden" name="oldFilepath" value="${s.filepath }">
							</c:when>
							<c:otherwise>
								<input type="file" name="upfile">							
							</c:otherwise>
						</c:choose>
                    </td>
                </tr>
                <tr>
                    <th>공연 시간</th>
                    <td><input type="text" class="form-control" name="showTime" value="${s.showTime }"></td>
                    <th>관람가능 연령</th>
                    <td>
                        <select name="showAge" class="form-control">
                        	<c:if test="${s.showAge == 0 }">
	                            <option value="0" selected>전체관람가</option>
	                            <option value="7">7세 이상</option>
	                            <option value="12">12세 이상</option>
	                            <option value="15">15세 이상</option>
	                            <option value="19">19세 이상</option>                        	
                        	</c:if>
                        	<c:if test="${s.showAge == 7 }">
	                            <option value="0">전체관람가</option>
	                            <option value="7" selected>7세 이상</option>
	                            <option value="12">12세 이상</option>
	                            <option value="15">15세 이상</option>
	                            <option value="19">19세 이상</option>                        	
                        	</c:if>
                        	<c:if test="${s.showAge == 12 }">
	                            <option value="0">전체관람가</option>
	                            <option value="7">7세 이상</option>
	                            <option value="12" selected>12세 이상</option>
	                            <option value="15">15세 이상</option>
	                            <option value="19">19세 이상</option>                        	
                        	</c:if>
                        	<c:if test="${s.showAge == 15 }">
	                            <option value="0">전체관람가</option>
	                            <option value="7">7세 이상</option>
	                            <option value="12">12세 이상</option>
	                            <option value="15" selected>15세 이상</option>
	                            <option value="19">19세 이상</option>                        	
                        	</c:if>
                        	<c:if test="${s.showAge == 19 }">
	                            <option value="0">전체관람가</option>
	                            <option value="7">7세 이상</option>
	                            <option value="12">12세 이상</option>
	                            <option value="15">15세 이상</option>
	                            <option value="19" selected>19세 이상</option>                        	
                        	</c:if>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>좌석가격</th>
                    <td colspan="3">
                        <input type="text" class="form-control" name="showPrice" value="${s.showPrice }">
                    </td>
                </tr>
                <tr>
                    <th>공연 정보</th>
                    <td colspan="3">
                    	<textarea id="summernote" class="form-control" name="showContent">${s.showContent }</textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <input type="submit" class="btn btn-default" value="등록">
                    </td>
                </tr>
            </table>
        </form>
	</div>
    <script>
    $("#delBtn").click(function() {
		$(".delFile").hide();
		$(this).next().show();
		$("[name=status]").val(2);
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
			url : "/uploadImage.do",
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
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>