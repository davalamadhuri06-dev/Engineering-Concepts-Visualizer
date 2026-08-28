<%@ page import="java.sql.*" %>

<%
String email = (String)session.getAttribute("email");

if(email == null){
response.sendRedirect("../login.jsp");
return;
}

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/eng","root","madhu");

/* GET STUDENT DETAILS */

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM users4 WHERE email=?");

ps.setString(1,email);

ResultSet rs = ps.executeQuery();

String name="";
String course="";
String department="";

if(rs.next()){
name = rs.getString("uname");
course = rs.getString("course");
department = rs.getString("department");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Student Profile</title>

<style>

body{
font-family:Arial;
background:#f4f6f9;
margin:0;
}

.header{
background:#0d6efd;
color:white;
padding:15px;
text-align:center;
}

.profile{
width:400px;
margin:40px auto;
background:white;
padding:30px;
border-radius:10px;
box-shadow:0 0 10px rgba(0,0,0,0.1);
}

.profile h2{
text-align:center;
color:#0d6efd;
}

.profile p{
font-size:16px;
padding:8px 0;
}

table{
width:80%;
margin:auto;
border-collapse:collapse;
background:white;
}

th,td{
padding:10px;
border:1px solid #ddd;
text-align:center;
}

th{
background:#0d6efd;
color:white;
}

</style>
</head>

<body>

<div class="header">
<h2>Student Dashboard</h2>
</div>

<div class="profile">

<h2><%=name%></h2>

<p><b>Email:</b> <%=email%></p>

<p><b>Course:</b> <%=course%></p>

<p><b>Department:</b> <%=department%></p>

</div>


<h3 style="text-align:center">Your Concepts</h3>

<table>

<tr>
<th>Title</th>
<th>Description</th>
<th>Date</th>
</tr>

<%

PreparedStatement ps2 = con.prepareStatement(
"SELECT title,description,Date_Time FROM concepts ORDER BY Date_Time DESC");

ResultSet rs2 = ps2.executeQuery();

while(rs2.next()){
%>

<tr>

<td><%=rs2.getString("title")%></td>

<td><%=rs2.getString("description")%></td>

<td><%=rs2.getString("Date_Time")%></td>

</tr>

<%
}
%>

</table>

</body>
</html>

<%
con.close();
%>