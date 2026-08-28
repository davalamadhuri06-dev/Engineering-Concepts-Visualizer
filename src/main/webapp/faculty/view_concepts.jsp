<%@ page import="java.sql.*" %>
<%
Integer faculty_id = (Integer) session.getAttribute("user_id");
String role = (String) session.getAttribute("role");

if(faculty_id == null || role == null || !role.equals("faculty")){
    response.sendRedirect("../login.jsp");
    return;
}

String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Concepts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { display: flex; min-height: 100vh; margin: 0; font-family: "Segoe UI", sans-serif; background: #f8f9fa; }
        .sidebar { width: 220px; background: #343a40; color: #fff; min-height: 100vh; padding-top: 20px; }
        .sidebar h3 { text-align: center; padding: 20px 0; border-bottom: 1px solid #495057; }
        .sidebar ul { list-style: none; padding: 0; }
        .sidebar ul li { border-bottom: 1px solid #495057; }
        .sidebar ul li a { display: block; padding: 15px 20px; color: #fff; text-decoration: none; }
        .sidebar ul li a:hover { background: #495057; color: #ffc107; }
        .main-content { margin-left: 220px; padding: 30px; flex: 1; }
        table th, table td { vertical-align: middle !important; }
    </style>
</head>
<body>

<div class="sidebar">
    <h3>Faculty Panel</h3>
    <ul>
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="add_concept.jsp">Add Concept</a></li>
        <li><a href="view_concepts.jsp">My Concepts</a></li>
        <li><a href="view_feedback.jsp">Student Feedback</a></li>
        
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</div>

<div class="main-content">
    <h2>My Uploaded Concepts</h2>

    <% if(msg != null){ %>
        <div class="alert alert-success"><%=msg %></div>
    <% } %>

    <table class="table table-bordered table-striped mt-3">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Subject</th>
                <th>Status</th>
                <th>Image</th>
                <th>Video</th>
                <th>PDF</th>
                <th>Chart</th>
                <th>Animation</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eng","root","madhu");

            PreparedStatement ps = con.prepareStatement(
                "SELECT c.concept_id, c.title, s.subject_name, c.status, c.image_url, c.video_url, c.pdf_url, c.chart_page, c.animation_page " +
                "FROM concep c JOIN subjects s ON c.subject_id = s.subject_id " +
                "WHERE c.faculty_id = ?"
            );
            ps.setInt(1, faculty_id);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
        %>
            <tr>
                <td><%= rs.getInt("concept_id") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("subject_name") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <% String img = rs.getString("image_url");
                       if(img != null && !img.isEmpty()){ %>
                        <a href="<%=img%>" target="_blank">View</a>
                    <% } %>
                </td>
                <td>
                    <% String vid = rs.getString("video_url");
                       if(vid != null && !vid.isEmpty()){ %>
                        <a href="<%=vid%>" target="_blank">Watch</a>
                    <% } %>
                </td>
                <td>
                    <% String pdf = rs.getString("pdf_url");
                       if(pdf != null && !pdf.isEmpty()){ %>
                        <a href="<%=pdf%>" target="_blank">Open PDF</a>
                    <% } %>
                </td>
                <td>
                    <% String chart = rs.getString("chart_page");
                       if(chart != null && !chart.isEmpty()){ %>
                        <a href="<%=chart%>" target="_blank">Open Chart</a>
                    <% } %>
                </td>
                <td>
                    <% String anim = rs.getString("animation_page");
                       if(anim != null && !anim.isEmpty()){ %>
                        <a href="<%=anim%>" target="_blank">Open Animation</a>
                    <% } %>
                </td>
                <td>
                    <a href="edit_concept.jsp?id=<%=rs.getInt("concept_id")%>" class="btn btn-sm btn-warning mb-1">Edit</a>
                    <a href="delete_concept.jsp?id=<%=rs.getInt("concept_id")%>" class="btn btn-sm btn-danger mb-1" 
                       onclick="return confirm('Are you sure to delete this concept?');">Delete</a>
                </td>
            </tr>
        <%
            }

            con.close();
        } catch(Exception e){
            out.println("<tr><td colspan='10' style='color:red;'>Error: "+e.getMessage()+"</td></tr>");
        }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
