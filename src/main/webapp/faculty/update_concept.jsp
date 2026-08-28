<%@ page import="java.sql.*" %>
<%
Integer faculty_id = (Integer) session.getAttribute("user_id");
String role = (String) session.getAttribute("role");

if(faculty_id == null || role == null || !role.equals("faculty")){
    response.sendRedirect("../login.jsp");
    return;
}

String concept_id = request.getParameter("concept_id");
String title = request.getParameter("title");
String description = request.getParameter("description");
String subject_id = request.getParameter("subject_id");
String image_url = request.getParameter("image_url");
String video_url = request.getParameter("video_url");
String pdf_url = request.getParameter("pdf_url");
String chart_page = request.getParameter("chart_page");
String animation_page = request.getParameter("animation_page");

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eng","root","madhu");

    PreparedStatement ps = con.prepareStatement(
        "UPDATE concep SET title=?, description=?, subject_id=?, image_url=?, video_url=?, pdf_url=?, chart_page=?, animation_page=?, status='pending' " +
        "WHERE concept_id=? AND faculty_id=?"
    );

    ps.setString(1,title);
    ps.setString(2,description);
    ps.setInt(3,Integer.parseInt(subject_id));
    ps.setString(4,image_url);
    ps.setString(5,video_url);
    ps.setString(6,pdf_url);
    ps.setString(7,chart_page);
    ps.setString(8,animation_page);
    ps.setInt(9,Integer.parseInt(concept_id));
    ps.setInt(10,faculty_id);

    ps.executeUpdate();
    con.close();

    response.sendRedirect("view_concepts.jsp");
}catch(Exception e){
    out.println("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
}
%>
