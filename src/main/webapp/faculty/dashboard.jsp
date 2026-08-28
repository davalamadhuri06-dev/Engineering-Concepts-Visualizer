<%@ page import="java.sql.*"%>

<%
Integer fid = (Integer)session.getAttribute("user_id");
String role = (String)session.getAttribute("role");

if(fid == null || role == null || !"faculty".equals(role)){
    response.sendRedirect("../login.jsp");
    return;
}

int feedbackCount = 0;
int conceptCount = 0;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/eng","root","madhu");

    // feedback count
    PreparedStatement ps1 = con.prepareStatement(
        "SELECT COUNT(*) FROM feedback f " +
        "JOIN concep c ON f.concept_id = c.concept_id " +
        "WHERE c.faculty_id = ?"
    );
    ps1.setInt(1, fid);

    ResultSet rs1 = ps1.executeQuery();
    if(rs1.next()){
        feedbackCount = rs1.getInt(1);
    }

    rs1.close();
    ps1.close();

    // concept count
    PreparedStatement ps2 = con.prepareStatement(
        "SELECT COUNT(*) FROM concep WHERE faculty_id=?"
    );
    ps2.setInt(1, fid);

    ResultSet rs2 = ps2.executeQuery();
    if(rs2.next()){
        conceptCount = rs2.getInt(1);
    }

    rs2.close();
    ps2.close();
    con.close();

}catch(Exception e){
    out.println(e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Faculty Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{margin:0;font-family:Segoe UI;background:#f3f4f6}
.sidebar{width:230px;height:100vh;position:fixed;background:#0f172a;color:white}
.sidebar a{display:block;padding:14px;color:white;text-decoration:none}
.sidebar a:hover{background:#1e293b}
.main{margin-left:230px;padding:25px}
.card{background:white;padding:20px;border-radius:8px}
.badge{float:right}
</style>
</head>

<body>

<div class="sidebar">
    <h3 style="padding:15px">Faculty</h3>

    <a href="dashboard.jsp">Dashboard</a>
    <a href="add_concept.jsp">Add Concept</a>
    <a href="my_concepts.jsp">My Concepts</a>

    <a href="view_feedback.jsp">
        Student Feedback
        <span class="badge bg-danger">
            <%= feedbackCount %>
        </span>
    </a>
<a href="completed_students.jsp">Completed Students</a>
    <a href="student_progress.jsp">Student Progress</a>
    <a href="logout.jsp">Logout</a>
</div>

<div class="main">

    <div class="card">
        <h2>Faculty Dashboard</h2>

        <p>Total concepts uploaded :
            <b><%= conceptCount %></b>
        </p>

        <p>Total feedback received :
            <b><%= feedbackCount %></b>
        </p>

    </div>

</div>

</body>
</html>
