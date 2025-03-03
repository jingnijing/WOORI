<%@page import="com.woori.entity.Tb_care"%>
<%@page import="javax.websocket.SendResult"%>
<%@page import="com.woori.entity.Tb_login"%>
<%@page import="com.woori.entity.Tb_pet"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
		
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WOORI_diary</title>
    <style>
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

        .app-header h2 {
            margin: 0;
            font-size: 18px;
            color: #666;
        }

        .message-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .button-container {
            margin-bottom: 20px;
        }

        /* 강아지 이름 버튼들을 귀엽게 스타일링 */
        .button-container button {
            display: block;
            width: 100%;
            padding: 15px;
            margin-bottom: 10px;
            border: none;
            border-radius: 30px;
            background-color: #8554f8;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s, transform 0.3s;
        }

        .button-container button:hover {
            background-color: #a065ac;
            transform: translateY(-2px);
        }

        .button-container button:active {
            background-color: #cea7e6;
            transform: translateY(0);
        }

        .dog-info {
            display: none;
            margin-top: 20px;
        }

        .dog-info p {
            font-weight: bold;
        }

        /* 하단 버튼 컨테이너 스타일 */
        .footer-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        /* 파란색 사각형 버튼 스타일 (호버 및 애니메이션 효과 없음) */
        .footer-buttons button {
            width: 48%;
            padding: 15px;
            border: none;
            border-radius: 8px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
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
    </style>
    
</head>
<body>


    <div class="app-container">
        <header class="app-header">
            <h1>WOORI</h1>
            <h2>우리 반려견 케어노트</h2>
        </header>

        <div class="message-container">
            <p id="message"></p>
        </div>

        <!-- 강아지 버튼들 -->
        <div class="button-container" id="buttonContainer">
            <!-- 여기서 강아지 이름으로 된 버튼들이 추가됩니다 -->
        </div>

        <!-- 강아지 정보 표시 영역 -->
        <div class="dog-info" id="dogInfoDisplay">
        	<div class="photo-upload-container">
				<div class="image-box" id="imageBox1" style="display: none" >
					<img id="displayImg1" />
				</div>
				<div class="image-box" id="imageBox2" style="display: none" >
					<img id="displayImg2"/>
				</div>
				<div class="image-box" id="imageBox3" style="display: none" >
					<img id="displayImg3"/>
				</div>
			</div>
            <p><strong>이름:</strong> <span id="displayDogName"></span></p>
            <p><strong>성별:</strong> <span id="displayDogGender"></span></p>
            <p><strong>몸무게:</strong> <span id="displayDogWeight"></span> kg</p>
            <p><strong>생일:</strong> <span id="displayDogBirthday"></span></p>
            <p><strong>입양일:</strong> <span id="displayDogAdoptionDate"></span></p>
            <p><strong>알러지:</strong> <span id="displayCareInfo1"></span></p>
            <p><strong>질병:</strong> <span id="displayCareInfo2"></span></p>
            <p><strong>식사량:</strong> <span id="displayCareInfo3"></span></p>
            <p><strong>특이사항:</strong> <span id="displaySpecialNotes"></span></p>
            <button id=deleteButton>수정</button>
            <button id=updateButton>삭제</button>
        </div>

        <!-- 하단 버튼 컨테이너 -->
        <div class="footer-buttons">
            <button id="noteBtn">정보입력</button>
            <button id="backBtn">뒤로가기</button>
        </div>
    </div>

    <script>
    
    document.addEventListener('DOMContentLoaded', function() {
        var deleteButton = document.getElementById('deleteButton');
        deleteButton.addEventListener('click', promptToDelete);
    });
    
    document.addEventListener('DOMContentLoaded', function() {
        var updateButton = document.getElementById('updateButton');
        updateButton.addEventListener('click', promptToUpdate);
    });
    
    
    
    function formatDate(dateTimeString) {
        // 공백을 기준으로 날짜와 시간을 분리하여 배열로 만든다
        const datePart = dateTimeString.split(' ')[0];  // YYYY-MM-DD만 추출
        const dateParts = datePart.split('-');  // '-'를 기준으로 연도, 월, 일을 분리
        const year = dateParts[0];
        const month = dateParts[1];
        const day = dateParts[2];
        const result = year+"년 "+month+"월 "+day+"일"
        // '년 월 일' 형식으로 변환
        return result;
    }
    
    <% 
    List<Tb_pet> pets = (List<Tb_pet>) session.getAttribute("pet");
    List<Tb_care> cares = (List<Tb_care>) session.getAttribute("care");
%>

let currentlyDisplayedDog = null;

const dogs = [
    <% for (int i = 0;i<pets.size();i++) { %>
    {
    	 name: '<%=pets.get(i) != null ?  pets.get(i).getPet_name() : "None" %>',
         gender: '<%=pets.get(i) != null ?   pets.get(i).getPet_gender() : "None"  %>',
         weight: '<%=pets.get(i) != null ?   pets.get(i).getPet_weight() : "None"  %>',
         birthday: '<%=pets.get(i) != null ?   pets.get(i).getPet_birthdate() : "None"  %>',
         adoptionDate: '<%=pets.get(i) != null ?   pets.get(i).getAdopted_at() : "None"  %>',
         img1: '<%=pets.get(i) != null ?   pets.get(i).getPet_img1() : "None"  %>',
         img2: '<%=pets.get(i) != null ?   pets.get(i).getPet_img2() : "None"  %>',
         img3: '<%=pets.get(i) != null ?   pets.get(i).getPet_img3() : "None"  %>',
        careInfo1: '<%=cares.get(i).getPet_alergy() != null ?  cares.get(i).getPet_alergy() : "" %>',
        careInfo2: '<%=cares.get(i).getPet_disease() != null ?  cares.get(i).getPet_disease() : ""%>',
        careInfo3: '<%=cares.get(i).getPet_food() != null ?  cares.get(i).getPet_food() : ""%>',
        specialNotes: '<%= cares.get(i).getPet_etc() != null ? cares.get(i).getPet_etc() : "" %>'
    },
    <% } %>
];

        const buttonContainer = document.getElementById('buttonContainer');
        const dogInfoDisplay = document.getElementById('dogInfoDisplay');

        // 강아지 이름으로 버튼 생성
        dogs.forEach((dog) => {
            const button = document.createElement('button');
            button.textContent = dog.name;
            button.addEventListener('click', function() {
                // 만약 같은 강아지 이름이 다시 클릭되면 정보 숨김
                if (currentlyDisplayedDog === dog.name) {
                    dogInfoDisplay.style.display = 'none';
                    currentlyDisplayedDog = null;
                } else {
                    showDogInfo(dog);
                }
            });
            buttonContainer.appendChild(button);
        });

        // 강아지 정보를 화면에 표시하는 함수
        function showDogInfo(dog) {
        	// 강아지 정보 표시 섹션 보이기
            dogInfoDisplay.style.display = 'block';

            // 현재 표시 중인 강아지 정보로 설정
            currentlyDisplayedDog = dog.name;
            
            document.getElementById('displayDogName').textContent = dog.name;
            document.getElementById('displayDogGender').textContent = dog.gender === 'male' ? '수컷' : '암컷';
            document.getElementById('displayDogWeight').textContent = dog.weight;
            document.getElementById('displayDogBirthday').textContent = formatDate(dog.birthday);
            document.getElementById('displayDogAdoptionDate').textContent = formatDate(dog.adoptionDate);
            document.getElementById('displayCareInfo1').textContent = dog.careInfo1;
            document.getElementById('displayCareInfo2').textContent = dog.careInfo2;
            document.getElementById('displayCareInfo3').textContent = dog.careInfo3;
            document.getElementById('displaySpecialNotes').textContent = dog.specialNotes;
            if(dog.img1!="null"){
            	disImg1 = document.getElementById('displayImg1')
            	disImg1.src = "save/"+dog.img1;
            	imgBox1 = document.getElementById('imageBox1')
            	imgBox1.style.display = "block";
            	console.log(dog.img1)
            }else{
            	imgBox1.style.display = "none";
            }
            if(dog.img2!="null"){
            	disImg2 = document.getElementById('displayImg2')
            	disImg2.src = "save/"+dog.img2;
            	imgBox2 = document.getElementById('imageBox2')
            	imgBox2.style.display = "block";
            }else{
            	imgBox2.style.display = "none";
            }
            if(dog.img3!="null"){
            	disImg3 = document.getElementById('displayImg3')
            	disImg3.src = "save/"+dog.img3;
            	imgBox3 = document.getElementById('imageBox3')
            	imgBox3.style.display = "block";
            }else{
            	imgBox3.style.display = "none";
            }
            
        }

        // 정보입력 버튼 클릭 시 woori_note.html로 이동
        document.getElementById('noteBtn').addEventListener('click', function() {
            window.location.href = 'goNewPet';
        });

        // 뒤로가기 버튼 클릭 시 이전 페이지로 이동
        document.getElementById('backBtn').addEventListener('click', function() {
        	window.location.href = 'main';
        });
        
        function promptToUpdate() {
            const dogName = prompt("삭제할 강아지의 이름을 입력하세요:");
            if (dogName) {
            	 let encDog = encodeURIComponent(dogName);
            	 const isDuplicate = dogs.some(dog => dog.name == dogName);
            	 if (isDuplicate) {
            		    alert("강아지를 삭제합니다");
               			 window.location.href = "petDelete?name="+encDog;
            		} else {
            		    alert("일치하는 이름이 없습니다");
            		}
            }
        }
        
        function promptToDelete() {
            const dogName = prompt("수정할 강아지의 이름을 입력하세요:");
            if (dogName) {
            	 let encDog = encodeURIComponent(dogName);
            	 const isDuplicate = dogs.some(dog => dog.name == dogName);
            	 if (isDuplicate) {
            		    alert("강아지정보를 수정합니다");
               			 window.location.href = "goUpdate?name="+encDog;
            		} else {
            		    alert("일치하는 이름이 없습니다");
            		}
            }
        }
        
    </script>
</body>
</html>
				
				
</body>
</html>