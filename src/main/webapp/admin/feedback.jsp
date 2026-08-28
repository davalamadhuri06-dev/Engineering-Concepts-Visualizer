<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Feedback</title>

<style>
body{margin:0;font-family:Arial;}
.sidebar{
width:220px;
height:100vh;
background:#0d6efd;
float:left;
color:white;
}
.sidebar h3{padding:15px;text-align:center;margin:0;}
.sidebar a{
display:block;
padding:12px 15px;
color:white;
text-decoration:none;
}
.sidebar a:hover{background:#084298;}
.main{margin-left:220px;padding:20px;}
table{border-collapse:collapse;width:100%;}
th,td{border:1px solid #ccc;padding:8px;text-align:center;}
</style>
</head>
<body>

<div class="sidebar">
<h3>Admin Panel</h3>
<a href="dashboard.jsp">Dashboard</a>
<a href="users.jsp">Manage Users</a>
<a href="subjects.jsp">Subjects</a>
<a href="concepts.jsp">Concepts</a>
<a href="feedback.jsp">Feedback</a>
<a href="reports.jsp">Reports</a>
<a href="logout.jsp">Logout</a>
</div>

<div class="main">

<h2>Student Feedback</h2>

<table>
<tr>
<th>ID</th>
<th>Student</th>
<th>Concept</th>
<th>Message</th>
<th>Date</th>
</tr>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/eng","root","madhu");

/* Use LEFT JOIN to avoid null errors if student or concept is missing */
PreparedStatement ps = con.prepareStatement(
"SELECT f.feedback_id, u.uname, c.title, f.message, f.Date_Time " +
"FROM feedback f " +
"LEFT JOIN users4 u ON f.student_id = u.id " +
"LEFT JOIN concepts c ON f.concept_id = c.concept_id " +
"ORDER BY f.Date_Time DESC"
);

ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
<td><%=rs.getInt("feedback_id")%></td>
<td><%=rs.getString("uname") != null ? rs.getString("uname") : "N/A" %></td>
<td><%=rs.getString("title") != null ? rs.getString("title") : "N/A" %></td>
<td><%=rs.getString("message")%></td>
<td><%=rs.getTimestamp("Date_Time")%></td>
</tr>

<%
}
con.close();
%>

</table>

</div>
</body>
</html>
