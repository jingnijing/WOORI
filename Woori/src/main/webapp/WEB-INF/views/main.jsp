<%@ page import="com.woori.entity.Tb_login" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main Page</title>
</head>
<body>
<div id="login-section">
    <a href="javascript:kakaoLogin()">
        <img src="images/kakao.png" width="222" alt="카카오 로그인 버튼" />
    </a>
		<p id="welcome-message" style="display: none;"></p>
	</div>


<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="assets/js/kakao.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


</body>
</html>
