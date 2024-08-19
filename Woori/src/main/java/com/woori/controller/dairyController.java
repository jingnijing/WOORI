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
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Tb_login user = (Tb_login)session.getAttribute("user");
		System.out.println(user.getLogin_email());
		
		PetDAO dao = new PetDAO();
		List<Tb_pet> pet = dao.my_pet(user);
		
		for(Tb_pet x : pet) {
			System.out.println(x.getPet_name());
		}
		
		String url = "";
		if(pet!=null) {
			session.setAttribute("pet", pet);
			url = "WEB-INF/views/dairy.jsp";
		}else {
			url = "WEB-INF/views/newPet.jsp";
		}


		
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
		
	}

}
