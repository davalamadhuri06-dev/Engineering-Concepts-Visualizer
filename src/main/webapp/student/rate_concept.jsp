<%@ page import="java.sql.*" %>
<%
Integer sid = (Integer)session.getAttribute("user_id");
String role = (String)session.getAttribute("role");

if(sid == null || !"student".equals(role)){
    response.sendRedirect("../login.jsp");
    return;
}

String cid = request.getParameter("concept_id");
String rating = request.getParameter("rating");

if(cid != null && rating != null){

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/eng","root","madhu");

        PreparedStatement ps = con.prepareStatement(
            "REPLACE INTO concept_rating " +
            "(student_id, concept_id, rating, rated_at) " +
            "VALUES (?, ?, ?, NOW())"
        );

        ps.setInt(1, sid);
        ps.setInt(2, Integer.parseInt(cid));
        ps.setInt(3, Integer.parseInt(rating));
        ps.executeUpdate();

        ps.close();
        con.close();

        response.sendRedirect("concepts.jsp");

    }catch(Exception e){
        out.println(e.getMessage());
    }
}
%>
