<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
</head>
<body>
	<script>
	swal({
		  title: "Musée d'art",
		  text: "${msg}",
		  button : '확인'
		})
		.then((value) => {
			location.href="${loc}";
		});
	
	</script>
</body>
</html>