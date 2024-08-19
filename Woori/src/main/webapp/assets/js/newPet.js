// newPet.js

// 세션에서 로그인 정보 확인
const user = JSON.parse(sessionStorage.getItem('user'));  // 'user' 객체를 세션에서 가져와 파싱

const messageElement = document.getElementById('message');
const saveBtn = document.getElementById('saveBtn');
const backBtn = document.getElementById('backBtn');

if (user && user.login_nick) {
    // 사용자가 로그인 되어 있는 경우 환영 메시지 표시
    messageElement.textContent = `${user.login_nick}님, 반려견 케어노트에 오신 것을 환영합니다.`;
} else {
    // 로그인되지 않은 경우 메시지 표시 및 저장 버튼 비활성화
    messageElement.textContent = "로그인이 필요합니다.";
    saveBtn.disabled = true;
}

// 저장 버튼 클릭 시 실행되는 함수
saveBtn.addEventListener('click', function() {
    // 입력된 반려견 정보를 가져오기
    const dogName = document.getElementById('dogName').value.trim();
    const dogGender = document.getElementById('dogGender').value;
    const dogWeight = document.getElementById('dogWeight').value.trim();
    const dogBirthday = document.getElementById('dogBirthday').value;
    const dogAdoptionDate = document.getElementById('dogAdoptionDate').value;
    const careInfo = document.getElementById('careInfo').value.trim();

    // 업로드된 사진 파일 경로를 가져오기 (서버 경로)
    const photo1 = document.getElementById('photo1').files[0] ? '/uploads/' + document.getElementById('photo1').files[0].name : '';
    const photo2 = document.getElementById('photo2').files[0] ? '/uploads/' + document.getElementById('photo2').files[0].name : '';
    const photo3 = document.getElementById('photo3').files[0] ? '/uploads/' + document.getElementById('photo3').files[0].name : '';

    // 필수 입력 필드 확인
    if (dogName && dogWeight && dogBirthday && dogAdoptionDate) {
        alert('반려견 정보와 노트가 저장되었습니다!');
        
        // 서버로 데이터를 전송하기 위해 폼 데이터를 생성
        const formData = new FormData();
        formData.append('dogName', dogName);
        formData.append('dogGender', dogGender);
        formData.append('dogWeight', dogWeight);
        formData.append('dogBirthday', dogBirthday);
        formData.append('dogAdoptionDate', dogAdoptionDate);
        formData.append('careInfo', careInfo);
        formData.append('photo1', photo1);
        formData.append('photo2', photo2);
        formData.append('photo3', photo3);

        // PetController로 데이터를 POST 방식으로 전송
        fetch('/PetController', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('반려견 정보가 성공적으로 저장되었습니다.');
            } else {
                alert('저장 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    } else {
        // 필수 입력 사항이 누락된 경우 경고 메시지 표시
        alert('필수 정보를 모두 입력해주세요.');
    }
});

// 뒤로 가기 버튼 클릭 시 메인 페이지로 이동
backBtn.addEventListener('click', function() {
    window.location.href = 'main';
});
