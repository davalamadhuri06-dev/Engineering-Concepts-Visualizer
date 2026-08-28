<%@ page import="java.sql.*" %>
<%
Integer faculty_id = (Integer) session.getAttribute("user_id");
String role = (String) session.getAttribute("role");

if(faculty_id == null || role == null || !role.equals("faculty")){
    response.sendRedirect("../login.jsp");
    return;
}

String id = request.getParameter("id");
if(id == null){
    response.sendRedirect("view_concepts.jsp");
    return;
}

String title="", description="", image_url="", video_url="", pdf_url="", chart_page="", animation_page="";
int subject_id = 1;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eng","root","madhu");

    PreparedStatement ps = con.prepareStatement("SELECT * FROM concep WHERE concept_id=? AND faculty_id=?");
    ps.setInt(1,Integer.parseInt(id));
    ps.setInt(2,faculty_id);

    ResultSet rs = ps.executeQuery();
    if(rs.next()){
        title = rs.getString("title");
        description = rs.getString("description");
        subject_id = rs.getInt("subject_id");
        image_url = rs.getString("image_url");
        video_url = rs.getString("video_url");
        pdf_url = rs.getString("pdf_url");
        chart_page = rs.getString("chart_page");
        animation_page = rs.getString("animation_page");
    } else {
        response.sendRedirect("view_concepts.jsp");
    }

    con.close();
}catch(Exception e){
    out.println("Error: "+e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Concept</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body{background:#f8f9fa;}
        .container{max-width:700px;margin-top:50px;background:#fff;padding:30px;border-radius:10px;box-shadow:0 0 10px rgba(0,0,0,0.1);}
    </style>
</head>
<body>
<div class="container">
    <h3 class="mb-4">Edit Concept</h3>
    <form action="update_concept.jsp" method="post">
        <input type="hidden" name="concept_id" value="<%=id%>">

        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" value="<%=title%>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="5" required><%=description%></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Subject</label>
            <select name="subject_id" class="form-select" required>
                <option value="1" <%= subject_id==1 ? "selected" : "" %>>Signals</option>
                <option value="2" <%= subject_id==2 ? "selected" : "" %>>Circuits</option>
                <option value="3" <%= subject_id==3 ? "selected" : "" %>>Mechanics</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Image URL</label>
            <input type="text" name="image_url" class="form-control" value="<%=image_url%>">
        </div>

        <div class="mb-3">
            <label class="form-label">Video URL</label>
            <input type="text" name="video_url" class="form-control" value="<%=video_url%>">
        </div>

        <div class="mb-3">
            <label class="form-label">PDF URL</label>
            <input type="text" name="pdf_url" class="form-control" value="<%=pdf_url%>">
        </div>

        <div class="mb-3">
            <label class="form-label">Chart Page</label>
            <select name="chart_page" class="form-select">
                <option value="">None</option>
                <option value="signals_chart.jsp" <%= "signals_chart.jsp".equals(chart_page) ? "selected" : "" %>>Signals Chart</option>
                <option value="circuits_chart.jsp" <%= "circuits_chart.jsp".equals(chart_page) ? "selected" : "" %>>Circuits Chart</option>
                <option value="mechanics_chart.jsp" <%= "mechanics_chart.jsp".equals(chart_page) ? "selected" : "" %>>Mechanics Chart</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Animation / 3D Page</label>
            <select name="animation_page" class="form-select">
                <option value="">None</option>
                <option value="signals_3d_model.jsp" <%= "signals_3d_model.jsp".equals(animation_page) ? "selected" : "" %>>Signals 3D</option>
                <option value="circuits_3d_model.jsp" <%= "circuits_3d_model.jsp".equals(animation_page) ? "selected" : "" %>>Circuits 3D</option>
                <option value="mechanics_3d_model.jsp" <%= "mechanics_3d_model.jsp".equals(animation_page) ? "selected" : "" %>>Mechanics 3D</option>
            </select>
        </div>

        <button type="submit" class="btn btn-success">Update Concept</button>
        <a href="view_concepts.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
