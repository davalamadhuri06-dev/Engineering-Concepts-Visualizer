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
<title>Student Progress</title>

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

<h3 class="mb-4">Student Progress</h3>

<div class="card-box">

<table class="table align-middle">
<tr>
    <th>Student ID</th>
    <th>Feedback Count</th>
    <th>Activity Level</th>
</tr>

<%
int maxCount = 1;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/eng","root","madhu");

    /* find maximum feedback count (for progress bar scaling) */
    PreparedStatement psMax = con.prepareStatement(
        "SELECT MAX(cnt) FROM (" +
        " SELECT COUNT(*) AS cnt " +
        " FROM feedback f " +
        " JOIN concep c ON f.concept_id=c.concept_id " +
        " WHERE c.faculty_id=? " +
        " GROUP BY f.student_id" +
        ") t"
    );
    psMax.setInt(1,fid);

    ResultSet rsMax = psMax.executeQuery();
    if(rsMax.next() && rsMax.getInt(1)>0){
        maxCount = rsMax.getInt(1);
    }

    rsMax.close();
    psMax.close();

    PreparedStatement ps = con.prepareStatement(
        "SELECT f.student_id, COUNT(*) AS total_feedback " +
        "FROM feedback f " +
        "JOIN concep c ON f.concept_id = c.concept_id " +
        "WHERE c.faculty_id = ? " +
        "GROUP BY f.student_id"
    );

    ps.setInt(1, fid);

    ResultSet rs = ps.executeQuery();

    boolean found = false;

    while(rs.next()){
        found = true;

        int sid = rs.getInt("student_id");
        int total = rs.getInt("total_feedback");

        int percent = (int)((total * 100.0) / maxCount);
%>

<tr>
    <td><%= sid %></td>
    <td><b><%= total %></b></td>
    <td style="width:40%">
        <div class="progress" style="height:20px">
            <div class="progress-bar bg-success"
                 role="progressbar"
                 style="width:<%=percent%>%">
                 <%=percent%>%
            </div>
        </div>
    </td>
</tr>

<%
    }

    if(!found){
%>
<tr>
    <td colspan="3" class="text-center text-muted">
        No student activity yet
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
