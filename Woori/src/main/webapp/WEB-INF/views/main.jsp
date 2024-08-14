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
<%Tb_login user = (Tb_login)session.getAttribute("user");%>
<div id="login-section">
    <a href="javascript:kakaoLogin()">
        <img src="images/kakao.png" width="222" alt="카카오 로그인 버튼" />
    </a>
</div>

<p id="welcome-message" style="display:none;">
<%if(user!=null){ %>
<%=user.getLogin_nick()%>님 환영합니다!
<%} %>
</p>

<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="assets/js/kakao.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


</body>
</html>
