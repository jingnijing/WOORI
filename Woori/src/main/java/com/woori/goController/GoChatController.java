package com.woori.goController;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.Socket;
import java.net.URL;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;

import com.woori.entity.Tb_login;

@WebServlet("/goChat")
public class GoChatController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Tb_login user = (Tb_login)session.getAttribute("user");
		String userEmail = user.getLogin_email();
		
		// Python 서버로 이메일을 전송
		try {
			
			URL url = new URL("http://localhost:5000/store_email");  // Python 서버 URL
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json; utf-8");
			conn.setRequestProperty("Accept", "application/json");
			conn.setDoOutput(true);

			// JSON 데이터 생성
			String jsonInputString = "{\"email\": \"" + userEmail + "\"}";
			System.out.println(jsonInputString);

			// 데이터 전송
			try(OutputStream os = conn.getOutputStream()) {
				byte[] input = jsonInputString.getBytes("utf-8");
				os.write(input, 0, input.length);           
			}

			// 응답 확인
			int code = conn.getResponseCode();
			System.out.println("Response Code : " + code);
			
			if (code == 200) {
				// 성공적으로 응답을 받으면 처리
				System.out.println("Successfully sent email and option to Python server.");
				System.out.println(jsonInputString);
				// 리다이렉트 코드 추가: 성공적으로 데이터를 전송한 후, Python 서버의 chat.html로 리다이렉트
				System.out.println("Redirecting to http://localhost:5000/goChat");
				response.sendRedirect("http://localhost:5000/goChat");
			} else {
				// 에러 처리
				System.out.println("Failed to send data to Python server.");
				response.getWriter().write("Failed to send data to Python server.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("Exception occurred while sending data to Python server.");
		}
	}
}


