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
    <style>
        .photo-upload-container {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .image-box {
            width: 150px;
            height: 150px;
            border: 2px dashed #ccc;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            background-color: #f0f0f0;
            font-size: 12px;
            color: #666;
        }

        .image-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .image-box input[type="file"] {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }

        .app-container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            box-sizing: border-box;
        }

        .app-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .app-header h1 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }

        .message-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .info-container {
            margin-bottom: 20px;
        }

        .info-container p {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
        }

        .button-container button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .button-container button:focus {
            outline: none;
        }

        .button-container button:disabled {
            background-color: #cccccc;
        }
    </style>
</head>
<body>
<% Tb_login user = (Tb_login) session.getAttribute("user"); %>
<% Tb_pet pet = (Tb_pet)session.getAttribute("upPet"); %>
<% Tb_care care = (Tb_care)session.getAttribute("upPet"); %>

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
                        <option value="male">수</option>
                        <option value="female">암</option>
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
                    imageBox.innerHTML = `<img src="${e.target.result}" alt="미리보기">`;
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