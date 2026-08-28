<%@ page import="java.sql.*" %>
<%
Integer admin_id = (Integer) session.getAttribute("user_id");
String role = (String) session.getAttribute("role");

// Only admin
if(admin_id == null || role == null || !role.equals("admin")){
    response.sendRedirect("../login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - Pending Concepts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">

<h2>Pending Concepts</h2>

<!-- Show success message -->
<%
String msg = request.getParameter("msg");
if(msg != null){
%>
<div class="alert alert-success mt-3"><%= msg %></div>
<%
}
%>

<table class="table table-bordered table-striped mt-3">
    <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Faculty</th>
            <th>Subject</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
<%
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/eng","root","madhu"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT c.concept_id, c.title, u.uname, s.subject_name " +
        "FROM concep c " +
        "JOIN users4 u ON c.faculty_id = u.id " +
        "JOIN subjects s ON c.subject_id = s.subject_id " +
        "WHERE c.status='pending'"
    );

    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>
        <tr>
            <td><%= rs.getInt("concept_id") %></td>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("uname") %></td>
            <td><%= rs.getString("subject_name") %></td>
            <td>
                <a href="approve_concept.jsp?id=<%=rs.getInt("concept_id")%>" class="btn btn-success btn-sm">Approve</a>
                <a href="reject_concept.jsp?id=<%=rs.getInt("concept_id")%>" class="btn btn-danger btn-sm">Reject</a>
            </td>
        </tr>
<%
    }
    con.close();
}catch(Exception e){
    out.println("<tr><td colspan='5' style='color:red;'>Error: "+e.getMessage()+"</td></tr>");
}
%>
    </tbody>
</table>

</body>
</html>
