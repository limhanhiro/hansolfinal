<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!--   <script src="jquery.js"></script> 
  <script src="jquery.fadethis.min.js"></script>-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<link rel="stylesheet"
	href="https://unpkg.com/swiper/css/swiper.min.css">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="stylesheet" href="/resources/commonCss/main.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.css" />
<link rel="stylesheet" href="/resources/commonCss/mainhf.css">
<title>Musee d art</title>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="50" style="overflow-x:hidden; overflow-y:auto">
	<div class="popup">
		<div id="popup">
			<header class="top">
				<!--                 <h1 class="infoTit">소개</h1>  -->
			</header>
			<main class="textBox">
				<h2 class="tit">Musée d'art</h2>
				<p class="textContents">
					musée d'art 뜻은 프랑스어로 '미술관'을 뜻합니다.<br> 발음대로 읽으면 '무지다'가 되며 강원도
					방언으로 '모이다'라는 뜻도 더하여 저희 홈페이지는 공연 전시 관람 및 열람 다양한 문화생활을 모은 장소를 만들었습니다.
				<p>
					<strong>적용기간 : 2021.07.14~12.29</strong>
				</p>
				<p style="font-size: 7px;">예쁘게 봐주시구 5개월동안 수고많으셨습니다 :) Au revir!</p>
				<p>KH Team3</p><br><br><br>
				<p style="font-size: 5px">made by 주연 승준 지원 한솔 준택 하얀</p>
			</main>

		</div>
		<footer class="btnBox_todayClose">
			<form method="post" action="" name="pop_form">
				<span id="check"> <a href="javascript:void(0)" id="cp"
					style="color: #fff">닫기</a>
				</span>
			</form>
		</footer>
	</div>

	<div class="container" style="width: 100%; height: 100vh;" >
		<div class="quick">
			<div class="imgb">
				<div class="pop-content">
					<div class="pop-title">
						<p>
							대관 많은 이용 바랍니다.<br>
							종강 축하축하<br><br>
						</p>
						<h1>무지다 문화센터<br></h1>
					</div>
					<div class="pop-table">
						<div class="pop-con">
							<a href="/spaceView.do?spaceNo=41&reqPage=1"><span class="iconimg"><img
								src=" /resources/mainImage/upload/m-icon1.png"></span> <span
								class="iconname"><br>다목적실
							</span></a>
						</div>
						<div class="pop-con">
							<a href="/spaceView.do?spaceNo=43&reqPage=1">
							<span class="iconimg">
							<img src=" /resources/mainImage/upload/m-icon2.png"></span> <span
								class="iconname"><br>연습실
							</span></a>
						</div>
						<div class="pop-con">
						<a href="/spaceView.do?spaceNo=44&reqPage=1">
							<span class="iconimg"><img
								src=" /resources/mainImage/upload/m-icon3.png"></span> <span
								class="iconname"><br>세미나실
							</span></a>
						</div>
						<div class="pop-con">
						<a href="/spaceView.do?spaceNo=45&reqPage=1">
							<span class="iconimg"><img
								src=" /resources/mainImage/upload/m-icon4.png"></span> <span
								class="iconname"><br>강의실
							</span>
							</a>
						</div>
					</div>
				</div>
				<button class="btn-quick close1">Close</button>
			</div>
		</div>
	</div>

	<script>
              var size = "";
              $(window).resize(function(){
                var m_w = $(window).width();
                var q_w = $(".quick").outerWidth();
                if ( m_w > 1350 ) {
                          size = -q_w
                          //$(".main_quick").css("right",size)
                      //$(".main_quick").delay(8000).animate({"right":-q_w},800)
                }else {
                    $(".btn-quick").removeClass("close1").addClass("open").text("Open")
                      size = -q_w
                      $(".quick").css("right",-q_w)
                }
                }).resize();
      
                $(".btn-quick").click(function(){
                  if($(this).hasClass('open')){
                      $(".quick").animate({"right":0},300);
                      //$(".quick").delay(300).stop().fadeIn(300)
                      
                    $(this).removeClass('open').addClass('close1').text('Close');
                  }else{
                      $(".quick").animate({"right": -650},300);
                       //$(".quick").delay(300).stop().fadeOut(300)
                       $(this).show();
                    $(this).removeClass('close1').addClass('open').text('Open');
      
                  }
              })
          </script>
	<!-- <div class="container" style="width: 100%;"> -->
	<div class="slider-for d1">
		<div class="sf">
			<a href="/showView.do?showNo=8"><img src=" /resources/mainImage/upload/m-main8.jpg"></a>
		</div>
		<div class="sf">
			<a href="/showView.do?showNo=2"><img src=" /resources/mainImage/upload/m-main2.jpg"></a>
		</div>
		<div class="sf">
			<a href="/showView.do?showNo=21"><img src=" /resources/mainImage/upload/m-main7.jpg"></a>
		</div>
		<div class="sf">
			<a href="/showView.do?showNo=6"><img src=" /resources/mainImage/upload/m-main4.jpg"></a>
		</div>
		<div class="sf">
			<a href="/showView.do?showNo=5"><img src=" /resources/mainImage/upload/m-main5.jpg"></a>
		</div>
	</div>
	<div class="sliderbg">
		<div class="slider-nav d2">
			<div class="sn">
			<img src="/resources/showImage/upload/6.png">
			</div>
			<div class="sn">
			<img src=" /resources/mainImage/upload/m-show2.jpg">
			</div>
			<div class="sn">
			<img src=" /resources/mainImage/upload/show7.jpg">
			</div>
			<div class="sn">
			<img src=" /resources/mainImage/upload/m-show4.jpg">
			</div>
			<div class="sn">
			<img src=" /resources/mainImage/upload/m-show5.jpg">
			</div>
		</div>
	</div>
	<div class="header-title">
		<div class="h-logo">
			<a href="/main.do">Musée d'art</a>
		</div>
		<div class="h-left">
			<nav class="header-nav">
				<div class="navi">
					<ul>
						<li><a href="/showList.do">공연 · 예매</a></li>
						<li><a href="/spaceMain.do">공간 · 대관</a>
							<ul class="sub">
								<li><a href="/spaceMain.do">대관 안내</a></li>
								<li><a href="/spaceList.do">공간 소개</a></li>
								<li><a href="/spaceRes.do?spaceNo=0">대관 현황</a></li>
								<li><a href="/selectSpaceBoardList.do?reqPage=1">사용 게시판</a></li>
							</ul></li>
						<li><a href="/exhibitionList.do?reqPage=4">전시</a></li>
						<li><a href="/readingNotice.do">열람실</a></li>
						<li><a href="/academyList.do?reqPage=4&category=all">아카데미</a>
							<ul class="sub">
								<li><a href="/academyList.do?reqPage=4&category=all">수강
										신청</a></li>
								<li><a href="/requritList.do?reqPage=1">강사 모집</a></li>
								<c:choose>
									<c:when
										test="${not empty sessionScope.m && sessionScope.m.memberLevel == 1 }">
										<li><a href="#">수업 관리</a></li>
									</c:when>
									<c:when
										test="${not empty sessionScope.m && sessionScope.m.memberLevel == 2 }">
										 <li><a href="/teacherAcademyList.do?academyTeacher=${sessionScope.m.memberName }">학생관리</a></li>
									</c:when>
								</c:choose>
							</ul></li>
						<li><a href="/additionBoard.do?boardType=1&reqPage=1">부가서비스</a>
							<ul class="sub">
								<li><a href="/additionBoard.do?boardType=1&reqPage=1">공지사항</a></li>
								<li><a href="/additionBoard.do?boardType=3&reqPage=1">소통게시판</a></li>
								<li><a href="/additionBoard.do?boardType=2&reqPage=1">문의게시판</a></li>
								<li><a href="/additionGuide.do">시설안내 · 오시는 길</a></li>
								<li><a href="/discount.do">이벤트</a></li>
							</ul></li>
					</ul>
				</div>
			</nav>
		</div>
		<div class="h-right">
			<c:choose>
				<c:when test="${empty sessionScope.m }">
					<a href="/loginFrm.do">Sign in <span>></span></a>
				</c:when>
				<c:when
					test="${not empty sessionScope.m && sessionScope.m.memberLevel == 0}">
					<a href="/allMember.do?selectmenu=5&reqPage=1">My Page[관리] <span>></span></a>
					<br>
					<a href="/logout.do">로그아웃</a>
				</c:when>
				<c:when
					test="${not empty sessionScope.m && sessionScope.m.memberLevel == 1 || sessionScope.m.memberLevel == 2}">
					<a href="/mypage.do?memberNo=${sessionScope.m.memberNo }">${sessionScope.m.memberId } Page <span>></span><br>
					</a>
					<a href="/logout.do"> 로그아웃</a>
				</c:when>
			</c:choose>
		</div>
		<div class="headerText" style="text-shadow: 2px 2px 2px gray;">
			<strong>${headerText}</strong>
		</div>
	</div>
	<script type="text/javascript"
		src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript"
		src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>

	<script type="text/javascript">
              
              $('#cp').click(function () {
                  $('.popup').hide();
              })
              
             $('.slider-for').slick({
              slidesToShow: 1,
              slidesToScroll: 1,
              arrows: false,
              fade: true,
              asNavFor: '.slider-nav'
            });
            $('.slider-nav').slick({
              autoplay: true,
              slidesToShow: 4,
              slidesToScroll: 1,
              asNavFor: '.slider-for',
              dots: false,
              centerMode: true,
              focusOnSelect: true
            });
              </script>


	<div class="showslide">
		<!-- Swiper -->
		<div class="swiper mySwiper">
			<div class="swiper-wrapper">
				<c:forEach items="${artlist }" var="al">
				<div class="swiper-slide">
					<img src="${al.exhibitionPhoto }">
					<div class="cover">
						<div class="cover-content">
							<h5>${al.exhibitionTitle }</h5>
							<hr>
							<button class="reserve-button" onClick="location.href='/exhibitionView.do?exhibitionNo=${al.exhibitionNo }'">예매</button>
						</div>
					</div>
				</div>
				
				</c:forEach>
			</div>
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
			<div class="swiper-pagination"></div>
		</div>
	</div>
	<!-- Swiper JS -->
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

	<!-- Initialize Swiper -->
	<script>
                var swiper = new Swiper(".mySwiper", {
                  slidesPerView: 5,
                  spaceBetween: 30,
                  slidesPerGroup: 3,
                  loop: true,
                  loopFillGroupWithBlank: true,
                  pagination: {
                    el: ".swiper-pagination",
                    clickable: true,
                  },
                  navigation: {
                    nextEl: ".swiper-button-next",
                    prevEl: ".swiper-button-prev",
                  },
                });
              </script>

	<div class="banner">
		<div class="slide-right up-on-scroll">
			<a href="/boardView.do?boardType=5&boardNo=390"><img src=" /resources/mainImage/upload/m-newbanner.jpg"></a>
		</div>
	</div>

	<div class="m-notice">
		<div class="slide-right up-on-scroll">
			<div class="notice-menu">
				<li class="l-notice">
					<div class="tit-main">
						<span class="small">Requrit</span>
						<h2 class="t">모집공고</h2>
					</div>
					<c:forEach items="${requrit }" var="r" begin="0" end="1">
					<ul class="ln-content">
						<li class="lnc-box"><a href="/requritView.do?requritNo=${r.requritNo }"><span class="t">${r.requritTitle }</span></a><br>
						<span class="date" style="font-size:14px; position: absolute;padding-top:100px;">${r.requritStart }~${r.requritEnd }</span></li>
					</ul>
					</c:forEach>
				</li>

				<li class="r-popup">
					<div class="tit-main">
						<span class="small">New Academy</span>
						<h2 class="t">아카데미</h2>
					</div>
					<div class="w">
					<c:forEach items="${academy }" var="ac" begin="0" end="1">
						<ul class="ln-content">
							<li class="rpc-box"><a href="/academyView.do?academyNo=${ac.academyNo }"><img src="${ac.academyPhoto }" style="z-index:1;"></a> 
							<span class="t">${ac.academyTitle}</span>
							<span class="date" style="z-index:2;">${ac.academyStart } ~ ${ac.academyEnd }</span></li>
						</ul>
					</c:forEach>
					</div>
				</li>
			</div>
		</div>
	</div>
	<button class="toTop" onclick="goTop();" style="display: none">TOP</button>
	<script>
    $(window).on("scroll", function(){
        if($(window).scrollTop() > 400){
            $(".toTop").show();
        }else{
            $(".toTop").hide();
        }
    });
    
	function goTop() {
		window.scrollTo(0,0);
	}
	
                 $('.autoplay').slick({
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    autoplay: true,
                    autoplaySpeed: 2000,
                  });
      </script>
	<script>
              function isElementUnderBottom(elem, triggerDiff) {
            const { top } = elem.getBoundingClientRect();
            const { innerHeight } = window;
            return top > innerHeight + (triggerDiff || 0);
          }
                function handleScroll() {
            const elems = document.querySelectorAll('.up-on-scroll');
            elems.forEach(elem => {
              if (isElementUnderBottom(elem, -20)) {
                elem.style.opacity = "0";
                elem.style.transform = 'translateY(70px)';
              } else {
                elem.style.opacity = "1";
                elem.style.transform = 'translateY(0px)';
              }
            })
          }
          
          window.addEventListener('scroll', handleScroll);
              </script>
	<script>
        (function() {
          var w = window;
          if (w.ChannelIO) {
            return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
          }
          var ch = function() {
            ch.c(arguments);
          };
          ch.q = [];
          ch.c = function(args) {
            ch.q.push(args);
          };
          w.ChannelIO = ch;
          function l() {
            if (w.ChannelIOInitialized) {
              return;
            }
            w.ChannelIOInitialized = true;
            var s = document.createElement('script');
            s.type = 'text/javascript';
            s.async = true;
            s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
            s.charset = 'UTF-8';
            var x = document.getElementsByTagName('script')[0];
            x.parentNode.insertBefore(s, x);
          }
          if (document.readyState === 'complete') {
            l();
          } else if (window.attachEvent) {
            window.attachEvent('onload', l);
          } else {
            window.addEventListener('DOMContentLoaded', l, false);
            window.addEventListener('load', l, false);
          }
        })();
        ChannelIO('boot', {
          "pluginKey": "30646173-f05a-4c55-9818-46a0543b5882"
        });
      </script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>

