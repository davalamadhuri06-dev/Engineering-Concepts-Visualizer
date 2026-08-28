<%@ page import="java.sql.*" %>
<%
Integer student_id = (Integer) session.getAttribute("user_id");
String role = (String) session.getAttribute("role");

if(student_id == null || role == null || !role.equals("student")){
    response.sendRedirect("../login.jsp");
    return;
}

String concept_id = request.getParameter("id");
if(concept_id == null){
    response.sendRedirect("dashboard.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Concept</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r148/three.min.js"></script>
    <style>
        body{background:#f8f9fa;}
        .container{margin-top:50px;}
        .concept-card{background:#fff;padding:20px;border-radius:10px;box-shadow:0 0 10px rgba(0,0,0,0.1);}
        iframe{border:none;}
    </style>
</head>
<body>
<div class="container">
<%
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eng","root","madhu");

    PreparedStatement ps = con.prepareStatement(
        "SELECT c.title,c.description,s.subject_name,c.image_url,c.video_url,c.pdf_url,c.chart_page,c.animation_page " +
        "FROM concep c JOIN subjects s ON c.subject_id=s.subject_id " +
        "WHERE c.concept_id=? AND c.status='approved'"
    );
    ps.setInt(1,Integer.parseInt(concept_id));

    ResultSet rs = ps.executeQuery();
    if(rs.next()){
        String title = rs.getString("title");
        String description = rs.getString("description");
        String subject = rs.getString("subject_name");
        String image_url = rs.getString("image_url");
        String video_url = rs.getString("video_url");
        String pdf_url = rs.getString("pdf_url");
        String chart_page = rs.getString("chart_page");
        String animation_page = rs.getString("animation_page");
%>

<div class="concept-card">
    <h3><%=title%></h3>
    <p><b>Subject:</b> <%=subject%></p>
    <hr>
    <p><%=description%></p>

    <% if(image_url != null && !image_url.isEmpty()){ %>
        <h6>Image</h6>
        <img src="<%=image_url%>" class="img-fluid mb-3">
    <% } %>

    <% if(video_url != null && !video_url.isEmpty()){ %>
        <h6>Video</h6>
        <div class="ratio ratio-16x9 mb-3">
            <iframe src="<%=video_url%>" allowfullscreen></iframe>
        </div>
    <% } %>

    <% if(pdf_url != null && !pdf_url.isEmpty()){ %>
        <h6>PDF</h6>
        <a href="<%=pdf_url%>" target="_blank" class="btn btn-outline-primary mb-3">Open PDF</a>
    <% } %>

    <% if(chart_page != null && !chart_page.isEmpty()){ %>
        <h6>Chart / Graph</h6>
        <iframe src="<%=chart_page%>" width="100%" height="400px"></iframe>
    <% } %>

    <% if(animation_page != null && !animation_page.isEmpty()){ %>
        <h6>3D Animation</h6>
        <iframe src="<%=animation_page%>" width="100%" height="400px"></iframe>
    <% } %>

    <hr>
    <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    <a href="feedback.jsp?concept_id=<%=concept_id%>" class="btn btn-success">Give Feedback</a>
</div>

<%
    } else {
%>
    <p class="text-danger">Concept not available or not approved yet.</p>
<%
    }

    con.close();
}catch(Exception e){
    out.println("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
}
%>
</div>
</body>
</html>
