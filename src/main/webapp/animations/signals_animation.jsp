<!DOCTYPE html>
<html>
<head>
<title>Signals Animation Lab</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
    font-family:Arial;
    background:#f4f6f9;
    padding:15px;
}
canvas{
    background:white;
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

<h4>Signals – Real Time Signal Animation</h4>

Amplitude :
<input type="number" id="amp" value="1" step="0.1">

Frequency :
<input type="number" id="freq" value="1" step="0.1">

<button onclick="start()">Run</button>

<br><br>

<canvas id="chart"></canvas>

</div>

<script>

let chart;
let t=0;

function start(){

    let ctx = document.getElementById('chart');

    let dataX = [];
    let dataY = [];

    for(let i=0;i<100;i++){
        dataX.push(i);
        dataY.push(0);
    }

    if(chart) chart.destroy();

    chart = new Chart(ctx,{
        type:'line',
        data:{
            labels:dataX,
            datasets:[{
                label:'Signal',
                data:dataY,
                borderWidth:2,
                tension:0.3
            }]
        },
        options:{
            animation:false,
            scales:{
                y:{min:-5,max:5}
            }
        }
    });

    run();
}

function run(){

    let A = parseFloat(document.getElementById("amp").value);
    let f = parseFloat(document.getElementById("freq").value);

    let y = A * Math.sin(2*Math.PI*f*t);

    chart.data.datasets[0].data.shift();
    chart.data.datasets[0].data.push(y);

    t += 0.05;

    chart.update();

    requestAnimationFrame(run);
}

start();

</script>

</body>
</html>
