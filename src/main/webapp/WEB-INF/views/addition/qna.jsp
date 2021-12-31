<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의게시판</title>
<script src="https://kit.fontawesome.com/4054b6ceaa.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/additionCss/qna.css">
</head>
<body>


	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container" id="container">
		<div id="title">FAQ</div>
		<ul id="titlemenu" class="nav nav-pills nav-justified">
			<li class="active"><a data-toggle="pill" href="#home">공연</a></li>
			<li><a data-toggle="pill" href="#show">관람</a></li>
			<li><a data-toggle="pill" href="#ticket">예매</a></li>
			<li><a data-toggle="pill" href="#other">기타</a></li>
		</ul>
		<div class="tab-content">
		  <div id="home" class="tab-pane fade in active" >
				<ul id="bbs-faq" class="bbs-faq">
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">공연 시작 몇 분 전부터 입장이 가능한가요?</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">일반적으로 공연시작 30분 전부터는 객석에 입장이 가능하며, 원활한 공연 진행을 위해 늦어도 공연시작 10분 전까지는 입장하여 주시기 바랍니다.</p>
					</div>
					</li>
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">최근 공연, 전시정보를 알고 싶습니다.</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">홈페이지, 서비스플라자, 콜센터(02-399-1000, 오전 10시부터 오후 8시까지 연중무휴)를 통해 공연, 전시정보를 접하실 수 있습니다.</p>
					</div>
					</li>
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">공연 영상자료(VIDEO, DVD)를 구할 수 있나요?</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">공연별 주최측에 문의하시기 바랍니다.주최측 문의 전화번호는 각 공연정보를 참고하시기 바랍니다.<br>
						(각 공연정보는 공연명을 아실 경우 홈페이지 상단의 검색창을 통해 검색하시거나,<br>
						공연 날짜를 아실 경우 공연/전시 메뉴에서 캘린더를 통해 검색하시면 됩니다.)
						</p>
					</div>
					</li>
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">공연팜플렛을 구입할 수 있을까요?</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">
						 공연당일은 공연장 로비에서 팜플렛을 구입하실 수 있습니다.<br>공연일이 지난 경우에는 공연주최측에 문의하시기 바랍니다.
			  			<br>주최측 문의전화는 각 공연정보를 참고하시기 바랍니다.(각 공연정보는 공연명을 아실 경우 홈페이지 상단의 검색창을 통해 검색하시거나,
						 <br> 공연 날짜를 아실 경우 공연/전시 메뉴에서 캘린더를 통해 검색하시면 됩니다.)
						
						</p>
					</div>
					</li>
					
				</ul>
			
		  </div>
		  <div id="show" class="tab-pane fade">
		    <ul id="bbs-faq" class="bbs-faq">
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">공연중 음식물반입이 가능한가요?</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">
						모든 일체의 음식물은 공연장 안으로 가져갈 수 없습니다.<br>자신의 조그만 부주의가 공연자는 물론 객석의 관람자에게도 큰 피해를 주어 공연장 분위기를 망칠 수 있는 것을 양해해 주시고,
						<br>음식물은 꼭 드신 후 입장해 주시기 바랍니다.</p>
					</div>
					</li>
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">공연시작후 빈좌석으로 이동이 가능한가요?</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">매진이 되지 않아 좌석이 비어 있는 공연이라 하더라도 좌석 이동은 불가합니다.
						<br>공연 중에 좌석을 이동하는 것은 다른 관객에게 불편을 초래하는 일이며, 관람환경을 해하는 행위입니다.
						<br>설사 공연 시작 전이라 하더라도 문화에티켓에 어긋나는 일입니다.</p>
					</div>
					</li>
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">공연 촬영, 녹음, 녹화가 가능한가요?</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">사진촬영, 녹음, 녹화는 절대 금물입니다.
						<br>종합구성물의 무대장치나 공연장면, 유명연주자들의 모습은 모두 저작권에 해당하는 것으로, 무단촬영 배포가 금지되어 있습니다.
						<br>세종문화회관에서도 사전에 공연단체에게 허락을 받고 상업적인 사용을 하지 않는다는 약속을 한 후에 공연기록용 사진을 촬영하며,
						<br>프로그램이나 소식지에 사진을 사용하는 데에도 별도의 승인을 받고 있습니다.
						<br>공연 중의 사진 촬영이나 녹음, 녹화 등은 공연물의 초상권과 저작권을 침해하는 행위이며,
						<br>공연장은 공공장소라는 점을 감안하시어 공연관람의 기본적인 에티켓을 지켜 주시기 바랍니다.
						</p>
					</div>
					</li>
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">공연장 입장시 복장 제한이 있나요?</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">
						공연장에 입장하기 위한 복장 규정은 없습니다.
						<br>단, 공연은 영화와 달라서 관람하시는 그 순간이 지나면 다시는 똑같은 분위기, 연기를 보실수 없는 '현장' 예술입니다.
						<br>본인 스스로 편안하게 공연에 몰입할 수 있는 복장을 갖추시는 것이 좋습니다.
						<br>공연을 즐겨 관람하시는 분들은 스스로의 마음가짐을 위해서 정장을 고집하시기도 합니다.또 한가지는 주변의 다른 관객들에 대한 배려입니다.
						<br>바스락 거리는 소리가 많이 나는 재질의 옷이라던가 지나치게 화려한 색상이나 디자인은 삼가시는 것이 좋습니다.
						<br>공연관객들께서는 그 어느때보다 시각과 청각이 예민해져 있는 상태이기때문에
						<br>평상시에는 잘 안들리던 소리나 모습에도 신경이 쓰일 수 밖에 없기 때문입니다.
						<br>공연장을 찾으실 때 옷차림은 소중한 시간을 마음껏 즐길 수 있는 마음가짐을 표현하시는 무난하고 편안한 복장이 좋습니다.
						</p>
					</div>
					</li>
				</ul>
		  </div>
		  
		  
		  <div id="ticket" class="tab-pane fade">
				<ul id="bbs-faq" class="bbs-faq">
						<li class="item">
						<div class="q">
							<span class="t"><a id="question" href="#1" title="답변 열기">티켓 예매는 어떻게 하나요?</a></span>
						</div>
						<div class="a" id="#1">
							<p id="answer">무지다 예매 방법은 인터넷, 전화, 방문 예매가 있습니다.</p>
						</div>
						</li>
						<li class="item">
						<div class="q">
							<span class="t"><a id="question" href="#1" title="답변 열기">카드결제후 취소했는데 언제 입금되나요?</a></span>
						</div>
						<div class="a" id="#1">
							<p id="answer">고객님의 카드결제일에 따라 이번달 혹은 다음달에 입금됩니다.
							<br>정확한 입금 날짜를 확인하시려면 고객님께서 사용하시는 해당 카드사에 문의해보시는것이 가장 정확합니다. </p>
						</div>
						</li>
						<li class="item">
						<div class="q">
							<span class="t"><a id="question" href="#1" title="답변 열기">입장권을 분실했습니다. 어떻게 해야 하나요?</a></span>
						</div>
						<div class="a" id="#1">
							<p id="answer">
							공연입장권은 소지자에게 우선권이 있으며, 예약정보만으로 입장하실 수는 없습니다.
							<br>항상 분실하지 않도록 유의해주시기 바라며 자세한 사항은
							<br>서비스플라자(02-399-1000, 오전 10시부터 오후 8시까지 연중무휴, 13-14시 점심시간 제외)로 전화문의하시기 바랍니다.
							</p>
						</div>
						</li>
						<li class="item">
						<div class="q">
							<span class="t"><a id="question" href="#1" title="답변 열기">티켓구입시 중복할인이 적용되나요?</a></span>
						</div>
						<div class="a" id="#1">
							<p id="answer">
							일반적으로 티켓 구입시 중복 할인은 적용되지 않습니다.<br>예매하시기 전에 관람을 원하시는 공연의 할인정보를 미리 숙지하시기 바랍니다.
							</p>
						</div>
						</li>
					</ul>
		  </div>
		  
		  
		  <div id="other" class="tab-pane fade">
		  		<ul id="bbs-faq" class="bbs-faq">
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">아이디 또는 비밀번호를 잊어버렸어요.</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">'로그인 화면의 ''ID찾기', 또는 '비밀번호찾기'에서 실명인증을 받으신 후, ID와 비밀번호를 안내받으실 수 있습니다.<br>
						문제가 있을 시에는 콜센터 (02-549-2233, 오전 9시부터 오후 6시까지 )로 문의주시기 바랍니다.</p>
					</div>
					</li>
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">인터넷 예매시 오류가 났습니다.</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">무지다 콜센터 (02-549-2233, 오전 9시부터 오후 6시까지 )로 문의해 주시기 바랍니다.</p>
					</div>
					</li>
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">대관서비스에 대해 알려주세요.</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">
						홈페이지 상단 메뉴 중 대관안내를 클릭하시면 자세한 사항을 보실 수 있습니다.
						</p>
					</div>
					</li>
					<li class="item">
					<div class="q">
						<span class="t"><a id="question" href="#1" title="답변 열기">공연, 전시장 시설이 궁금해요.</a></span>
					</div>
					<div class="a" id="#1">
						<p id="answer">
						홈페이지 상단메뉴에서 기관소개를 클릭하시면 새 창이 열리고, 그 후 상단메뉴에서 시설소개를 클릭하시면 시설소개에 대한 자세한 사항을 보실 수 있습니다.
						</p>
					</div>
					</li>
				</ul>
		  
		  </div>
		
		</div>
		
		
		
		
		<div id="title2">1대1문의</div>
		<div id="table">
			<div>
				<form action="/searchKeyword.do?boardType=2&reqPage=1" method="post">
				 	<select name="type" id="type">
				 		<option value="tac">제목+내용</option>
				 		<option value="writer">작성자</option>
				 	</select>
				 	<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요.">
				 	<button id="submit"><i class="fas fa-search"></i></button>
				</form>
			</div>
			<table id="table1" class="table">
				<tr id="firtr">
					<td>번호</td><td>제목</td><td>작성자</td><td>작성일</td><td>답변상태</td>
				</tr>
				<c:forEach	items="${list }" var="b" varStatus="i">
				<c:if test="${b.bnum != 0 }">
				<tr>
					<td>${b.bnum }</td>
					<c:choose>
						<c:when test="${b.boardLevel eq 1}">
							<td id="btitle"><a href="/boardView.do?boardType=2&boardNo=${b.boardNo}" class="chk"><i class="fas fa-lock"></i>&nbsp;&nbsp;${b.boardTitle }</a></td>
							<input type="hidden" class="boardLevel" value="${b.boardLevel }">
							<input type="hidden" class="memberId" value="${sessionScope.m.memberId }">
							<input type="hidden" class="memberLevel" value="${sessionScope.m.memberLevel }">
							<input type="hidden" class="boardWriter" value="${b.boardWriter }">
						</c:when>
						<c:otherwise>
							<td id="btitle"><a href="/boardView.do?boardType=2&boardNo=${b.boardNo}">${b.boardTitle }</a></td>
						</c:otherwise>
					</c:choose>
					<td>${b.boardWriter }</td>
					<td>${b.regDate }</td>
					<c:choose>
						<c:when test="${b.commentCount ne 0}">
						<td id="answerAfter">답변완료</td>
						</c:when>
						<c:otherwise>
						<td id="answerBefore">미답변</td>
						</c:otherwise>
					</c:choose>
				</tr>
				</c:if>
				</c:forEach>
			</table>
		</div>
		<div id="page">
			<div id="pageNavi">${pageNavi }</div>
		</div>
		<c:if test="${not empty sessionScope.m }">
			<div id="table">
				<a class="btn" id="write" href="/boardWriteFrm.do?boardType=2">글작성</a>
				<a class="btn" id="my" href="/myFree.do?memberId=${sessionScope.m.memberId }">내글 보기</a>
			</div>	
		</c:if>
	</div>
	<script type="text/javascript">
	$(".bbs-faq .q a").click(function() {
		$(this).closest(".q").toggleClass("active");
		$(".bbs-faq .q a").not(this).attr({"title":"답변 열기"});
		$(".bbs-faq .q a").not(this).closest(".q").removeClass("active");
		var target = $(this).closest(".item").find(".a");
		var other = $(".bbs-faq .q a").not(this).closest(".item").find(".a");
		if ($(this).closest(".q").hasClass("active")){
			$(this).attr({"title":"답변 닫기"});
		}else{
			$(this).attr({"title":"답변 열기"});
		}
		target.slideToggle(150);
		other.slideUp(150);
		return false;
	});
	
	
	$(document).on("click",".chk",function(){
		var idx=$(".chk").index(this);
		var boardWriter = $(".boardWriter").eq(idx).val();
		var boardLevel = $(".boardLevel").eq(idx).val();
		var memberId = $(".memberId").eq(idx).val();
		var memberLevel = $(".memberLevel").eq(idx).val();
		if(memberId ==""){
			alert("읽기 권한이 없습니다.");
			return false;
		}
		if(boardLevel==1){
			if(memberLevel == 0){
				return true;
			}else if(boardWriter == memberId){
				return true;
			}else{
				alert("읽기 권한이 없습니다.");
				return false;
			}
		}
    });
	
	$("#submit").click(function(){
		var keyword = $("#keyword").val();
		if(keyword == ""){
			alert("검색어를 입력하세요.");
			return false;
		}
	});
	
	/*faq*/
	var acc = document.getElementsByClassName("accordion");
	var i;
	
	for (i = 0; i < acc.length; i++) {
	  acc[i].addEventListener("click", function() {
	    this.classList.toggle("active");
	    var panel = this.nextElementSibling;
	    if (panel.style.maxHeight) {
	      panel.style.maxHeight = null;
	    } else {
	      panel.style.maxHeight = panel.scrollHeight + "px";
	    }
	  });
	}
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>