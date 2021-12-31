<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<footer id="footer" style="min-width: 1570px;">
		<div class="footer-container">
			<div class="footer-menu" style="padding-top:30px">
				  <div class="rolling_box">
			        <ul id ="rolling_box">
			          <li class="card_sliding" id ="first"><a></a></li>
			          <li class="" id ="second"><a></a></li>
			          <li class="" id ="third"><a></a></li>
			        </ul>
			      </div>
			</div>
        <div class="f-container">
          <div class="f-con">
            <h4>ABOUT</h4>
            <p>Visitor rules</p>
          </div>
          <div class="f-con">
            <h4>CONTACT</h4>
            <p>FAQ<br>
              Contact us<br>
              Give us your feedback!<br>
              Jobs (in French)<br>
              Private event and film shoots</p>
          </div>
          <div class="f-con">
            <h4>OUR WEBSITES</h4><hr>
            <p>
		            주식회사 musée d'art 대표이사: 김주연 외5인<br>
		            강원도 춘천시 서면 박사로 854 (지번 : 서면 현암리 367-3)무지다<br>
		            사업자등록번호: 211-87-21455 <br>
		            사업자등록확인통신판매업 신고: KH-3<br>
		            개인정보관리책임: 회원운영관리담당 이지원<br>
             musée d'art 대표전화: 02-549-2233<br>
            </p>
          </div>
<!--           <img src="/resources/mainImage/upload/goldlogo.png" style="max-width: 400px; margin-left:600px"> -->
        </div>
      </div>
      <script>
		$(function(){
			$.ajax({
				url : "/noticeBoard.do",
				type : "post",
				success:function(data){
					/*
					let rollingData = [
                        '1. 공지사항 주절주절 이런것도있어요.',
                        '2. 모집공고 많은 선생님 지원바랍니다.',
                        '3. 이렇게 내용이 길면 주절주절 ...',
                        '4. ...으로 표현 어떻게 해야하지 ...'
                      ]    // 롤링할 데이터를 넣으면 됩니다 갯수 제한 없어요
*/
					let rollingData = new Array();
					let hrefData =  new Array();
					for(var i=0;i<data.length;i++){
						rollingData.push(data[i].boardTitle);
						hrefData.push(data[i].boardNo);
					}
					
				    let timer = 3500 // 롤링되는 주기 입니다 (1000 => 1초)
				
				    let first = document.getElementById('first'),
				        second = document.getElementById('second'),
				        third = document.getElementById('third')
				    let move = 2
				    let dataCnt = 1
				    let listCnt = 1
				
				    //위 선언은 따로 완전히 수정하지 않는 한 조정할 필요는 없습니다.
				
				    first.children[0].innerHTML = rollingData[0]
				    first.children[0].setAttribute("href", "boardView.do?boardType=1&boardNo="+hrefData[0]);
				    setInterval(() => {
				        if(move == 2){
				            first.classList.remove('card_sliding')
				            first.classList.add('card_sliding_after')
				
				            second.classList.remove('card_sliding_after')
				            second.classList.add('card_sliding')
				
				            third.classList.remove('card_sliding_after')
				            third.classList.remove('card_sliding')
				
				            move = 0
				        } else if (move == 1){
				            first.classList.remove('card_sliding_after')
				            first.classList.add('card_sliding')
				
				            second.classList.remove('card_sliding_after')
				            second.classList.remove('card_sliding')
				
				            third.classList.remove('card_sliding')
				            third.classList.add('card_sliding_after')
				
				            move = 2
				        } else if (move == 0) {
				            first.classList.remove('card_sliding_after')
				            first.classList.remove('card_sliding')
				
				            second.classList.remove('card_sliding')
				            second.classList.add('card_sliding_after')
				
				            third.classList.remove('card_sliding_after')
				            third.classList.add('card_sliding')
				
				            move = 1
				        }
				        
				        if(dataCnt < (rollingData.length - 1)) {
				            document.getElementById('rolling_box').children[listCnt].children[0].innerHTML = rollingData[dataCnt]
				            document.getElementById('rolling_box').children[listCnt].children[0].setAttribute("href", "boardView.do?boardType=1&boardNo="+hrefData[dataCnt]);

				                dataCnt++
				        } else if(dataCnt == rollingData.length - 1) {
				            document.getElementById('rolling_box').children[listCnt].children[0].innerHTML = rollingData[dataCnt]
				            document.getElementById('rolling_box').children[listCnt].children[0].setAttribute("href", "boardView.do?boardType=1&boardNo="+hrefData[dataCnt]);
				            dataCnt = 0
				        }
				
				        if(listCnt < 2) {
				            listCnt++
				        } else if (listCnt == 2) {
				            listCnt = 0
				        }
				        
				    }, timer);			
				}
			})
		});
      

      </script>
      <style>
         .rolling_box{
			margin:0 auto;
            width: 1170px;
            height: 50px;
            text-align: left;
        }

        .rolling_box ul {
            width: 100%;
            height: 100%;
            overflow: hidden;
            position: relative;
        }

        .rolling_box ul li {
        	margin-top:20px;
            list-style: none;
            width: 100%;
            height: 100%;
            transition: .5s;
            position:absolute;
            transition: top .75s;
            top: 100%;
            z-index: 3;
            padding-left: 20px;
            color: #fff;
        }
	
        .card_sliding{
            top: 0 !important;
            z-index: 100 !important;
        } 

        .card_sliding_after{
            top: -100% !important;
            z-index: 10 !important;
        }

        .rolling_box ul li a{
            font-size: 20px;
            line-height: 5px;
            font-weight: bold;
		    border: none;
		    color: #fff;
		    text-decoration: none;
		    
        }

        .before_slide {
            transform: translateY(100%);
        }

        .after_slide {
            transform: translateY(0);
        }
      </style>
  </footer>