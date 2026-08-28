<%@ page import="java.sql.*" %>
<%
Integer student_id = (Integer) session.getAttribute("user_id");
String role = (String) session.getAttribute("role");

if(student_id == null || role == null || !role.equals("student")){
    response.sendRedirect("../login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student - Approved Concepts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: "Segoe UI", sans-serif; background: #f8f9fa; padding: 20px; }
        h2 { margin-bottom: 20px; }
        .concept-card { background: #fff; padding: 20px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .concept-card img { max-width: 100%; border-radius: 5px; margin-bottom: 10px; }
        .concept-card iframe { width: 100%; height: 350px; margin-bottom: 10px; }
        .btn { margin-right: 5px; margin-bottom: 5px; }
    </style>
</head>
<body>

<h2>Select Subject to View Approved Concepts</h2>

<!-- Subject Dropdown -->
<form method="get" class="mb-4">
    <select name="subject_id" class="form-select" required>
        <option value="">-- Select Subject --</option>
        <%
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eng","root","madhu");
            Statement st = con.createStatement();
            ResultSet rs_sub = st.executeQuery("SELECT * FROM subjects");
            String selectedSub = request.getParameter("subject_id");
            while(rs_sub.next()){
                int subId = rs_sub.getInt("subject_id");
                String subName = rs_sub.getString("subject_name");
        %>
            <option value="<%=subId%>" 
                <%= (selectedSub != null && selectedSub.equals(String.valueOf(subId))) ? "selected" : "" %>>
                <%=subName%>
            </option>
        <%
            }
            con.close();
        }catch(Exception e){ out.println("<p style='color:red;'>Error loading subjects: "+e.getMessage()+"</p>"); }
        %>
    </select>
    <button type="submit" class="btn btn-primary mt-2">View Concepts</button>
</form>

<%
String sub = request.getParameter("subject_id");

/* ✅ FIX-1 : avoid "null" string problem */
if(sub != null && !sub.trim().isEmpty() && !"null".equalsIgnoreCase(sub)){
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eng","root","madhu");

        PreparedStatement ps = con.prepareStatement(
            "SELECT c.concept_id, c.title, c.description, s.subject_name, c.image_url, c.video_url, c.pdf_url, c.chart_page, c.animation_page " +
            "FROM concep c JOIN subjects s ON c.subject_id = s.subject_id " +
            "WHERE c.status='approved' AND s.subject_id=?"
        );

        ps.setInt(1, Integer.parseInt(sub));
        ResultSet rs = ps.executeQuery();

        boolean hasConcepts = false;
        while(rs.next()){
            hasConcepts = true;
            int conceptId = rs.getInt("concept_id");
%>

<div class="concept-card">
    <h3><%= rs.getString("title") %></h3>
    <p><b>Subject:</b> <%= rs.getString("subject_name") %></p>
    <p><%= rs.getString("description") %></p>

    <% String img = rs.getString("image_url");
       if(img != null && !img.isEmpty()){ %>
        <img src="<%=img%>" alt="Concept Image">
    <% } %>

    <% String vid = rs.getString("video_url");
       if(vid != null && !vid.isEmpty()){ %>
        <iframe src="<%=vid%>" allowfullscreen></iframe>
    <% } %>

    <% String pdf = rs.getString("pdf_url");
       if(pdf != null && !pdf.isEmpty()){ %>
        <a href="<%=pdf%>" target="_blank" class="btn btn-outline-primary">Open PDF</a>
    <% } %>

    <% String chart = rs.getString("chart_page");
       if(chart != null && !chart.isEmpty()){ %>
        <iframe src="<%=chart%>" style="width:100%; height:400px; border:none;" class="mb-2"></iframe>
    <% } %>

    <% String anim = rs.getString("animation_page");
       if(anim != null && !anim.isEmpty()){ %>
        <iframe src="<%=anim%>" style="width:100%; height:400px; border:none;" class="mb-2"></iframe>
    <% } %>

    <!-- ✅ FIX-2 + FIX-3 : feedback form -->
    <form method="post" action="submit_feedback.jsp">
        <input type="hidden" name="concept_id" value="<%=conceptId%>">
        <input type="hidden" name="subject_id" value="<%=sub%>">

        <div class="mb-2">
            <label>Feedback:</label>
            <textarea name="feedback" class="form-control" required></textarea>
        </div>
        <button type="submit" class="btn btn-success btn-sm">
            Submit Feedback
        </button>
    </form>
    <form method="post" action="rate_concept.jsp" class="mt-2">
    <input type="hidden" name="concept_id" value="<%=conceptId%>">

    <select name="rating" class="form-select form-select-sm" required>
        <option value="">Difficulty</option>
        <option value="1">Very Easy</option>
        <option value="2">Easy</option>
        <option value="3">Medium</option>
        <option value="4">Hard</option>
        <option value="5">Very Hard</option>
    </select>

    <button class="btn btn-warning btn-sm mt-1">
        Submit Rating
    </button>
</form>
    
    <form method="post" action="mark_completed.jsp">
    <input type="hidden" name="concept_id" value="<%=conceptId%>">
    <button type="submit" class="btn btn-outline-success btn-sm">
        Mark as Completed
    </button>
</form>
    
</div>

<%
        }
        if(!hasConcepts){
            out.println("<p>No approved concepts available for this subject yet.</p>");
        }

        con.close();
    }catch(Exception e){
        out.println("<p style='color:red;'>Error loading concepts: "+e.getMessage()+"</p>");
    }
}
%>

</body>
</html>
