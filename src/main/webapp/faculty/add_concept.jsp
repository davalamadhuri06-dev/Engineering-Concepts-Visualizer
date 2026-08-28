<%@ page import="java.sql.*" %>
<%
Integer faculty_id = (Integer) session.getAttribute("user_id");
String role = (String) session.getAttribute("role");

if(faculty_id == null || role == null || !role.equals("faculty")){
    response.sendRedirect("../login.jsp");
    return;
}

// Ensure subjects exist
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eng","root","madhu");
Statement st = con.createStatement();
st.executeUpdate("INSERT IGNORE INTO subjects(subject_id, subject_name) VALUES (1,'Signals'),(2,'Circuits'),(3,'Mechanics')");
con.close();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Concept</title>
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
    </style>
</head>
<body>

<div class="sidebar">
    <h3>Faculty Panel</h3>
    <ul>
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="add_concept.jsp">Add Concept</a></li>
        <li><a href="view_concepts.jsp">My Concepts</a></li>
        <li><a href="student_feedback.jsp">Student Feedback</a></li>
        
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</div>

<div class="main-content">
    <h2>Add New Concept</h2>
    <form action="save_concept.jsp" method="post">
        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="5" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Subject</label>
            <select name="subject_id" class="form-control" required>
                <option value="">Select Subject</option>
                <option value="1">Signals</option>
                <option value="2">Circuits</option>
                <option value="3">Mechanics</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Image URL</label>
            <input type="text" name="image_url" class="form-control" placeholder="https://example.com/image.jpg">
        </div>

        <div class="mb-3">
            <label class="form-label">Video URL</label>
            <input type="text" name="video_url" class="form-control" placeholder="https://www.youtube.com/embed/...">
        </div>

        <div class="mb-3">
            <label class="form-label">PDF URL</label>
            <input type="text" name="pdf_url" class="form-control" placeholder="https://example.com/file.pdf">
        </div>

        <div class="mb-3">
            <label class="form-label">Chart Page URL</label>
            <input type="text" name="chart_page" class="form-control" placeholder="chart.html">
        </div>

        <div class="mb-3">
            <label class="form-label">Animation Page URL (3D)</label>
            <input type="text" name="animation_page" class="form-control" placeholder="animation.html">
        </div>

        <button type="submit" class="btn btn-success">Save Concept</button>
    </form>
</div>

</body>
</html>