<style>
.quick {
	position: absolute;
	right: 0;
	top: 0;
	width: 650px;
	height: 700px;
	z-index: 5;
}

.btn-quick {
	z-index: 4;
	border: rgb(11, 11, 51);
	width: 100px;
	height: 100px;
	top: 42%;
	position: absolute;
	left: -55px;
	font-size: 15px;
	border-radius: 50%;
	text-align: left;
	padding-left: 15px;
	background-color: rgb(11, 11, 51);
	color: #fff;
}

.btn-quick close1 {
	z-index: 4;
	border: rgb(11, 11, 51);
	width: 100px;
	height: 100px;
	top: 42%;
	position: absolute;
	left: -55px;
	font-size: 15px;
	border-radius: 50%;
	text-align: left;
	padding-left: 15px;
	background-color: rgb(11, 11, 51);
	color: #fff;
}

.imgb {
	background-image: url("/resources/mainImage/upload/m-gifimage.gif");
	width: auto;
	height: 100%;
	overflow-y: auto;
	background-size: cover;
}

.pop-content {
	display: flex;
	padding-left: 70px;
	padding-top: 70px;
}

.pop-title {
	writing-mode: tb-rl;
	letter-spacing: 0.4em;
	margin: 0;
	font-size: 20px;
	font-style: bold;
	color: #fff;
	writing-mode: tb-rl;
	animation: fadeInDown 1.5s;
}

