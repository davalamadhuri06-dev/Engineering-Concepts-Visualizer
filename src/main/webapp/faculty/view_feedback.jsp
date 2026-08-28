<%@ page import="java.sql.*"%>

<%
Integer fid = (Integer)session.getAttribute("user_id");
String role = (String)session.getAttribute("role");

if(fid == null || role == null || !"faculty".equals(role)){
    response.sendRedirect("../login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Student Feedback</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{background:#f3f4f6;font-family:Segoe UI}
.card{background:white;padding:20px;border-radius:8px}
</style>
</head>

<body class="p-4">

<h3>Student Feedback</h3>

<div class="card mt-3">

<table class="table table-bordered">
<tr>
    <th>Student ID</th>
    <th>Concept Title</th>
    <th>Feedback</th>
    <th>Date</th>
</tr>

<%
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/eng","root","madhu");

    PreparedStatement ps = con.prepareStatement(
        "SELECT f.student_id, f.message, f.Date_Time, c.title " +
        "FROM feedback f " +
        "JOIN concep c ON f.concept_id = c.concept_id " +
        "WHERE c.faculty_id = ? " +
        "ORDER BY f.Date_Time DESC"
    );

    ps.setInt(1, fid);

    ResultSet rs = ps.executeQuery();

    boolean found = false;

    while(rs.next()){
        found = true;
%>

<tr>
    <td><%= rs.getInt("student_id") %></td>
    <td><%= rs.getString("title") %></td>
    <td><%= rs.getString("message") %></td>
    <td><%= rs.getTimestamp("Date_Time") %></td>
</tr>

<%
    }

    if(!found){
%>
<tr>
    <td colspan="4" class="text-center">No feedback yet</td>
</tr>
<%
    }

    rs.close();
    ps.close();
    con.close();

}catch(Exception e){
    out.println("Error : " + e.getMessage());
}
%>

</table>

</div>

</body>
</html>
