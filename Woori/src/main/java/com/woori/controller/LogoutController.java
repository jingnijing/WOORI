package com.woori.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
        session.invalidate();
		
		request.setCharacterEncoding("utf-8");
		String url = "main";
		
		Cookie cookie = new Cookie("JSESSIONID", null); // JSESSIONID 쿠키는 세션에 사용됨
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
		
		response.sendRedirect(url);

	}

}
