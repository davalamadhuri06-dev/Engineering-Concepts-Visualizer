<%@ page import="java.sql.*" %>

<%
/* ---------- DB connection ---------- */
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/eng","root","madhu");

/* ---------- filter role ---------- */
String filter = request.getParameter("filter");
if(filter == null || filter.trim().equals("")){
    filter = "all";
}

/* ---------- action ---------- */
String action = request.getParameter("action");

/* ---------- Delete ---------- */
if("delete".equals(action)){
    int id = Integer.parseInt(request.getParameter("id"));
    PreparedStatement ps1 =
        con.prepareStatement("DELETE FROM users4 WHERE id=?");
    ps1.setInt(1,id);
    ps1.executeUpdate();
    ps1.close();
}

/* ---------- Approve / Reject ---------- */
if("status".equals(action)){
    int id = Integer.parseInt(request.getParameter("id"));
    String value = request.getParameter("value");

    PreparedStatement ps2 =
        con.prepareStatement("UPDATE users4 SET status=? WHERE id=?");
    ps2.setString(1,value);
    ps2.setInt(2,id);
    ps2.executeUpdate();
    ps2.close();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Users</title>

<style>
body{margin:0;font-family:Arial,sans-serif;background:#f4f6f9;color:#333;}
.sidebar{
width:220px;height:100vh;background:#0d6efd;position:fixed;top:0;left:0;color:white;
}
.sidebar h3{padding:20px;text-align:center;background:#084298;}
.sidebar a{display:block;padding:15px 20px;color:white;text-decoration:none;}
.sidebar a:hover{background:#084298;}
.main{margin-left:220px;padding:30px;}

table{width:100%;border-collapse:collapse;background:white;border-radius:8px;}
th,td{padding:12px;border-bottom:1px solid #ddd;text-align:center;}
th{background:#0d6efd;color:white;}

a.action{padding:6px 10px;border-radius:5px;text-decoration:none;font-size:13px;}
.approve{background:#198754;color:white;}
.reject{background:#dc3545;color:white;}
.delete{background:#6c757d;color:white;}
.edit{background:#0d6efd;color:white;}

.filter-box{margin-bottom:15px;}
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
<a href="logout.jsp">Logout</a>
</div>

<div class="main">

<h2>Manage Students & Faculty (Admin Approval)</h2>

<div class="filter-box">
<form method="get" action="users.jsp">
Filter :
<select name="filter" onchange="this.form.submit()">
    <option value="all" <%= filter.equals("all")?"selected":"" %>>All</option>
    <option value="student" <%= filter.equals("student")?"selected":"" %>>Students</option>
    <option value="faculty" <%= filter.equals("faculty")?"selected":"" %>>Faculty</option>
</select>
</form>
</div>

<table>
<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Mobile</th>
<th>Role</th>
<th>Status</th>
<th>Action</th>
</tr>

<%
PreparedStatement ps;

if(filter.equals("all")){
    ps = con.prepareStatement(
      "SELECT id,uname,uemail,umobile,role,status FROM users4 " +
      "WHERE role IN ('student','faculty')");
}else{
    ps = con.prepareStatement(
      "SELECT id,uname,uemail,umobile,role,status FROM users4 " +
      "WHERE role=?");
    ps.setString(1,filter);
}

ResultSet rs = ps.executeQuery();

while(rs.next()){
int id = rs.getInt("id");
String status = rs.getString("status");
%>

<tr>
<td><%=id%></td>
<td><%=rs.getString("uname")%></td>
<td><%=rs.getString("uemail")%></td>
<td><%=rs.getString("umobile")%></td>
<td><%=rs.getString("role")%></td>
<td><%=status%></td>

<td>

<a class="action approve"
href="users.jsp?action=status&id=<%=id%>&value=approved&filter=<%=filter%>">
Approve</a>

<a class="action reject"
href="users.jsp?action=status&id=<%=id%>&value=rejected&filter=<%=filter%>">
Reject</a>

<a class="action edit"
href="edit_student.jsp?id=<%=id%>">Edit</a>

<a class="action delete"
href="users.jsp?action=delete&id=<%=id%>&filter=<%=filter%>"
onclick="return confirm('Delete this user?')">
Delete</a>

</td>
</tr>

<%
}

rs.close();
ps.close();
con.close();
%>

</table>

</div>
</body>
</html>
