<%@page import="com.woori.entity.Tb_pet"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
	<!-- �������� ���ư��� ��ư -->
	<a href="main">
		<button>woori</button>
	</a>

<%List<Tb_pet> pet =  (List<Tb_pet>)request.getAttribute("pet"); %>

<% for(Tb_pet x : pet){ %>
				<tr>
					<td>�̸� : <%=x.getPet_name() %></td>
					<td>���� : <%=x.getPet_weight() %></td>
					<td>���� : <%=x.getPet_gender() %></td>
					<td>���� : <%=x.getPet_birthdate() %></td>
					<td>�Ծ��� : <%=x.getAdopted_at() %></td>
					<td>����1 : <%=x.getPet_img1() %></td>
					<td>����2 : <%=x.getPet_img2() %></td>
					<td>����3 : <%=x.getPet_img3() %></td>
					<td><a href="care?idx=<%=x.getPet_idx() %>"></a> �����ൿ </a></td>
				</tr>
				<% }%>



</body>
</html>