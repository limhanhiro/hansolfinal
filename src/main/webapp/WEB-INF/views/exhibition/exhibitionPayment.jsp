<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<head>
<meta charset="UTF-8">
<title>전시 결제</title>
<link href="resources/hansolCss/hansol_default.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="container">
        <h2 style="margin-left: 166px;">전시 결제</h2>
        <div class="row" style="width: 600px; margin: 0 auto;">
            <div style="width: 600px; height: 305px;">
                <div class="thumbnail" style="margin: 0 auto; border-radius: 0px; border-bottom: none; height: 305px;">
                	<img src=${exbp.exhibitionPhoto } style="height:100%;">
                </div>
            </div>
            <table class="table table-bordered" style="width: 600px; text-align: center;">
                    <tr>
                        <td style="padding: none;">${exbp.exhibitionTitle }</td>
                    </tr>
                    <tr>
                        <td>예약 날짜 ${exbp.bookDate }</td>
                    </tr>
                    <tr>
                        <td>결제금액 : ${exbp.paymentPrice }원/총인원 : ${exbp.paymentQuantity }명</td>
                    </tr>
            </table>
            <button type="button" id="credit" class="btn" style="float: right;">결제하기</button>
            <input type="hidden" id="memberNo" value="${sessionScope.m.memberNo }">
            <input type="hidden" id="paymentSelect" value="${exbp.paymentSelect }">
            <input type="hidden" id="exhibitionNo" value="${exbp.exhibitionNo }">
            <input type="hidden" id="paymentPrice" value="${exbp.paymentPrice }">
            <input type="hidden" id="bookDate" value="${exbp.bookDate }">
            <input type="hidden" id="paymentQuantity" value="${exbp.paymentQuantity }">
        </div>
    </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
	/*function credit(){
			var bookDate = $("#bookDate").val();
			var paymentPrice = Number($("#paymentPrice").html()); 
			var paymentQuantity = Number($("#paymentQuantity").html()); 
			var exhibitionNo = Number($("#exhibitionNo").val());
			var paymentSelect = Number($("#paymentSelect").val()); // 전시결제는 1 , 강좌결제는 2
			console.log(bookDate);
			var form = $("<form action='/exhibitionPayment.do' method='post'></form>");
			form.append($("<input type='text' name='paymentQuantity' value='"+paymentQuantity+"'>"));
			form.append($("<input type='text' name='paymentPrice' value='"+paymentPrice+"'>"));
			form.append($("<input type='text' name='exhibitionNo' value='"+exhibitionNo+"'>"));
			form.append($("<input type='text' name='paymentSelect' value='"+paymentSelect+"'>"));
			form.append($("<input type='text' name='bookDate' value='"+bookDate+"'>"));
			$("body").append(form);
			form.submit();
	}*/
	$("#credit").click(function(){
		var bookDate = $("#bookDate").val();
		var memberNo = Number($("#memberNo").val());
		var paymentPrice = Number($("#paymentPrice").val()); 
		paymentPrice = 100;
		var paymentQuantity = Number($("#paymentQuantity").val()); 
		var exhibitionNo = Number($("#exhibitionNo").val());
		var paymentSelect = Number($("#paymentSelect").val()); // 전시결제는 1 , 강좌결제는 2
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
				var bookDate = $("#bookDate").val();
				var memberNo = Number($("#memberNo").val());
				var paymentPrice = Number($("#paymentPrice").val());
				var paymentQuantity = Number($("#paymentQuantity").val()); 
				var exhibitionNo = Number($("#exhibitionNo").val());
				var paymentSelect = Number($("#paymentSelect").val()); // 전시결제는 1 , 강좌결제는 2
				 $.ajax({
			            url: "/exhibitionCredit.do", //예: https://www.myservice.com/payments/complete
			            method: "POST",
			            //headers: { "Content-Type": "application/json" },
			            data: {
			                //imp_uid: rsp.imp_uid,
			                paymentNo: rsp.merchant_uid,
			                memberNo:memberNo,
			                bookDate:bookDate,
			                paymentPrice:paymentPrice,
			                paymentQuantity:paymentQuantity,
			                exhibitionNo:exhibitionNo,
			                paymentSelect:paymentSelect
			            },
			            success : function(){//비동기 요청 성공시 수행
						}
				 });
				alert("결제성공");
				location.href="/exhibitionView.do?exhibitionNo="+exhibitionNo;
			}else{
				alert("결제실패");
			}
		});
	});
</script>
</html>