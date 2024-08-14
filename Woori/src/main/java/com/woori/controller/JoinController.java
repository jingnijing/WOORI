package com.woori.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.woori.dao.LoginDAO;
import com.woori.entity.Tb_login;


@WebServlet("/join")
public class JoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String nick = request.getParameter("nick");
		Tb_login login = (Tb_login)request.getAttribute("join");
		String id = login.getId_key();
		String email = login.getLogin_email();
		String login_src = "Kakao";
//		
//		login.setLogin_nick(nick);
//		login.setLogin_src(login_src);
//		
//		LoginDAO dao = new LoginDAO();
//		dao.join(login);
		
		System.out.println(nick + id + email + login_src);
		
	}

}
