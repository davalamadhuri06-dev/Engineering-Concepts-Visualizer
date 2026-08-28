<%@ page import="java.sql.*" %>
<%
Integer student_id = (Integer) session.getAttribute("user_id");
String role = (String) session.getAttribute("role");

if(student_id == null || role == null || !role.equals("student")){
    response.sendRedirect("../login.jsp");
    return;
}

String concept_id = request.getParameter("concept_id");
if(concept_id == null){
    response.sendRedirect("dashboard.jsp");
    return;
}

String message = "";
if(request.getMethod().equalsIgnoreCase("POST")){
    String feedback_text = request.getParameter("feedback");

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eng","root","madhu");

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO feedback(student_id, concept_id, message) VALUES(?,?,?)"
        );
        ps.setInt(1, student_id);
        ps.setInt(2, Integer.parseInt(concept_id));
        ps.setString(3, feedback_text);
        ps.executeUpdate();

        con.close();
        message = "Feedback submitted successfully!";
    }catch(Exception e){
        message = "Error: "+e.getMessage();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Submit Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body{background:#f8f9fa;}
        .container{max-width:600px;margin-top:50px;background:#fff;padding:30px;border-radius:10px;box-shadow:0 0 10px rgba(0,0,0,0.1);}
    </style>
</head>
<body>
<div class="container">
    <h3 class="mb-4">Submit Feedback</h3>

    <% if(!message.isEmpty()){ %>
        <div class="alert alert-info"><%=message%></div>
    <% } %>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">Your Feedback</label>
            <textarea name="feedback" class="form-control" rows="5" required></textarea>
        </div>
        <button type="submit" class="btn btn-success">Submit</button>
        <a href="view_concept.jsp?id=<%=concept_id%>" class="btn btn-secondary">Back</a>
    </form>
</div>
</body>
</html>
