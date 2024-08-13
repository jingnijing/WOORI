// 1. 카카오 SDK 초기화
    Kakao.init('8d3b982cf5a9e191f1b088d5ad696651');

    function kakaoLogin() {
        // 2. 카카오 로그인 실행
        Kakao.Auth.login({
            success: function(response) {
                // 3. 로그인 성공 후 사용자 정보 요청
                Kakao.API.request({
                    url: '/v2/user/me',
                    success: function(response) {
                        // 4. 필요한 사용자 정보 추출
                        var kakaoId = response.id;  // 고유한 키값 (카카오 ID)
                        var kakaoEmail = response.kakao_account.email;  // 이메일 정보

                        // 5. 서블릿으로 사용자 정보 전송 (AJAX 사용)
                        var xhr = new XMLHttpRequest();
                        xhr.open('POST', '/Woori/kakaoLogin', true);
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        xhr.onreadystatechange = function() {
                            if (xhr.readyState === 4 && xhr.status === 200) {
                                // 서버 응답 처리 (필요시)
                                console.log('Response from server:', xhr.responseText);
                            }
                        };
                        xhr.send('kakaoId=' + kakaoId + '&kakaoEmail=' + encodeURIComponent(kakaoEmail));
                    },
                    fail: function(error) {
                        alert(JSON.stringify(error));  // 오류 발생 시 알림으로 출력
                    },
                })
            },
            fail: function(error) {
                alert(JSON.stringify(error));  // 로그인 실패 시 알림으로 출력
            },
        })
    }