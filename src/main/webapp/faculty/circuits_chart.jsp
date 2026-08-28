<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Circuits – V I Graph</title>

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

<h4>Ohm's Law – Voltage vs Current</h4>

Resistance (Ω)
<input type="number" id="r" value="10" class="form-control">

<br>

Voltage (V)
<input type="range" min="0" max="50" value="5" id="v">

<span id="vv">5</span> V

<canvas id="chart" height="120"></canvas>

</div>

<script>

let ctx = document.getElementById("chart");

let dataPoints = [];

let chart = new Chart(ctx,{
    type:'line',
    data:{
        labels:[],
        datasets:[{
            label:'Current (A)',
            data:[],
            fill:false,
            tension:0.2
        }]
    }
});

function update(){

    let R = parseFloat(document.getElementById("r").value);
    let V = parseFloat(document.getElementById("v").value);

    document.getElementById("vv").innerText = V;

    let I = V / R;

    chart.data.labels.push(V);
    chart.data.datasets[0].data.push(I);

    if(chart.data.labels.length > 20){
        chart.data.labels.shift();
        chart.data.datasets[0].data.shift();
    }

    chart.update();
}

document.getElementById("v").addEventListener("input",update);

</script>

</body>
</html>
