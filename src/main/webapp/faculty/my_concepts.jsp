<%@ page import="java.sql.*"%>
<%
Integer fid=(Integer)session.getAttribute("user_id");
if(fid==null){response.sendRedirect("../login.jsp");return;}
%>

<!DOCTYPE html>
<html>
<head>
<title>My Concepts</title>
<style>
table{width:100%;border-collapse:collapse;background:white}
th,td{padding:10px;border-bottom:1px solid #ddd}
</style>
</head>
<body>

<h2>My Concepts</h2>

<table>
<tr><th>Title</th><th>Subject</th><th>Status</th><th>Edit</th></tr>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/eng","root","madhu");

PreparedStatement ps=con.prepareStatement(
"SELECT c.concept_id,c.title,s.subject_name,c.status "+
"FROM concep c JOIN subjects s ON c.subject_id=s.subject_id "+
"WHERE faculty_id=?");

ps.setInt(1,fid);
ResultSet rs=ps.executeQuery();

while(rs.next()){
%>
<tr>
<td><%=rs.getString(2)%></td>
<td><%=rs.getString(3)%></td>
<td><%=rs.getString(4)%></td>
<td><a href="edit_concept.jsp?id=<%=rs.getInt(1)%>">Edit</a></td>
</tr>
<%}%>
</table>
</body>
</html>
