
function kakaoLogin() {
    var kakaoId = "example_kakao_id"; // 실제 Kakao ID를 사용해야 함
    var kakaoEmail = "example_kakao_email@example.com"; // 실제 이메일을 사용해야 함

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
                $("#welcome-message").text(kakaoEmail + "님 환영합니다!").show();
            } else {
                window.location.href = "goJoin.jsp"; // 실패 시 회원가입 페이지로 이동
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error: ", status, error);
        }
    });
}