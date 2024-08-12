<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
  integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
<script> Kakao.init('8d3b982cf5a9e191f1b088d5ad696651');</script>
	<a id="kakao-login-btn" href="javascript:loginWithKakao()">
  <img src="images/kakao.png" width="222"
    alt="카카오 로그인 버튼" />
</a>
<p id="token-result"></p>
	
	
	
	<script src="assets/js/kakao.js"></script>
</body>
</html>