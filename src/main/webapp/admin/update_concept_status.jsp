<%@ page import="java.sql.*"%>
<%
String role=(String)session.getAttribute("role");
if(role==null || !role.equals("admin")){
 response.sendRedirect("../login.jsp");
 return;
}

int id=Integer.parseInt(request.getParameter("id"));
String st=request.getParameter("st");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/eng","root","madhu");

PreparedStatement ps=con.prepareStatement(
"UPDATE concep SET status=? WHERE concept_id=?");
ps.setString(1,st);
ps.setInt(2,id);
ps.executeUpdate();

con.close();

response.sendRedirect("approve_concepts.jsp");
%>
