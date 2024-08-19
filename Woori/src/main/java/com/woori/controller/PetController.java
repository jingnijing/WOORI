package com.woori.controller;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.woori.dao.PetDAO;
import com.woori.entity.Tb_pet;


@WebServlet("/PetController")
public class PetController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 String dogName = request.getParameter("dogName");
	        String dogGender = request.getParameter("dogGender");
	        double dogWeight = Integer.parseInt(request.getParameter("dogWeight"));
	        String dogBirthday = request.getParameter("dogBirthday");
	        String dogAdoptionDate = request.getParameter("dogAdoptionDate");
	        String careInfo = request.getParameter("careInfo");

	        // 파일 데이터 받기 (photo1, photo2, photo3)
	        Part photo1 = request.getPart("photo1");
	        Part photo2 = request.getPart("photo2");
	        Part photo3 = request.getPart("photo3");

	        // 파일을 InputStream으로 읽거나, 파일 시스템에 저장할 수 있음
	        InputStream photo1Content = photo1.getInputStream();
	        InputStream photo2Content = photo2.getInputStream();
	        InputStream photo3Content = photo3.getInputStream();
	        
	        PetDAO dao = new PetDAO();
	        
	        Tb_pet pet = new Tb_pet();
	        pet.setPet_name(dogName);
	        pet.setPet_gender(dogGender);
	        pet.setPet_weight(dogWeight);
	        pet.setPet_birthdate(dogBirthday);
	        pet.setAdopted_at(careInfo);
	        
	        
	        
	        dao.new_pet(pet);
	        
	        
	}

}
