package com.woori.restcontroller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.woori.dao.PetDAO;
import com.woori.entity.Tb_login;
import com.woori.entity.Tb_pet;



@WebServlet("/check")
public class checkController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 데이터수집
				request.setCharacterEncoding("utf-8");
				
				HttpSession session = request.getSession();
				Tb_login user = (Tb_login)session.getAttribute("user");
				
				String petName = request.getParameter("pet");
				String email = user.getLogin_email();
				
				PetDAO dao = new PetDAO();
				Tb_pet pet = new Tb_pet();
				
				
				pet.setLogin_email(email);
				pet.setPet_name(petName);
				
				// 2. 기능 실행
				Tb_pet chkPet = dao.myOnePet(pet);
				
				String result = "";
				if(chkPet==null) {
					result = "true";
				}else {
					result = "false";
				}
				System.out.println(result);
				
				// 3. 데이터 응답
				response.setContentType("text/plain; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print(result);
				
				
				
			
		
	}

}
