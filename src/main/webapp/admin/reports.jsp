<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Reports</title>

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
table{border-collapse:collapse;width:80%;margin-top:20px;}
th,td{border:1px solid #ccc;padding:8px;text-align:center;}
h2,h3{margin-top:40px;}
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

<h2>Admin Summary Reports</h2>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/eng","root","madhu");
Statement st = con.createStatement();

/* Overall Counts */
int totalStudents = 0;
int totalFaculty = 0;
int totalSubjects = 0;
int totalConcepts = 0;
int totalFeedbacks = 0;

ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM users4 WHERE role='student'");
if(rs.next()) totalStudents = rs.getInt(1);

rs = st.executeQuery("SELECT COUNT(*) FROM users4 WHERE role='faculty'");
if(rs.next()) totalFaculty = rs.getInt(1);

rs = st.executeQuery("SELECT COUNT(*) FROM subjects");
if(rs.next()) totalSubjects = rs.getInt(1);

rs = st.executeQuery("SELECT COUNT(*) FROM concepts");
if(rs.next()) totalConcepts = rs.getInt(1);

rs = st.executeQuery("SELECT COUNT(*) FROM feedback");
if(rs.next()) totalFeedbacks = rs.getInt(1);
rs.close();
%>

<table>
<tr><th>Total Students</th><td><%=totalStudents%></td></tr>
<tr><th>Total Faculty</th><td><%=totalFaculty%></td></tr>
<tr><th>Total Subjects</th><td><%=totalSubjects%></td></tr>
<tr><th>Total Concepts</th><td><%=totalConcepts%></td></tr>
<tr><th>Total Feedbacks</th><td><%=totalFeedbacks%></td></tr>
</table>

<%-- Feedback per Student --%>
<h3>Feedbacks per Student</h3>
<table>
<tr><th>Student Name</th><th>Total Feedbacks</th></tr>
<%
ResultSet rs2 = st.executeQuery(
"SELECT u.uname, COUNT(f.feedback_id) AS total_feedback " +
"FROM users4 u LEFT JOIN feedback f ON u.id=f.student_id " +
"WHERE u.role='student' GROUP BY u.uname");
while(rs2.next()){
%>
<tr>
<td><%=rs2.getString("uname")%></td>
<td><%=rs2.getInt("total_feedback")%></td>
</tr>
<%
}
rs2.close();
%>
</table>

<%-- Concepts per Subject --%>
<h3>Concepts per Subject</h3>
<table>
<tr><th>Subject Name</th><th>Total Concepts</th></tr>
<%
ResultSet rs3 = st.executeQuery(
"SELECT s.subject_name, COUNT(c.concept_id) AS total_concepts " +
"FROM subjects s LEFT JOIN concepts c ON s.subject_id=c.subject_id " +
"GROUP BY s.subject_name");
while(rs3.next()){
%>
<tr>
<td><%=rs3.getString("subject_name")%></td>
<td><%=rs3.getInt("total_concepts")%></td>
</tr>
<%
}
rs3.close();
%>
</table>

<%-- Users per Status --%>
<h3>Users per Status</h3>
<table>
<tr><th>Role</th><th>Active</th><th>Inactive</th></tr>
<%
ResultSet rs4 = st.executeQuery(
"SELECT role, " +
"SUM(CASE WHEN status='active' THEN 1 ELSE 0 END) AS active_count, " +
"SUM(CASE WHEN status='inactive' THEN 1 ELSE 0 END) AS inactive_count " +
"FROM users4 WHERE role IN ('student','faculty') GROUP BY role");
while(rs4.next()){
%>
<tr>
<td><%=rs4.getString("role")%></td>
<td><%=rs4.getInt("active_count")%></td>
<td><%=rs4.getInt("inactive_count")%></td>
</tr>
<%
}
rs4.close();
con.close();
%>
</table>

</div>
</body>
</html>
