// DOM 요소들을 선택합니다.
const chatbox = document.getElementById('chatbox');
const imageInput = document.getElementById('imageInput');
const sendBtn = document.getElementById('sendBtn');

// 사용자가 이미지를 선택하고 "Send" 버튼을 클릭했을 때 발생하는 이벤트 처리
sendBtn.addEventListener('click', () => {
    const file = imageInput.files[0];
    if (file) {
        // 사용자가 선택한 이미지를 채팅 박스에 추가
        appendUserMessage('이미지를 전송했습니다.');

        // 파일을 서버로 전송하기 위한 FormData 생성
        const formData = new FormData();
        formData.append('file', file);

        // 서버에 이미지 파일을 전송
        fetch('/predict', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            // 서버로부터의 응답을 채팅 박스에 추가
            appendBotMessage(`질환 예측: ${data.prediction}`);
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }
});

// 사용자가 전송한 메시지를 채팅 박스에 추가하는 함수
function appendUserMessage(message) {
    const messageElement = document.createElement('div');
    messageElement.classList.add('user-message');
    messageElement.textContent = message;
    chatbox.appendChild(messageElement);
}

// 서버로부터 받은 메시지를 채팅 박스에 추가하는 함수
function appendBotMessage(message) {
    const messageElement = document.createElement('div');
    messageElement.classList.add('bot-message');
    messageElement.textContent = message;
    chatbox.appendChild(messageElement);
}