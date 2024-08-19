<%@page import="com.woori.entity.Tb_pet"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	
	<!-- 메인으로 돌아가는 버튼 -->
	<a href="main">
		<button>woori</button>
	</a>

<%List<Tb_pet> pet =  (List<Tb_pet>)request.getAttribute("pet"); %>


<%if(pet!=null){ %>
<% for(Tb_pet x : pet){ %>
				<tr>
					<td>이름 : <%=x.getPet_name() %></td>
					<td>무게 : <%=x.getPet_weight() %></td>
					<td>성별 : <%=x.getPet_gender() %></td>
					<td>생일 : <%=x.getPet_birthdate() %></td>
					<td>입양일 : <%=x.getAdopted_at() %></td>
					<td>사진1 : <%=x.getPet_img1() %></td>
					<td>사진2 : <%=x.getPet_img2() %></td>
					<td>사진3 : <%=x.getPet_img3() %></td>
					<td><a href="care?idx=<%=x.getPet_idx() %>"></a> 돌봄행동 </a></td>
				</tr>
				<% } }else{%>
				<td>펫을 등록하세요</td>
				<%} %>


</body>
</html>