document.getElementById('sendBtn').addEventListener('click', function() {
        var fileInput = document.getElementById('imageInput');
        var file = fileInput.files[0];
        if (!file) {
            alert("Please select an image file first.");
            return;
        }

        var formData = new FormData();
        formData.append('image', file);

        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/chat', true);  // 수정된 URL

        xhr.onload = function() {
            if (xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);

                // 사용자가 보낸 이미지 표시
                addMessageToChatBox(file.name, 'user-message');

                // 서버의 응답 메시지 표시
                addMessageToChatBox(response.answer, 'bot-message');
                
                // 파일 입력 필드 초기화
                fileInput.value = '';
            } else {
                alert('Failed to send image.');
            }
        };

        xhr.send(formData);
    });

    function addMessageToChatBox(message, className) {
        var chatBox = document.getElementById('chatBox');
        var messageElement = document.createElement('div');
        messageElement.className = 'chat-message ' + className;
        messageElement.textContent = message;
        chatBox.appendChild(messageElement);
        chatBox.scrollTop = chatBox.scrollHeight;
    }