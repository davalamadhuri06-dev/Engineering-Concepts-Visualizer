<%@ page import="java.sql.*" %>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/eng","root","madhu");

String action = request.getParameter("action");

/* ---------- Deactivate subject (soft delete) ---------- */
if("deactivate".equals(action)){
    int id = Integer.parseInt(request.getParameter("id"));
    PreparedStatement ps = con.prepareStatement(
        "UPDATE subjects SET status='inactive' WHERE subject_id=?");
    ps.setInt(1,id);
    ps.executeUpdate();
}

/* ---------- Activate subject ---------- */
if("activate".equals(action)){
    int id = Integer.parseInt(request.getParameter("id"));
    PreparedStatement ps = con.prepareStatement(
        "UPDATE subjects SET status='active' WHERE subject_id=?");
    ps.setInt(1,id);
    ps.executeUpdate();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Subjects</title>

<style>
body{
    margin:0;
    font-family:Arial;
    background:#f4f6f9;
}

.sidebar{
    width:220px;
    height:100vh;
    position:fixed;
    left:0;
    top:0;
    background:#0d6efd;
    color:white;
}

.sidebar h3{
    text-align:center;
    padding:20px;
    background:#084298;
    margin:0;
}

.sidebar a{
    display:block;
    padding:14px 20px;
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

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    box-shadow:0 0 8px rgba(0,0,0,0.1);
}

th,td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

th{
    background:#0d6efd;
    color:white;
}

.btn{
    padding:6px 12px;
    text-decoration:none;
    border-radius:4px;
    color:white;
    font-size:14px;
}

.activate{ background:#198754; }
.deactivate{ background:#dc3545; }

h2{color:#0d6efd;}
</style>
</head>

<body>

<div class="sidebar">
    <h3>Admin Panel</h3>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="users.jsp">Users</a>
    <a href="subjects.jsp">Subjects</a>
    <a href="concepts.jsp">Concept Approval</a>
    <a href="feedback.jsp">Feedback</a>
    <a href="logout.jsp">Logout</a>
</div>

<div class="main">

<h2>Manage Subjects</h2>

<table>
<tr>
    <th>ID</th>
    <th>Subject Name</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
PreparedStatement ps = con.prepareStatement(
    "SELECT subject_id, subject_name, status FROM subjects");
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>
<tr>
    <td><%=rs.getInt("subject_id")%></td>
    <td><%=rs.getString("subject_name")%></td>
    <td><%=rs.getString("status")%></td>
    <td>
        <% if("active".equalsIgnoreCase(rs.getString("status"))){ %>
            <a class="btn deactivate"
               href="subjects.jsp?action=deactivate&id=<%=rs.getInt("subject_id")%>"
               onclick="return confirm('Deactivate this subject?')">Deactivate</a>
        <% }else{ %>
            <a class="btn activate"
               href="subjects.jsp?action=activate&id=<%=rs.getInt("subject_id")%>">
               Activate</a>
        <% } %>
    </td>
</tr>
<%
}
rs.close();
con.close();
%>

</table>

</div>
</body>
</html>
