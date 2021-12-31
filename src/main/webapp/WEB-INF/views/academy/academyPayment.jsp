<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<head>
<meta charset="UTF-8">
<title>아카데미 결제</title>
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		 <div class="container">
        <div class="row" style="width: 600px;margin: 0 auto; margin-top: 130px;" >
            <div style="width: 600px; height:305px; ">
                <div class="thumbnail" style="margin: 0 auto; border-radius: 0px; border-bottom: none; height: 100%">
                	<img src=${acp.academyPhoto } style="height: 100%;">
                </div>
            </div>
            <table class="table table-bordered" style="width: 600px; text-align: center;">
                <tbody>
                    <tr>
                        <td style="padding: none;">${acp.academyTitle }</td>
                    </tr>
                    <tr>
                        <td>수업 날짜 : ${acp.academyStart } ~ ${acp.academyEnd }</td>
                    </tr>
                    <tr>
                        <td>결제금액 : ${acp.paymentPrice } 원</td>
                    </tr>
                </tbody>
            </table>
            <button type="button" id="credit" class="btn" style="float: right;">결제하기</button>
            <input type="hidden" id="memberNo" value="${sessionScope.m.memberNo }">
            <input type="hidden" id="paymentSelect" value="${acp.paymentSelect }">
            <input type="hidden" id="academyNo" value="${acp.academyNo }">
            <input type="hidden" id="paymentPrice" value="${acp.paymentPrice }">
            <input type="hidden" id="academyEnd" value="${acp.academyEnd }">
        </div>
    </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
	$("#credit").click(function(){
		var paymentPrice = Number($("#paymentPrice").val()); 
		paymentPrice = 100;
		var academyNo = Number($("#academyNo").val());
		var memberNo = Number($("#memberNo").val());
		var paymentSelect = Number($("#paymentSelect").val()); // 전시결제는 1 , 강좌결제는 2
		var academyEnd = $("#academyEnd").val();
		var d = new Date(); // Date 객체 생성
		var date = d.getDate()+""+d.getHours()+""+d.getMinutes()+""+d.getSeconds(); 
		//Date 객체로 고유식별 번호 생성
		IMP.init("imp28965926"); //결제 API 사용을 위한 가맹점 식별코드 입력
		IMP.request_pay({
			merchant_uid : date,    // 거래 아이디
			name : "무지다",     //결제이름설정
			amount : paymentPrice,
			buyer_email : "limhanhiro@gmail.com", // 구매자 이메일
			buyer_name : "hiro",   			//구매자 이름
			buyer_phone : "010-8827-2821",	//구매자 전화번호
		
		},function(rsp){ // rsp 는 결재 결과
			if(rsp.success){
				var paymentPrice = Number($("#paymentPrice").val());
				var academyNo = Number($("#academyNo").val());
				var memberNo = Number($("#memberNo").val());
				var paymentSelect = Number($("#paymentSelect").val()); // 전시결제는 1 , 강좌결제는 2
				var academyEnd = $("#academyEnd").val();
				var paymentQuantity = 1;
				 $.ajax({
		          	  url: "/academyCredit.do", //예: https://www.myservice.com/payments/complete
		          	  method: "POST",
		          	  //headers: { "Content-Type": "application/json" },
		           	 data: {
		              	  //imp_uid: rsp.imp_uid,
		             	   paymentNo: rsp.merchant_uid,
		             	   memberNo:memberNo,
		             	   paymentPrice:paymentPrice,
		             	   paymentQuantity:paymentQuantity,
		             	   academyNo:academyNo,
		             	   paymentSelect:paymentSelect,
		             	   academyEnd:academyEnd
		        	},
		            success : function(){//비동기 요청 성공시 수행
					}
			 });
			alert("결제성공");
			location.href="/academyView.do?academyNo="+academyNo;
		}else{
			alert("결제실패");
		}
	});
});
</script>
</html>