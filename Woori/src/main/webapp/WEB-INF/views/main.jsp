<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main Page</title>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WOORI_main</title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

	<script type="text/javascript"
		src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="assets/js/kakao.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
	 function logout() {
         window.location.href = 'logout';  // 로그아웃 페이지 경로로 이동
     }
	</script>
	<div class="app-container">
		<header class="app-header">
			<h2>우리 반려견 케어를 위한 최고의 선택</h2>
			<h1>WOORI</h1>
		</header>

		<!-- 카카오 로그인 버튼 -->
		<div id="login-section" >
			<a href="javascript:kakaoLogin()"> <img src="images/kakao.png"
				width="40" alt="카카오 로그인 버튼" />
			</a>
		</div>
			<p id="welcome-message" style="display: none;"></p>
			<button id="logoutBtn" style="display: none; align: center;" onclick="logout()">로그아웃</button>
			
		<div class="image-section">
			<div class="image-box">
			
				<a href="dairy"> <img src="images/note.jpg" alt="note">
					<div class="text-overlay">
						<p>우리 강아지 건강부터 귀여운 모습까지 한 번에 챙기기</p>
					</div>
				</a>
				
			</div>
			<div class="image-box">
				<a href="goChat"> <img src="images/chatbot.png" alt="chatbot">
					<div class="text-overlay">
						<p>딥러닝 기술을 활용한 AI진단으로 우리 강아지 더욱 살뜰하게 보살피기</p>
					</div>
				</a>
			</div>
		</div>
	</div>


</body>
</html>
