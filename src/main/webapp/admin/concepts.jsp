<%@ page import="java.sql.*" %>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/eng","root","madhu");

String action = request.getParameter("action");

/* ---------- Add Concept ---------- */
if("add".equals(action) && "POST".equalsIgnoreCase(request.getMethod())){
    try {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int subject_id = Integer.parseInt(request.getParameter("subject_id"));
        int faculty_id = Integer.parseInt(request.getParameter("faculty_id"));
        String file_path = request.getParameter("file_path");

        if(title != null && !title.trim().isEmpty()){
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO concepts(title, description, subject_id, faculty_id, file_path) VALUES(?,?,?,?,?)"
            );
            ps.setString(1, title.trim());
            ps.setString(2, description);
            ps.setInt(3, subject_id);
            ps.setInt(4, faculty_id);
            ps.setString(5, file_path);
            ps.executeUpdate();

            response.sendRedirect("concepts.jsp");
            return;
        }
    } catch(Exception e){
        out.println("<p style='color:red;'>Error adding concept: " + e.getMessage() + "</p>");
    }
}

/* ---------- Delete Concept ---------- */
if("delete".equals(action)){
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        PreparedStatement ps = con.prepareStatement("DELETE FROM concepts WHERE concept_id=?");
        ps.setInt(1,id);
        ps.executeUpdate();
        response.sendRedirect("concepts.jsp");
        return;
    } catch(Exception e){
        out.println("<p style='color:red;'>Error deleting concept: " + e.getMessage() + "</p>");
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Concepts</title>
<style>
body{margin:0;font-family:Arial,sans-serif;background:#f4f6f9;color:#333;}
.sidebar{
width:220px;height:100vh;background:#0d6efd;position:fixed;top:0;left:0;color:white;display:flex;flex-direction:column;}
.sidebar h3{padding:20px;text-align:center;background:#084298;margin-bottom:10px;}
.sidebar a{padding:15px 20px;text-decoration:none;color:white;font-weight:500;transition:0.3s;}
.sidebar a:hover{background:#084298;}
.main{margin-left:220px;padding:30px;}
table{width:100%;border-collapse:collapse;background:white;border-radius:8px;overflow:hidden;box-shadow:0 2px 6px rgba(0,0,0,0.1);}
th,td{padding:12px;border-bottom:1px solid #ddd;text-align:center;}
th{background:#0d6efd;color:white;}
tr:hover{background:#f1f1f1;}
a.action{padding:6px 12px;border-radius:5px;text-decoration:none;font-size:14px;transition:0.2s;}
a.edit{background:#198754;color:white;}
a.delete{background:#dc3545;color:white;}
a.action:hover{opacity:0.8;}
h2{color:#0d6efd;margin-bottom:20px;}
form{background:white;padding:20px;margin:20px 0;border-radius:10px;box-shadow:0 2px 6px rgba(0,0,0,0.2);}
input[type=text],textarea,select{width:100%;padding:10px;margin-top:5px;margin-bottom:15px;border-radius:6px;border:1px solid #ccc;}
input[type=submit]{background:#0d6efd;color:white;border:none;cursor:pointer;padding:10px 15px;border-radius:6px;transition:0.3s;}
input[type=submit]:hover{background:#084298;}
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
<h2>Manage Concepts</h2>

<!-- Add Concept Form -->
<form method="post" action="concepts.jsp?action=add">
<label>Concept Title:</label>
<input type="text" name="title" required>

<label>Description:</label>
<textarea name="description" rows="4"></textarea>

<label>Subject:</label>
<select name="subject_id" required>
<%
try {
    PreparedStatement ps_sub = con.prepareStatement("SELECT * FROM subjects");
    ResultSet rs_sub = ps_sub.executeQuery();
    while(rs_sub.next()){
%>
<option value="<%=rs_sub.getInt("subject_id")%>"><%=rs_sub.getString("subject_name")%></option>
<%
    }
    rs_sub.close();
} catch(Exception e){ }
%>
</select>

<label>Faculty:</label>
<select name="faculty_id" required>
<%
try {
    PreparedStatement ps_fac = con.prepareStatement("SELECT * FROM users4 WHERE role='faculty'");
    ResultSet rs_fac = ps_fac.executeQuery();
    while(rs_fac.next()){
%>
<option value="<%=rs_fac.getInt("id")%>"><%=rs_fac.getString("uname")%></option>
<%
    }
    rs_fac.close();
} catch(Exception e){ }
%>
</select>

<label>File Path:</label>
<input type="text" name="file_path">

<input type="submit" value="Add Concept">
</form>

<!-- Concepts Table -->
<table>
<tr>
<th>ID</th>
<th>Title</th>
<th>Description</th>
<th>Subject</th>
<th>Faculty</th>
<th>Status</th>
<th>Date</th>
<th>Action</th>
</tr>

<%
try {
    PreparedStatement ps = con.prepareStatement(
        "SELECT c.concept_id, c.title, c.description, s.subject_name, u.uname AS faculty_name, c.status, c.Date_Time " +
        "FROM concepts c " +
        "JOIN subjects s ON c.subject_id=s.subject_id " +
        "JOIN users4 u ON c.faculty_id=u.id " +
        "ORDER BY c.Date_Time DESC"
    );
    ResultSet rs = ps.executeQuery();
    while(rs.next()){
        int id = rs.getInt("concept_id");
%>
<tr>
<td><%=id%></td>
<td><%=rs.getString("title")%></td>
<td><%=rs.getString("description")%></td>
<td><%=rs.getString("subject_name")%></td>
<td><%=rs.getString("faculty_name")%></td>
<td><%=rs.getString("status")%></td>
<td><%=rs.getString("Date_Time")%></td>
<td>
<a class="action edit" href="edit_concept.jsp?id=<%=id%>">Edit</a>
 | 
<a class="action delete" href="concepts.jsp?action=delete&id=<%=id%>" onclick="return confirm('Delete this concept?')">Delete</a>
</td>
</tr>
<%
    }
    rs.close();
} catch(Exception e){
    out.println("<tr><td colspan='8'>Error: "+e.getMessage()+"</td></tr>");
}
con.close();
%>
</table>

</div>
</body>
</html>