@
keyframes fadeInDown { 0% {
	opacity: 0;
	transform: translate3d(0, -100%, 0);
}

to {
	opacity: 1;
	transform: translateZ(0);
}

}
@
keyframes fade { 0% {
	opacity: 0;
	transform: translate3d(0);
}

to {
	opacity: 1;
	transform: translateZ(0);
}

}
.pop-table {
	animation: fade 2s;
	margin-top: -10px;
	margin-left: 250px;
	position: absolute;
	width: 250px;
	height: 250px;
}

.pop-con {
	float: left;
	border: solid 1px rgb(255, 255, 255, .3);
	width: 120px;
	height: 120px;
}

.icon {
	margin: auto;
}

/* .close:focus, .close:hover {
	color: #fff;
	background-color: rgb(11, 11, 51);
	text-decoration: none;
	cursor: pointer;
	padding-left: 15px;
	opacity: 1;
} */
.toTop{
	opacity: 0.7;
    cursor: pointer;
    display: inline-block;
	background-color: #195083;
	color: #fff;
	right: 125px;
	bottom: 65px;
	position: fixed;
	width: 4em;
    text-align: center;
    height: 4em;
    line-height: 4em;
    border-radius: 50%;
    font-size: 1em;
    z-index: 3;
    font-weight: 500;
}
</style>
</html>