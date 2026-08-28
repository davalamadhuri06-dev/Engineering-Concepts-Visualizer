<%@ page import="java.sql.*"%>

<%
Integer sid=(Integer)session.getAttribute("user_id");
if(sid==null){response.sendRedirect("../login.jsp");return;}

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/eng","root","madhu");

PreparedStatement ps=con.prepareStatement(
"INSERT INTO concept_feedback(student_id,concept_id,message) VALUES(?,?,?)");

ps.setInt(1,sid);
ps.setInt(2,Integer.parseInt(request.getParameter("concept_id")));
ps.setString(3,request.getParameter("message"));

ps.executeUpdate();

response.sendRedirect("feedback.jsp");
%>
