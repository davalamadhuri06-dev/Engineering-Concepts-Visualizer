<%@ page import="java.sql.*" %>

<%
Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/eng","root","madhu");

int id = Integer.parseInt(request.getParameter("id"));

/* -------- UPDATE CONCEPT -------- */

if("POST".equalsIgnoreCase(request.getMethod())){

String title = request.getParameter("title");
String description = request.getParameter("description");
int subject_id = Integer.parseInt(request.getParameter("subject_id"));
int faculty_id = Integer.parseInt(request.getParameter("faculty_id"));
String file_path = request.getParameter("file_path");
String status = request.getParameter("status");

PreparedStatement ps = con.prepareStatement(
"UPDATE concepts SET title=?, description=?, subject_id=?, faculty_id=?, file_path=?, status=? WHERE concept_id=?"
);

ps.setString(1,title);
ps.setString(2,description);
ps.setInt(3,subject_id);
ps.setInt(4,faculty_id);
ps.setString(5,file_path);
ps.setString(6,status);
ps.setInt(7,id);

ps.executeUpdate();

response.sendRedirect("concepts.jsp");
return;
}

/* -------- LOAD EXISTING CONCEPT -------- */

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM concepts WHERE concept_id=?");

ps.setInt(1,id);

ResultSet rs = ps.executeQuery();

rs.next();
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Concept</title>

<style>

body{
font-family:Arial;
background:#f4f6f9;
margin:0;
}

.sidebar{
width:220px;
height:100vh;
background:#0d6efd;
position:fixed;
left:0;
top:0;
color:white;
}

.sidebar h3{
padding:20px;
background:#084298;
text-align:center;
}

.sidebar a{
display:block;
padding:15px;
color:white;
text-decoration:none;
}

.sidebar a:hover{
background:#084298;
}

.main{
margin-left:220px;
padding:30px;
}

form{
background:white;
padding:20px;
border-radius:8px;
box-shadow:0 2px 6px rgba(0,0,0,0.2);
width:500px;
}

input,textarea,select{
width:100%;
padding:10px;
margin-bottom:15px;
border-radius:6px;
border:1px solid #ccc;
}

button{
background:#0d6efd;
color:white;
border:none;
padding:10px 15px;
border-radius:6px;
cursor:pointer;
}

button:hover{
background:#084298;
}

</style>
</head>

<body>

<div class="sidebar">

<h3>Admin Panel</h3>

<a href="dashboard.jsp">Dashboard</a>
<a href="users.jsp">Users</a>
<a href="subjects.jsp">Subjects</a>
<a href="concepts.jsp">Concepts</a>
<a href="feedback.jsp">Feedback</a>
<a href="logout.jsp">Logout</a>

</div>

<div class="main">

<h2>Edit Concept</h2>

<form method="post">

<label>Concept Title</label>
<input type="text" name="title" value="<%=rs.getString("title")%>" required>

<label>Description</label>
<textarea name="description"><%=rs.getString("description")%></textarea>

<label>Subject</label>
<select name="subject_id">

<%
PreparedStatement ps_sub = con.prepareStatement("SELECT * FROM subjects");
ResultSet rs_sub = ps_sub.executeQuery();

while(rs_sub.next()){
%>

<option value="<%=rs_sub.getInt("subject_id")%>"
<%= rs_sub.getInt("subject_id")==rs.getInt("subject_id") ? "selected":"" %>>
<%=rs_sub.getString("subject_name")%>
</option>

<%
}
%>

</select>

<label>Faculty</label>
<select name="faculty_id">

<%
PreparedStatement ps_fac = con.prepareStatement(
"SELECT * FROM users4 WHERE role='faculty'");

ResultSet rs_fac = ps_fac.executeQuery();

while(rs_fac.next()){
%>

<option value="<%=rs_fac.getInt("id")%>"
<%= rs_fac.getInt("id")==rs.getInt("faculty_id") ? "selected":"" %>>
<%=rs_fac.getString("uname")%>
</option>

<%
}
%>

</select>

<label>File Path</label>
<input type="text" name="file_path" value="<%=rs.getString("file_path")%>">

<label>Status</label>
<select name="status">

<option value="active"
<%= "active".equals(rs.getString("status")) ? "selected":"" %>>
Active
</option>

<option value="inactive"
<%= "inactive".equals(rs.getString("status")) ? "selected":"" %>>
Inactive
</option>

</select>

<button type="submit">Update Concept</button>

</form>

</div>

</body>
</html>