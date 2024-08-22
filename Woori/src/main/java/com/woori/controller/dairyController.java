package com.woori.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

@WebServlet("/dairy")
public class dairyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Tb_login user = (Tb_login) session.getAttribute("user");
		
		 if (user == null || user.getLogin_email() == null || user.getLogin_email().isEmpty()) {
	            // 로그인이 되지 않은 경우 로그인 페이지로 리다이렉트
	            response.sendRedirect("main");
	            return;  // 이후의 코드를 실행하지 않도록 리턴
	        }
		
		System.out.println(user.getLogin_email());

			String url = "";
			PetDAO dao = new PetDAO();
			CareDAO Caredao = new CareDAO();
			
			List<Tb_pet> pet = dao.my_pet(user);
			List<Tb_care> care =  new ArrayList<Tb_care>();
			Tb_care c;
			for (Tb_pet x : pet) {
				int i = x.getPet_idx();
				c = Caredao.myCare(i);
				care.add(c);
				System.out.println("펫이름 : "+x.getPet_name());
			}
				session.setAttribute("pet", pet);
				session.setAttribute("care", care);
				
				
				url = "WEB-INF/views/dairy.jsp";
		
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);

	}
}
