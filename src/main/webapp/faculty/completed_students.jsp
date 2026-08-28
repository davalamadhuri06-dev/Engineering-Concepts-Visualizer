<%@ page import="java.sql.*"%>

<%
Integer fid=(Integer)session.getAttribute("user_id");
String role=(String)session.getAttribute("role");

if(fid==null || !"faculty".equals(role)){
 response.sendRedirect("../login.jsp"); return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Completed Students</title>
<link href="https://cdn.jsdelivr.net/npmbootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="p-4">

<h3>Students who completed your concepts</h3>

<table class="table table-bordered mt-3">
<tr>
    <th>Student ID</th>
    <th>Concept Title</th>
    <th>Completed On</th>
</tr>

<%
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/eng","root","madhu");

    PreparedStatement ps=con.prepareStatement(
        "SELECT s.student_id, c.title, s.updated_at " +
        "FROM student_concept_status s " +
        "JOIN concep c ON s.concept_id=c.concept_id " +
        "WHERE c.faculty_id=? AND s.status='completed' " +
        "ORDER BY s.updated_at DESC"
    );

    ps.setInt(1,fid);

    ResultSet rs=ps.executeQuery();

    boolean found=false;
    while(rs.next()){
        found=true;
%>

<tr>
    <td><%=rs.getInt("student_id")%></td>
    <td><%=rs.getString("title")%></td>
    <td><%=rs.getTimestamp("updated_at")%></td>
</tr>

<%
    }

    if(!found){
%>
<tr><td colspan="3" class="text-center">No completions yet</td></tr>
<%
    }

    rs.close(); ps.close(); con.close();

}catch(Exception e){
    out.println(e.getMessage());
}
%>

</table>

</body>
</html>
