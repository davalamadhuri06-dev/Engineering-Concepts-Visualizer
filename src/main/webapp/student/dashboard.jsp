<%
Integer sid = (Integer)session.getAttribute("user_id");
String role = (String)session.getAttribute("role");

if(sid == null || !"student".equals(role)){
    response.sendRedirect("../login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Student Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:Segoe UI;
    background:#f3f4f6;
}

.sidebar{
    width:230px;
    height:100vh;
    position:fixed;
    background:#0f172a;
    color:white;
}

.sidebar h3{
    padding:18px;
    margin:0;
    background:#020617;
}

.sidebar a{
    display:block;
    padding:14px 18px;
    color:white;
    text-decoration:none;
    transition:0.2s;
}

.sidebar a:hover{
    background:#1e293b;
}

.main{
    margin-left:230px;
    padding:30px;
}

.welcome-card{
    background:white;
    padding:25px;
    border-radius:12px;
    box-shadow:0 4px 10px rgba(0,0,0,0.08);
}

.quick-card{
    background:white;
    padding:20px;
    border-radius:12px;
    box-shadow:0 4px 10px rgba(0,0,0,0.08);
    text-align:center;
    transition:.2s;
}

.quick-card:hover{
    transform:translateY(-4px);
}
</style>
</head>

<body>

<div class="sidebar">
    <h3>Student Panel</h3>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="concepts.jsp">Concepts</a>
    <a href="difficult_concepts.jsp">Difficult Concepts</a>
   
    <a href="logout.jsp">Logout</a>
</div>

<div class="main">

    <div class="welcome-card mb-4">
        <h4>Welcome Student 👋</h4>
        <p class="text-muted mb-0">
            Start learning by exploring approved concepts uploaded by your faculty.
        </p>
    </div>

    <div class="row g-4">

        <div class="col-md-4">
            <div class="quick-card">
                <h5>📘 View Concepts</h5>
                <p class="text-muted">
                    Browse subject-wise concepts and learning materials.
                </p>
                <a href="concepts.jsp" class="btn btn-primary btn-sm">
                    Open Concepts
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="quick-card">
                <h5>💬 Give Feedback</h5>
                <p class="text-muted">
                    Share your feedback on concepts and help improve learning.
                </p>
                <a href="concepts.jsp" class="btn btn-success btn-sm">
                    Give Feedback
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="quick-card">
                <h5>🚪 Logout</h5>
                <p class="text-muted">
                    Safely logout from your account.
                </p>
                <a href="../logout.jsp" class="btn btn-danger btn-sm">
                    Logout
                </a>
            </div>
        </div>

    </div>

</div>

</body>
</html>
