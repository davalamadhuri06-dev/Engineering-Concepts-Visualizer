<%@ page import="java.sql.*" %>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/eng","root","madhu");

int id = Integer.parseInt(request.getParameter("id"));

if("POST".equalsIgnoreCase(request.getMethod())){
    String uname = request.getParameter("uname");
    String uemail = request.getParameter("uemail");
    String umobile = request.getParameter("umobile");
    String role = request.getParameter("role");
    String status = request.getParameter("status");

    PreparedStatement ps = con.prepareStatement(
        "UPDATE users4 SET uname=?, uemail=?, umobile=?, role=?, status=? WHERE id=?"
    );
    ps.setString(1, uname);
    ps.setString(2, uemail);
    ps.setString(3, umobile);
    ps.setString(4, role);
    ps.setString(5, status);
    ps.setInt(6, id);
    ps.executeUpdate();
    response.sendRedirect("users.jsp");
}

// Fetch current user data
PreparedStatement ps = con.prepareStatement("SELECT * FROM users4 WHERE id=?");
ps.setInt(1, id);
ResultSet rs = ps.executeQuery();
rs.next();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User</title>
<style>
body{margin:0;font-family:Arial,sans-serif;background:#f4f6f9;color:#333;}

/* --- Sidebar --- */
.sidebar{
width:220px;height:100vh;background:#0d6efd;position:fixed;top:0;left:0;color:white;display:flex;flex-direction:column;
}
.sidebar h3{padding:20px;text-align:center;background:#084298;margin-bottom:10px;}
.sidebar a{padding:15px 20px;text-decoration:none;color:white;font-weight:500;transition:0.3s;}
.sidebar a:hover{background:#084298;}

/* --- Main Content --- */
.main{margin-left:220px;padding:30px;}

/* --- Form --- */
form{
background:white;
padding:25px;
max-width:500px;
margin:auto;
border-radius:12px;
box-shadow:0 4px 12px rgba(0,0,0,0.2);
}
form label{display:block;margin-top:10px;font-weight:500;}
form input, form select{
width:100%;
padding:10px;
margin-top:5px;
margin-bottom:15px;
border-radius:6px;
border:1px solid #ccc;
}
input[type=submit]{background:#0d6efd;color:white;border:none;cursor:pointer;padding:12px;font-size:16px;border-radius:6px;transition:0.3s;}
input[type=submit]:hover{background:#084298;}

h2{color:#0d6efd;margin-bottom:20px;text-align:center;}
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
<h2>Edit User</h2>

<form method="post">
<label>Name:</label>
<input type="text" name="uname" value="<%=rs.getString("uname")%>" required>

<label>Email:</label>
<input type="email" name="uemail" value="<%=rs.getString("uemail")%>" required>

<label>Mobile:</label>
<input type="text" name="umobile" value="<%=rs.getString("umobile")%>" required>

<label>Role:</label>
<select name="role">
<option value="student" <%= "student".equals(rs.getString("role")) ? "selected" : "" %>>Student</option>
<option value="faculty" <%= "faculty".equals(rs.getString("role")) ? "selected" : "" %>>Faculty</option>
</select>

<label>Status:</label>
<select name="status">
<option value="active" <%= "active".equals(rs.getString("status")) ? "selected" : "" %>>Active</option>
<option value="inactive" <%= "inactive".equals(rs.getString("status")) ? "selected" : "" %>>Inactive</option>
</select>

<input type="submit" value="Update User">
</form>

</div>
</body>
</html>

<%
rs.close();
con.close();
%>
