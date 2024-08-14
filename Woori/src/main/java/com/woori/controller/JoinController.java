package com.woori.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.woori.dao.LoginDAO;
import com.woori.entity.Tb_login;

@WebServlet("/join")
public class JoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String nick = request.getParameter("nick");
		
		HttpSession session = request.getSession();
		Tb_login user = (Tb_login)session.getAttribute("user");
		user.setLogin_nick(nick);
		System.out.println(user.getId_key()+user.getLogin_nick());
		LoginDAO dao = new LoginDAO();
		
		int cnt = dao.join(user);
		
		if(cnt>0) {
			System.out.println("회원가입 성공");
			session.setAttribute("user", user);
		}else {
			System.out.println("회원가입 실패");
		}
		
		String url = "main";
		response.sendRedirect(url);
	}

}
