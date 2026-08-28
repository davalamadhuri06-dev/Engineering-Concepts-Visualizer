<%@ page import="java.sql.*" %>
<%
Integer faculty_id = (Integer) session.getAttribute("user_id");
String role = (String) session.getAttribute("role");

if(faculty_id == null || role == null || !role.equals("faculty")){
    response.sendRedirect("../login.jsp");
    return;
}

// Get form values
String title = request.getParameter("title");
String description = request.getParameter("description");
String subject_id_str = request.getParameter("subject_id");

if(subject_id_str == null || subject_id_str.isEmpty()){
    out.println("<p style='color:red;'>Error: Subject not selected!</p>");
    return;
}

int subject_id = Integer.parseInt(subject_id_str);
String image_url = request.getParameter("image_url");
String video_url = request.getParameter("video_url");
String pdf_url = request.getParameter("pdf_url");
String chart_page = request.getParameter("chart_page");
String animation_page = request.getParameter("animation_page");

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eng","root","madhu");

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO concep(title, description, subject_id, faculty_id, image_url, video_url, pdf_url, chart_page, animation_page, status) " +
        "VALUES (?,?,?,?,?,?,?,?,?,?)"
    );
    ps.setString(1, title);
    ps.setString(2, description);
    ps.setInt(3, subject_id);       // ✅ valid subject_id
    ps.setInt(4, faculty_id);
    ps.setString(5, image_url);
    ps.setString(6, video_url);
    ps.setString(7, pdf_url);
    ps.setString(8, chart_page);
    ps.setString(9, animation_page);
    ps.setString(10, "pending");    // Admin approval

    ps.executeUpdate();
    con.close();

    response.sendRedirect("view_concepts.jsp?msg=Concept+saved+successfully");

}catch(Exception e){
    out.println("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
}
%>
