<%@ page import="java.sql.*" %>

<%
String id = request.getParameter("id");

if(id == null){
    response.sendRedirect("users.jsp");
    return;
}

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/eng",
        "root",
        "madhu"
);

/* ---- delete record ---- */

PreparedStatement ps = con.prepareStatement(
        "delete from users4 where id=?");
ps.setInt(1, Integer.parseInt(id));
ps.executeUpdate();

con.close();

response.sendRedirect("users.jsp");
%>
