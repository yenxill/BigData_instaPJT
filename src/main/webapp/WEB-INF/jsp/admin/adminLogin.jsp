<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <link rel="stylesheet" href="/css/egovframework/main.css" /> -->
<title>로그인</title>

<!-- favicon -->
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png"/>
<link rel="icon" type="image/png" sizes="32x32" href="/images/egovframework/favicon/favicon-32x32.png"/>
<link rel="icon" type="image/png" sizes="16x16" href="/images/egovframework/favicon/favicon-16x16.png"/>

<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/522c2b7a73.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/css/egovframework/reset.css">
<link rel="stylesheet" href="/css/egovframework/color.css">
<link rel="stylesheet" href="/css/egovframework/common.css">
<link rel="stylesheet" href="/css/egovframework/style.css">

<script src="/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		$("#login-btn").on('click', function(){
			fn_login();
		});

	});

	function fn_login() {
	      var frm = $("#login-form");
	      var userId = $("#userId").val();
	      var userPw = $("#userPw").val();
	      
	      if (userId === "") {
	         alert("사용자 이름을 입력해주세요.");
	         return;
	      } else if (userPw === "") {
	         alert("비밀번호를 입력해주세요.");
	         return;
	      } else {
	         frm.attr("method", "POST");
	         frm.attr("action", "/admin/loginAction.do");
	         frm.submit();
	      }
	   }
	
	function fn_createAccount() {
	    // 동적으로 form 태그 생성
	    var frm = $('<form></form>');
	    frm.attr("method", "POST");
	    frm.attr("action", "/join.do");

	    // body에 form을 추가하고 제출
	    $('body').append(frm);
	    frm.submit();
	}
	

</script>
</head>

<body>
	<div class="wrapper">
		<div class="form-container">
			<div class="box login-box">
				<h1 class="logo">
					<img class="logo-light" src="/images/egovframework/photo/logo-light.png" alt="instagram light-logo">
					  <img class="logo-dark" src="/images/egovframework/photo/logo-dark.png" alt="instagram dark-logo" >
				</h1>

				<form id="login-form" method="post">
					<div class="animate-input">
						<span>전화번호, 사용자 이름 또는 이메일</span> 
						<input id="userId" name="userId" type="text">
					</div>

					<div class="animate-input">
						<span>비밀번호</span> 
						<input id="userPw" name="userPw" type="password">
						<button id="pw-btn" type="button">비밀번호 표시</button>
					</div>

					<button type="submit" class="btn-blue" id="login-btn" disabled>로그인</button>
					<!-- type: button:마우스 클릭만 가능 submit: 키보드 enter로 가능함-->
				</form>

				<div class="or-box">
					<div></div>
					<div>또는</div>
					<div></div>
				</div>

				<div class="fb-btn">
					<img src="/images/egovframework/photo/facebook-icon.png" alt="facebook-icon"> <span>Facebook으로 로그인</span>
				</div>

				<a href="" class="forgot-pw">비밀번호를 잊으셨나요?</a>
			</div>

			<div class="box join-box">
				<p>
					계정이 없으신가요?  
					<a href="javascript:fn_createAccount();">가입하기</a>
				</p>
			</div>

			<div class="app-download">
				<p>앱을 다운로드하세요.</p>
				<div class="store-link">
					<a href=""> 
					<img src="/images/egovframework/photo/app-store.png"
						alt="app-store-img">
					</a> <a href=""> <img src="/images/egovframework/photo/gg-play.png"
						alt="gg-play-img">
					</a>
				</div>
			</div>
		</div>

		<footer>
			<ul class="links">
				<li><a href="">Meta</a></li>
				<li><a href="">소개</a></li>
				<li><a href="">블로그</a></li>
				<li><a href="">채용 정보</a></li>
				<li><a href="">도움말</a></li>
				<li><a href="">API</a></li>
				<li><a href="">개인정보처리방침</a></li>
				<li><a href="">약관</a></li>
				<li><a href="">위치</a></li>
				<li><a href="">Instagram Lite</a></li>
				<li><a href="" id="mode-btn">Darkmode</a></li>
			</ul>
			<div class="copyright">© 2024 Instagram from Meta</div>
		</footer>
</div>

<script src="/js/script.js"></script>
</body>

</html>