<%@ page import="java.sql.*" %>
<%
Integer admin_id = (Integer) session.getAttribute("user_id");
String role = (String) session.getAttribute("role");

if(admin_id == null || role == null || !role.equals("admin")){
    response.sendRedirect("../login.jsp");
    return;
}

String id = request.getParameter("id"); 
if(id != null){
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/eng","root","madhu"
        );

        PreparedStatement ps = con.prepareStatement(
            "UPDATE concep SET status='rejected' WHERE concept_id=?"
        );
        ps.setInt(1,Integer.parseInt(id));
        ps.executeUpdate();
        con.close();

        response.sendRedirect("view_pending_concepts.jsp?msg=Concept+Rejected");
        return;
    }catch(Exception e){
        out.println("Error: "+e.getMessage());
    }
}else{
    response.sendRedirect("view_pending_concepts.jsp");
}
%>
