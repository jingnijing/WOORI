<%@page import="com.woori.entity.Tb_care"%>
<%@page import="com.woori.entity.Tb_pet"%>
<%@page import="com.woori.entity.Tb_login"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WOORI_note</title>
    <link rel="stylesheet" href="assets/css/note.css">
</head>
<body>
<% Tb_login user = (Tb_login) session.getAttribute("user"); %>
<% Tb_pet pet = (Tb_pet)session.getAttribute("updatePet"); %>
<% Tb_care care = (Tb_care)session.getAttribute("updatecare"); %>


    <div class="app-container">
        <header class="app-header">
            <h1>WOORI</h1>
            <h2>우리 반려견 케어를 위한 최고의 선택</h2>
        </header>

        <div class="message-container">
            <p id="message"><%=user.getLogin_nick() %>님, 반려견 케어노트에 오신 것을 환영합니다.</p>
        </div>

        <!-- 사진 업로드 섹션 -->
        <form id="dogInfoForm" action="pet" method="post" enctype="multipart/form-data">
            <div class="photo-upload-container">
                <div class="image-box" id="imageBox1">
                    이미지를 추가하세요 (+1)
                    <input type="file" id="photo1" name="photo1" accept="image/*">
                </div>
                <div class="image-box" id="imageBox2">
                    이미지를 추가하세요 (+1)
                    <input type="file" id="photo2" name="photo2" accept="image/*">
                </div>
                <div class="image-box" id="imageBox3">
                    이미지를 추가하세요 (+1)
                    <input type="file" id="photo3" name="photo3" accept="image/*">
                </div>
            </div>
            
            <!-- 반려견 정보 입력 섹션 -->
            <div class="info-container">
                <p>반려견 정보를 입력하세요</p>
                <div class="form-group">
                    <label for="dogName">이름:</label>
                    <input type="text" id="dogName" name="dogName" required>
                </div>
                <div class="form-group">
                    <label for="dogGender">성별:</label>
                    <select id="dogGender" name="dogGender">
                        <option value="male">수컷</option>
                        <option value="female">암컷</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="dogWeight">몸무게(kg):</label>
                    <input type="number" id="dogWeight" name="dogWeight" step="0.1" required>
                </div>
                <div class="form-group">
                    <label for="dogBirthday">생일:</label>
                    <input type="date" id="dogBirthday" name="dogBirthday" required>
                </div>
                <div class="form-group">
                    <label for="dogAdoptionDate">입양일:</label>
                    <input type="date" id="dogAdoptionDate" name="dogAdoptionDate" required>
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

    <script>
        // 로그인 상태 및 닉네임 확인
        const isLoggedIn = sessionStorage.getItem('isLoggedIn') === 'true';
        const nickname = sessionStorage.getItem('nickname');

        const backBtn = document.getElementById('backBtn');

        

        // 파일 업로드 시 미리보기 설정
        function previewImage(input, imageBoxId) {
            const file = input.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const imageBox = document.getElementById(imageBoxId);
                    imageBox.innerHTML =  imageBox.innerHTML = '<img src="' + e.target.result + '" alt="미리보기">';
                };
                reader.readAsDataURL(file);
            }
        }

        // 각 이미지 업로드 박스에 이벤트 추가
        document.getElementById('photo1').addEventListener('change', function() {
            previewImage(this, 'imageBox1');
        });
        document.getElementById('photo2').addEventListener('change', function() {
            previewImage(this, 'imageBox2');
        });
        document.getElementById('photo3').addEventListener('change', function() {
            previewImage(this, 'imageBox3');
        });

        // 뒤로 가기 버튼 클릭 시 메인 페이지로 이동
        backBtn.addEventListener('click', function() {
            window.location.href = 'dairy';
        });
    </script>
</body>
</html>