<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script> -->

<!-- favicon -->
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png"/>
<link rel="icon" type="image/png" sizes="32x32" href="/images/egovframework/favicon/favicon-32x32.png"/>
<link rel="icon" type="image/png" sizes="16x16" href="/images/egovframework/favicon/favicon-16x16.png"/>
	
<title>회원가입</title>

<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/522c2b7a73.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/css/egovframework/reset.css">
<link rel="stylesheet" href="/css/egovframework/color.css">
<link rel="stylesheet" href="/css/egovframework/common.css">
<link rel="stylesheet" href="/css/egovframework/joinStyle.css">

<script src="/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){

	});	

	function fn_join(){
		var userEmail = $("#userEmail").val();
		var userName = $("#userName").val();
		var userId = $("#userId").val();
		var userPw = $("#userPw").val();
		
		if(userEmail == ""){
			alert("이메일을 입력하세요..");
			return;
		}else if(userName === ""){
			alert("성명을 입력 해주세요.");
			return;
		}else if(userId === ""){
			alert("이름을 입력하세요");
			return;
		}else if(userPw === ""){
			alert("비밀번호를 입력하세요");
			return;
		}else{
			// 회원가입이 되는 부분
			var frm = $("#join-form").serialize();
			$.ajax({
			    url: '/member/insertMember.do',
			    method: 'post',
			    data : frm,
			    dataType : 'json',
			    success: function (data, status, xhr) {
			        if(data.resultChk > 0){
			        	alert("회원이 되신걸 축하드립니다.");
			        	location.href="/admin.do";
			        }else{
			        	alert("회원가입에 실패하였습니다.");
			        	return;
			        }
			    },
			    error: function (data, status, err) {
			    }
			});
			
		}
	}
	
</script>

</head>
<body>
	<div class="wrapper">
		<div class="form-container">
			<div class="box input-box">
				<h1 class="logo">
					<img src="/images/egovframework/photo/logo-light.png" alt="insta-logo"
						class="logo-light">
				</h1>

				<p class="join-para">친구들의 사진과 동영상을 보려면 가입하세요.</p>

				<button class="btn-blue fb-btn">
					<i class="fa-brands fa-square-facebook"></i> 
					<span>Facebook으로 로그인</span>
				</button>

				<div class="or-box">
					<div></div>
					<div>또는</div>
					<div></div>
				</div>

				<form action="" name="" id="join-form">
					<div class="animate-input">
						<span>휴대폰 번호 또는 이메일 주소</span> 
						<input id="userEmail" name="userEmail" type="text">
					</div>

					<div class="animate-input">
						<span>성명</span> <input id="userName" name="userName" type="text">
					</div>

					<div class="animate-input">
						<span>사용자 이름</span> <input id="userId" name="userId" type="text">
					</div>

					<div class="animate-input">
						<span>비밀번호</span> <input id="userPw" name="userPw" type="password">
						<button id="pw-btn" type="button">비밀번호 표시</button>
					</div>

					<p class="more-info">
						저희 서비스를 이용하는 사람이 회원님의 연락처 정보를 Instagram에 업로드했을 수도 있습니다. <a href="">더알아보기</a>
					</p>

					<button id="join-btn" type="button" class="btn-blue" onclick="fn_join()" disabled>가입</button>
				</form>
			</div>

			<div class="box join-box">
				<p>
					계정이 있으신가요? 
					<a href="/admin.do">로그인</a>
				</p>
			</div>

			<div class="app-download">
				<p>앱을 다운로드하세요.</p>
				<div class="store-link">
					<a href=""> <img src="/images/egovframework/photo/app-store.png"
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
				<li><a href="" id="mode-toggle">Darkmode</a></li>
			</ul>
			<P class="copyright">© 2024 Instagram from Meta</P>
		</footer>
	</div>
	
	<script src="/js/join_script.js"></script>

</body>
</html>