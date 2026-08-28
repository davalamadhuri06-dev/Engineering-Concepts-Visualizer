<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<style>
body{
    margin:0;
    font-family: Arial, sans-serif;
    background: #f4f6f9;
    color: #333;
}

/* --- Sidebar --- */
.sidebar{
    width:220px;
    height:100vh;
    background:#0d6efd;
    position:fixed;
    top:0;
    left:0;
    color:white;
    display:flex;
    flex-direction:column;
}
.sidebar h3{
    padding:20px;
    text-align:center;
    background:#084298;
    margin-bottom:10px;
}
.sidebar a{
    padding:15px 20px;
    text-decoration:none;
    color:white;
    font-weight:500;
    transition:0.3s;
}
.sidebar a:hover{
    background:#084298;
}

/* --- Main Content --- */
.main{
    margin-left:220px;
    padding:30px;
}

/* --- Dashboard Cards --- */
.cards{
    display:flex;
    flex-wrap:wrap;
    gap:20px;
    margin-top:20px;
}
.card{
    flex:1;
    min-width:180px;
    background: linear-gradient(135deg, #0dcaf0, #198754);
    color:white;
    padding:25px;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,0.2);
    text-align:center;
    transition:0.3s;
}
.card:hover{
    transform: translateY(-5px);
}
.card h3{
    font-size:20px;
    margin-bottom:10px;
}
.card p{
    font-size:28px;
    font-weight:bold;
}

/* --- Header --- */
h2{
    color:#0d6efd;
    margin-bottom:20px;
}
</style>
</head>
<body>

<div class="sidebar">
<h3>Admin Panel</h3>
<a href="dashboard.jsp">Dashboard</a>
<a href="users.jsp">Manage Users</a>
<a href="subjects.jsp">Subjects</a>
<a href="concepts.jsp">Concepts</a>
<a href="approve_concept.jsp">Approve Concepts</a>

<a href="feedback.jsp">Feedback</a>
<a href="reports.jsp">Reports</a>
<a href="logout.jsp">Logout</a>
</div>

<div class="main">
<h2>Admin Dashboard</h2>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/eng","root","madhu");
Statement st = con.createStatement();

int totalStudents=0, totalFaculty=0, totalSubjects=0, totalConcepts=0;

ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM users4 WHERE role='student'");
if(rs.next()) totalStudents = rs.getInt(1);

rs = st.executeQuery("SELECT COUNT(*) FROM users4 WHERE role='faculty'");
if(rs.next()) totalFaculty = rs.getInt(1);

rs = st.executeQuery("SELECT COUNT(*) FROM subjects");
if(rs.next()) totalSubjects = rs.getInt(1);

rs = st.executeQuery("SELECT COUNT(*) FROM concepts");
if(rs.next()) totalConcepts = rs.getInt(1);

rs.close();
con.close();
%>

<div class="cards">
    <div class="card">
        <h3>Total Students</h3>
        <p><%=totalStudents%></p>
    </div>
    <div class="card">
        <h3>Total Faculty</h3>
        <p><%=totalFaculty%></p>
    </div>
    <div class="card">
        <h3>Total Subjects</h3>
        <p><%=totalSubjects%></p>
    </div>
    <div class="card">
        <h3>Total Concepts</h3>
        <p><%=totalConcepts%></p>
    </div>
</div>

</div>

</body>
</html>
