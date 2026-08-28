<%
Integer sid = (Integer)session.getAttribute("user_id");
String role = (String)session.getAttribute("role");

if(sid == null || role == null || !role.equals("student")){
    response.sendRedirect("../login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Signals Visual Learning</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
background:#f1f5f9;
font-family:Arial;
}

.box{
background:white;
padding:25px;
border-radius:12px;
box-shadow:0 5px 12px rgba(0,0,0,.1);
margin-bottom:30px;
}

canvas{
max-height:300px;
}

.anim{
width:100%;
height:10px;
background:#e5e7eb;
overflow:hidden;
border-radius:6px;
}

.anim-bar{
height:10px;
width:0;
background:#2563eb;
animation: load 3s infinite;
}

@keyframes load{
0%{width:0;}
50%{width:100%;}
100%{width:0;}
}
</style>
</head>

<body class="container py-4">

<h3 class="mb-4">Signals & Systems – Visual Learning</h3>

<div class="box">
<h5>1. Continuous Time Signal</h5>
<canvas id="signalChart"></canvas>
</div>

<div class="box">
<h5>2. Discrete Time Signal</h5>
<canvas id="discreteChart"></canvas>
</div>

<div class="box">
<h5>3. Signal Processing Animation</h5>
<div class="anim">
<div class="anim-bar"></div>
</div>
<p class="mt-2">This animation represents signal flow through a system.</p>
</div>

<a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>

<script>

const t = [];
const x = [];

for(let i=0;i<=360;i+=20){
    t.push(i);
    x.push(Math.sin(i*Math.PI/180));
}

new Chart(document.getElementById('signalChart'), {
    type: 'line',
    data: {
        labels: t,
        datasets: [{
            label: 'x(t) = sin(t)',
            data: x,
            fill: false,
            tension: 0.4
        }]
    }
});

const n = [];
const y = [];

for(let i=0;i<=10;i++){
    n.push(i);
    y.push(Math.random()*2);
}

new Chart(document.getElementById('discreteChart'), {
    type: 'bar',
    data: {
        labels: n,
        datasets: [{
            label: 'Discrete Signal x[n]',
            data: y
        }]
    }
});
</script>

</body>
</html>
