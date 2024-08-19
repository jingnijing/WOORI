<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="app-container">
        <header class="app-header">
            <h2>우리 반려견 케어를 위한 최고의 선택</h2>
            <h1>WOORI</h1>
        </header>

        <div class="message-container">
            <p>안녕하세요<br>반려견 케어노트<br>WOORI에 오신 것을 환영합니다.</p>
        </div>

            <form action="join">
        <div class="form-container" align="center">
            <input type="text" id="nickname" name="nick" placeholder="사용하실 별명(nick)을 입력하세요">
        </div>

        <div class="button-container">
            <button id="cancelBtn">CANCEL</button>
            <button type="submit">OK!</button>
        </div>
        </form>
    </div>
	
	
<script>
        // CANCEL 버튼 클릭 시 woori_main.html로 이동
        document.getElementById('cancelBtn').addEventListener('click', function() {
            window.location.href = 'main';
        });
        </script>
</body>
</html>
