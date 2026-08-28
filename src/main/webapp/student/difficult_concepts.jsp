<%@ page import="java.sql.*"%>

<%
Integer sid = (Integer)session.getAttribute("user_id");
String role = (String)session.getAttribute("role");

/* Check student login */
if(sid == null || role == null || !"student".equals(role)){
    response.sendRedirect("../login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Most Difficult Concepts</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f3f4f6;
    font-family:Segoe UI;
}
.card-box{
    background:#ffffff;
    padding:20px;
    border-radius:10px;
    box-shadow:0 4px 10px rgba(0,0,0,.08);
}
</style>
</head>

<body class="p-4">

<h3 class="mb-3">Most Difficult Concepts (Student Ratings)</h3>

<div class="card-box">

<table class="table table-bordered align-middle">
<tr>
    <th>Concept Title</th>
    <th>Average Difficulty</th>
    <th>Total Ratings</th>
</tr>

<%
try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/eng","root","madhu");

    PreparedStatement ps = con.prepareStatement(
        "SELECT c.title, ROUND(AVG(r.rating),2) AS avg_rating, COUNT(*) AS total " +
        "FROM concept_rating r " +
        "JOIN concepts c ON r.concept_id = c.concept_id " +
        "GROUP BY r.concept_id, c.title " +
        "ORDER BY avg_rating DESC"
    );

    ResultSet rs = ps.executeQuery();

    boolean found = false;

    while(rs.next()){
        found = true;
%>

<tr>
    <td><%= rs.getString("title") %></td>

    <td>
        <b><%= rs.getDouble("avg_rating") %> / 5</b>
    </td>

    <td>
        <%= rs.getInt("total") %>
    </td>
</tr>

<%
    }

    if(!found){
%>

<tr>
<td colspan="3" class="text-center text-muted">
No ratings yet
</td>
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