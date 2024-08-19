<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WOORI_note</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <div class="app-container">
        <header class="app-header">
            <h2>우리 반려견 케어를 위한 최고의 선택</h2>
            <h1>WOORI</h1>
        </header>

        <div class="message-container">
            <p id="message"></p>
        </div>

        <!-- 사진 업로드 섹션 -->
        <div class="photo-upload-container">
            <p>반려견의 사진을 업로드하세요 (최대 3장):</p>
            <input type="file" id="photo1" accept="image/*">
            <input type="file" id="photo2" accept="image/*">
            <input type="file" id="photo3" accept="image/*">
        </div>
        
        <!-- 반려견 정보 입력 섹션 -->
        <div class="info-container">
            <p>반려견 정보를 입력하세요:</p>
            <div class="form-group">
                <label for="dogName">이름:</label>
                <input type="text" id="dogName" name="dogName">
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
                <input type="number" id="dogWeight" name="dogWeight" step="0.1">
            </div>
            <div class="form-group">
                <label for="dogBirthday">생일:</label>
                <input type="date" id="dogBirthday" name="dogBirthday">
            </div>
            <div class="form-group">
                <label for="dogAdoptionDate">입양일:</label>
                <input type="date" id="dogAdoptionDate" name="dogAdoptionDate">
            </div>
            <div class="form-group">
                <label for="careInfo">돌봄정보:</label>
                <textarea id="careInfo" name="careInfo" rows="3"></textarea>
            </div>
            
        </div>

        <div class="button-container">
            <button id="saveBtn">저장</button>
            <button id="backBtn">뒤로 가기</button>
        </div>
    </div>

    <!-- 자바스크립트 파일 연결 -->
    <script src="assets/js/newPet.js"></script>
</body>
</html>
