<%@page import="java.io.Console"%>
<%@page import="com.woori.entity.Tb_login"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html">
<title>WOORI_note</title>
<link rel="stylesheet" href="assets/css/note.css">
</head>
<body>

<script src="assets/js/check.js"></script>

	<%
	Tb_login user = (Tb_login) session.getAttribute("user");
	%>

	<div class="app-container">
		<header class="app-header">
			<h1>WOORI</h1>
			<h2>우리 반려견 케어를 위한 최고의 선택</h2>
		</header>

		<div class="message-container">
			<p id="message"><%=user.getLogin_nick()%>님, 반려견 케어노트에 오신 것을
				환영합니다.
			</p>
		</div>

		<!-- 사진 업로드 섹션 -->
		<form id="dogInfoForm" action="pet" method="post"
			enctype="multipart/form-data">
			<div class="photo-upload-container">
				<div class="image-box" id="imageBox1">
					<img id="preview1" style="display: none" />
					<input type="file"
						onchange="readURL1(this);" name="img1" accept="image/*">
				</div>
				<div class="image-box" id="imageBox2">
					<img id="preview2" style="display: none" /> <input type="file"
						onchange="readURL2(this);" name="img2" accept="image/*">
				</div>
				<div class="image-box" id="imageBox3">
					<img id="preview3" style="display: none" /> <input type="file"
						onchange="readURL3(this);" name="img3" accept="image/*">
				</div>
			</div>
			<!-- 반려견 정보 입력 섹션 -->
			<div class="info-container">
				<p>반려견 정보를 입력하세요</p>
				<div class="form-group">
					<label for="dogName">이름:</label> <input type="text" id="dogName"
						name="dogName" required>
						<p id=result>중복</p>
				</div>
				<div class="form-group">
					<label for="dogGender">성별:</label> <select id="dogGender"
						name="dogGender">
						<option value="male">수컷</option>
						<option value="female">암컷</option>
					</select>
				</div>
				<div class="form-group">
					<label for="dogWeight">몸무게(kg):</label> <input type="number"
						id="dogWeight" name="dogWeight" step="0.1" required>
				</div>
				<div class="form-group">
					<label for="dogBirthday">생일:</label> <input type="date"
						id="dogBirthday" name="dogBirthday" required>
				</div>
				<div class="form-group">
					<label for="dogAdoptionDate">입양일:</label> <input type="date"
						id="dogAdoptionDate" name="dogAdoptionDate" required>
				</div>
				<div class="form-group">
					<label for="careInfo1">알러지:</label>
					<textarea id="careInfo1" name="allergy" rows="3"></textarea>
				</div>
				<div class="form-group">
					<label for="careInfo2">질병:</label>
					<textarea id="careInfo2" name="disease" rows="3"></textarea>
				</div>
				<div class="form-group">
					<label for="careInfo3">식사량:</label>
					<textarea id="careInfo3" name="food" rows="3"></textarea>
				</div>
				<div class="form-group">
					<label for="specialNotes">특이사항:</label>
					<textarea id="specialNotes" name="etc" rows="3"></textarea>
				</div>
			</div>

			<div class="button-container">
				<button type="button" id="backBtn">뒤로 가기</button>
				<button type="submit" id="saveBtn">저장</button>
			</div>
		</form>
	</div>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script>
        // 로그인 상태 및 닉네임 확인

        const backBtn = document.getElementById('backBtn');

		<!--미리보기 -->
        function readURL1(input) {
        	if (input.files && input.files[0]) {
        	    var reader = new FileReader();
        	    reader.onload = function(e) {
        	    	var preview = document.getElementById('preview1');
                	preview.src = e.target.result;
                	preview.style.display = "block"; // 요소를 다시 보이게 설정
        	    };
        	    reader.readAsDataURL(input.files[0]);
        	  } else {
        	    document.getElementById('preview1').src = "";
        	  }
        	}
        
        function readURL2(input) {
      	  if (input.files && input.files[0]) {
      	    var reader = new FileReader();
      	    reader.onload = function(e) {
      	    	var preview = document.getElementById('preview2');
        		preview.src = e.target.result;
        		preview.style.display = "block"; // 요소를 다시 보이게 설정
      	    };
      	    reader.readAsDataURL(input.files[0]);
      	  } else {
      	    document.getElementById('preview2').src = "";
      	  }
      	}
        
        function readURL3(input) {
      	  if (input.files && input.files[0]) {
      	    var reader = new FileReader();
      	    reader.onload = function(e) {
      	    	var preview = document.getElementById('preview3');
            	preview.src = e.target.result;
            	preview.style.display = "block"; // 요소를 다시 보이게 설정
      	    };
      	    reader.readAsDataURL(input.files[0]);
      	  } else {
      	    document.getElementById('preview3').src = "";
      	  }
      	}

        
        // 뒤로 가기 버튼 클릭 시 메인 페이지로 이동
        backBtn.addEventListener('click', function() {
            window.location.href = 'dairy';
        });
    </script>
</body>
</html>