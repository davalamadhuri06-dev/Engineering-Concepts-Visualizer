<%@ page import="java.sql.*" %>
<%
Integer student_id = (Integer) session.getAttribute("user_id");
String role = (String) session.getAttribute("role");

if(student_id == null || role == null || !role.equals("student")){
    response.sendRedirect("../login.jsp");
    return;
}

String conceptId = request.getParameter("concept_id");
String feedback  = request.getParameter("feedback");
String subjectId = request.getParameter("subject_id");

if(conceptId != null && !conceptId.trim().isEmpty()
        && feedback != null && !feedback.trim().isEmpty()){

    Connection con = null;
    PreparedStatement ps = null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/eng","root","madhu");

        ps = con.prepareStatement(
            "INSERT INTO feedback (student_id, concept_id, message, Date_Time) " +
            "VALUES (?, ?, ?, NOW())"
        );

        ps.setInt(1, student_id);
        ps.setInt(2, Integer.parseInt(conceptId));
        ps.setString(3, feedback);

        ps.executeUpdate();

        response.sendRedirect("concepts.jsp?subject_id=" + subjectId);

    }catch(Exception e){
        out.println("Error submitting feedback: " + e.getMessage());
    }finally{
        try{ if(ps!=null) ps.close(); }catch(Exception e){}
        try{ if(con!=null) con.close(); }catch(Exception e){}
    }

}else{
    response.sendRedirect("concepts.jsp");
}
%>
