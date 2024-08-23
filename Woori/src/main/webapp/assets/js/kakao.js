// 1. 카카오 SDK 초기화
Kakao.init('8d3b982cf5a9e191f1b088d5ad696651');

var kakaoId = "";
var kakaoEmail = "";
function kakaoLogin() {
	// 2. 카카오 로그인 실행
	Kakao.Auth.login({
		success: function(response) {
			// 3. 로그인 성공 후 사용자 정보 요청
			Kakao.API.request({
				url: '/v2/user/me',
				success: function(response) {
					// 4. 필요한 사용자 정보 추출
					kakaoId = response.id;  // 고유한 키값 (카카오 ID)
					kakaoEmail = response.kakao_account.email;  // 이메일 정보
					$.ajax({
						type: "POST",
						url: "kakaoLogin",
						data: {
							kakaoId: kakaoId,
							kakaoEmail: kakaoEmail
						},
						dataType: "json",
						success: function(response) {
							if (response === "success") {
								$("#login-section").hide();

								$("#welcome-message").html("환영합니다!<br>Woori 펫케어서비스 입니다!").show();
								$("#logoutBtn").show();
							} else {
								window.location.href = "goJoin"; // 실패 시 회원가입 페이지로 이동
							}
						},
						error: function(xhr, status, error) {
							console.error("AJAX Error: ", status, error);
						}
					});
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