package com.woori.goController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.woori.dao.CareDAO;
import com.woori.dao.PetDAO;
import com.woori.entity.Tb_care;
import com.woori.entity.Tb_login;
import com.woori.entity.Tb_pet;

@WebServlet("/goUpdate")
public class GoUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Tb_login user = (Tb_login)session.getAttribute("user");
		String email = user.getLogin_email();
		String petName = request.getParameter("name");
		
		PetDAO Pdao = new PetDAO();
		CareDAO Cdao = new CareDAO();
		
		Tb_pet pet = new Tb_pet();
		
		pet.setLogin_email(email);
		pet.setPet_name(petName);
		
		Tb_pet onePet = Pdao.myOnePet(pet);
		int idx = onePet.getPet_idx();
		System.out.println("인덱스"+idx+onePet.getPet_name());
		
		Tb_care care = Cdao.myCare(idx);
		
		
		session.setAttribute("updatePet",onePet);
		session.setAttribute("updateCare", care);
		
		
		String url = "WEB-INF/views/update.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}

}
