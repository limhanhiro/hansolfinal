<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공고 목록</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
<link href="resources/hansolCss/hansol_requritList.css" rel="stylesheet">
</head>
<style>
.swal-modal{
background-color: rgb(245, 248, 250);
}
.swal-footer {
  margin-top: 32px;
  overflow: hidden;
}
.swal-title {
  font-size: 35px;
  box-shadow: 0px 1px 1px #064663;
  color : #064663;
  height: 60px;
}
.swal-text{
	font-size: 20px;
	color : #064663;
}
.swal-button{
	background-color: #064663;
}
.swal-button:hover{
	background-color: #ffffff;
	color: #064663;
}
</style>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 <div class="container">
        <h2 style="margin-top: 100px; margin-bottom: 50px;"><span class="line">강사</span>모집 공고</h2>
        
        <table id="tableee" class="table table-hover" >
              <tr id="firstTr">
                  <th>#번호</th>
                  <th>공고명</th>
                  <th>올린사람</th>
                  <th>모집 기간</th>
              </tr>
          	<c:forEach items="${list }" var="r" varStatus="i">
          	<c:if test="${r.requritCancel eq 0 }">
             	<tr id ="secTr">
				   <td>${start + i.index }</td>
				  <c:choose>
				   <c:when test="${r.period ge 0  }">
				   <td><a href="/requritView.do?requritNo=${r.requritNo }" style="text-decoration: none;">${r.requritTitle }</a></td>
				   </c:when>
				   <c:when test="${r.period le -1 }">
				   <td><a onclick ="endRequrit();" style="text-decoration: none; cursor: pointer;">마감된 공고입니다</a></td>
				   </c:when>
				   </c:choose>
				   <td>관리자</td>
				   <c:choose>
				   <c:when test="${r.period ge 1 }">
				   <td>${r.requritStart }~${r.requritEnd }</td>
				   </c:when>
				   <c:when test="${r.period le -1 }">
				   <td>마감된 공고</td>
				   </c:when>
				   <c:when test="${r.period eq 0 }">
				   <td>오늘 마감!</td>
				   </c:when>
				   </c:choose>
			   </tr>
			  </c:if>
			 </c:forEach>
          </table>
          <div id="pageNavi">${pageNavi }</div>
        <div class="btnArea" style="float: right; margin-right: 50px;">
        <c:choose>
        <c:when test="${not empty sessionScope }">
        <c:if test="${sessionScope.m.memberLevel eq 0}">
        	<button class="btn" id ="deleteRequritList">삭제된 공고 보기</button>
        	<button class="btn" id ="insertRequrit">공고 등록하기</button>
        </c:if>
        <c:if test="${sessionScope.m.memberLevel > 0 }">
        	<button class="btn" id="myRequritList" memberNo="${sessionScope.m.memberNo }">내가 지원한 공고 보기</button>
        </c:if>
        </c:when>
 		</c:choose>
       </div>
        </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script>
	
		function endRequrit() {
			swal({
				  title: "Musée d'art",
				  text: "마감된 공고 입니다",
				  button : '확인'
				});
				
		}
	
		$("#deleteRequritList").click(function(){
			location.href ="/deleteRequritList.do?reqPage=1";
		});
		$("#myRequritList").click(function(){
			var memberNo = $(this).attr("memberNo");
			location.href ="/myResumeList.do?memberNo="+memberNo;
		});
		$("#insertRequrit").click(function(){
			location.href ="/requritFrm.do";
		});
	</script>
</body>
</html>