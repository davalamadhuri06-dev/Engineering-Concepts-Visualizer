<!DOCTYPE html>
<html>
<head>
<title>Circuits Animation Lab</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
    font-family:Arial;
    background:#f4f6f9;
    padding:15px;
}
.box{
    background:white;
    padding:15px;
    border-radius:8px;
}
</style>
</head>
<body>

<div class="box">

<h4>Circuits – RC Charging Animation</h4>

Resistance (ohms):
<input type="number" id="R" value="1000">

Capacitance (farads):
<input type="number" id="C" value="0.001" step="0.0001">

<button onclick="start()">Simulate</button>

<br><br>

<canvas id="cchart"></canvas>

</div>

<script>

let chart;
let t=0;
let timer;

function start(){

    let R = parseFloat(document.getElementById("R").value);
    let C = parseFloat(document.getElementById("C").value);

    let labels=[];
    let data=[];

    if(chart) chart.destroy();

    chart = new Chart(document.getElementById("cchart"),{
        type:"line",
        data:{
            labels:labels,
            datasets:[{
                label:"Capacitor Voltage",
                data:data,
                borderWidth:2,
                tension:0.3
            }]
        },
        options:{
            animation:false,
            scales:{
                y:{min:0,max:5}
            }
        }
    });

    t=0;
    clearInterval(timer);

    timer = setInterval(function(){

        let V = 5*(1-Math.exp(-t/(R*C)));

        chart.data.labels.push(t.toFixed(2));
        chart.data.datasets[0].data.push(V);

        if(chart.data.labels.length>50){
            chart.data.labels.shift();
            chart.data.datasets[0].data.shift();
        }

        chart.update();

        t+=0.1;

    },100);
}

</script>

</body>
</html>
