package com.woori.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.woori.dao.PetDAO;
import com.woori.entity.Tb_login;
import com.woori.entity.Tb_pet;

@WebServlet("/dairy")
public class dairyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PetDAO dao = new PetDAO();
		Tb_login user = (Tb_login)request.getAttribute("user");
		List<Tb_pet> pet = dao.my_pet(user);

		HttpSession session = request.getSession();
		session.setAttribute("pet", pet);
		
		String url = "WEB-INF/views/dairy.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
		
	}

}
