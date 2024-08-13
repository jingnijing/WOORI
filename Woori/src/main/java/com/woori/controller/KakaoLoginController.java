package com.woori.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.woori.dao.LoginDAO;
import com.woori.entity.Tb_login;


@WebServlet("/kakaoLogin")
public class KakaoLoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	   // 1. POST로 전달된 사용자 정보 받기
        String kakaoId = request.getParameter("kakaoId");
        String kakaoEmail = request.getParameter("kakaoEmail");

        // 2. 받은 정보를 사용하여 필요한 작업 수행 (예: 데이터베이스 저장, 세션 생성 등)
        System.out.println("Kakao ID: " + kakaoId + ", Email: " + kakaoEmail);

        Tb_login login = new Tb_login();
        login.setId_key(kakaoId);
        login.setLogin_email(kakaoEmail);
        
        LoginDAO dao = new LoginDAO();
        Tb_login res = dao.login(login);
        if(res != null) {
        	// 세션 생성
			System.out.println("login success");
            request.getSession().setAttribute("User", res);
            response.sendRedirect("/woori/main.jsp");
        }else {
        	System.out.println("login fail");
            request.getSession().setAttribute("User", login);
        	response.sendRedirect("join");
        }
        
        
}}