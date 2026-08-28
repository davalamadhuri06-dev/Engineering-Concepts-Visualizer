<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Mechanics – Distance vs Time</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
    font-family:Arial;
    padding:10px;
    background:#f5f7fa;
}
.box{
    background:white;
    padding:15px;
    border-radius:8px;
    max-width:800px;
    margin:auto;
}
</style>
</head>
<body>

<div class="box">

<h4>Uniform Motion – Distance vs Time</h4>

Velocity (m/s)
<input type="number" id="v" value="2">

<button onclick="start()">Start</button>

<canvas id="chart" height="120"></canvas>

</div>

<script>

let t = 0;
let timer = null;

let ctx = document.getElementById("chart");

let chart = new Chart(ctx,{
    type:'line',
    data:{
        labels:[],
        datasets:[{
            label:'Distance (m)',
            data:[],
            tension:0.2
        }]
    }
});

function start(){

    if(timer) clearInterval(timer);

    chart.data.labels=[];
    chart.data.datasets[0].data=[];

    t = 0;

    let v = parseFloat(document.getElementById("v").value);

    timer = setInterval(function(){

        let s = v * t;

        chart.data.labels.push(t);
        chart.data.datasets[0].data.push(s);

        chart.update();

        t++;

        if(t>20) clearInterval(timer);

    },1000);
}

</script>

</body>
</html>
