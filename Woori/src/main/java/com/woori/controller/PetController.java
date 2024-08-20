package com.woori.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.woori.dao.CareDAO;
import com.woori.dao.PetDAO;
import com.woori.entity.Tb_care;
import com.woori.entity.Tb_login;
import com.woori.entity.Tb_pet;


@WebServlet("/pet")
public class PetController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 데이터 수집
				// (1) 파일 수집에 필요한 라이브러리 추가 >> COS
				// (2) 저장할 폴더 만들기
				// (3) 필요한 정보들을 변수에 담아 두기
				// 저장 경로
				String savePath = request.getServletContext().getRealPath("save");
		        // 파일 사이즈 제한
				int maxSize = 1024 * 1024 * 10; // 10MB
				// 인코딩 방식
				String encoding = "UTF-8";
				
				// (4) MultipartRequest
				MultipartRequest multi = new MultipartRequest(
						request, // request 객체
						savePath, // 저장경로
						maxSize, // 파일최대크기
						encoding, // 인코딩방식
						new DefaultFileRenamePolicy() //중복 파일명 발생시 자동으로 이름 변경
						);
		        
				// ※ csrf : 사이트마다 토큰을 발급, 해당 토큰을 데이터에 포함해서 보내지 않으면 
				//			form 태그 요청을 아예 받아주지 않는 방식
				
				// (5) 데이터 수집(MultipartRequest 로부터)
				String dogName = multi.getParameter("dogName");
		        String dogGender = multi.getParameter("dogGender");
		        double dogWeight = Integer.parseInt(multi.getParameter("dogWeight"));
		        String dogBirthday = multi.getParameter("dogBirthday");
		        String dogAdoptionDate = multi.getParameter("dogAdoptionDate");
		        
		        // (6) 파일 저장, 파일이름 수집
		        String img1 = multi.getFilesystemName("photo1");
		        String img2 = multi.getFilesystemName("photo2");
		        String img3 = multi.getFilesystemName("photo3");
		        System.out.println(savePath);
		        
		        HttpSession session = request.getSession();
				Tb_login user = (Tb_login)session.getAttribute("user");
				String email = user.getLogin_email();
		        
		        
		        Tb_pet p = new Tb_pet();
		        p.setPet_name(dogName);
		        p.setPet_gender(dogGender);
		        p.setPet_weight(dogWeight);
		        p.setPet_birthdate(dogBirthday);
		        p.setAdopted_at(dogAdoptionDate);
		        p.setPet_img1(img1);
		        p.setPet_img2(img2);
		        p.setPet_img3(img3);
		        p.setLogin_email(email);
		        
		        System.out.println(dogName+" "+dogGender+" "+dogWeight+" "+dogBirthday+" "+dogAdoptionDate+" "+img1+" "+img2+" "+img3+" "+email);
		        
		        String allergy = multi.getParameter("allergy");
		        String disease = multi.getParameter("disease");
		        String food = multi.getParameter("food");
		        String etc = multi.getParameter("etc");
		        
		        System.out.println(allergy+" "+disease+" "+food+" "+etc);
		        
		        Tb_care care = new Tb_care();
		        care.setAllergy(allergy);
		        care.setDisease(disease);
		        care.setFood(food);
		        care.setEtc(etc);
		        
		        
		        PetDAO dao = new PetDAO();
		        int row = dao.new_pet(p);
		        String url = "";
		        if(row>0) {
		        	//성공
		        	Tb_pet pet = dao.myOnePet(p);
		        	int i = pet.getPet_idx();
		        	care.setPet_idx(i);
		        	CareDAO cDAO = new CareDAO();
		        	cDAO.newCare(care);
		        	
		        	System.out.println("등록성공");
		        	url = "WEB-INF/views/main.jsp";
		        }else {
		        	System.out.println("펫등록 실패");
		        	url = "WEB-INF/views/pet.jsp";
		        }
				
				
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
		    	
	        
	}

}
