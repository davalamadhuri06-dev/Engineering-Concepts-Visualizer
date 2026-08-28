<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Signals – Real Time Signal</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
    font-family:Arial;
    background:#f4f6f9;
    padding:10px;
}
.card{
    background:white;
    padding:15px;
    border-radius:8px;
    max-width:900px;
    margin:auto;
}
.controls input{
    width:120px;
}
</style>
</head>
<body>

<div class="card">

<h4>Signals Lab – Real Time Sine Wave</h4>

<div class="controls">
Amplitude :
<input type="number" id="amp" value="1" step="0.5">

Frequency :
<input type="number" id="freq" value="1" step="0.5">

<button onclick="start()">Start</button>
<button onclick="stop()">Stop</button>
</div>

<br>

<canvas id="chart" height="120"></canvas>

<hr>

<!-- simple animation -->
<canvas id="anim" width="500" height="80" style="border:1px solid #ccc"></canvas>

</div>

<script>

let t=0;
let timer=null;

const ctx = document.getElementById("chart");

const chart = new Chart(ctx,{
    type:'line',
    data:{
        labels:[],
        datasets:[{
            label:'Signal',
            data:[],
            tension:0.3
        }]
    },
    options:{
        animation:false,
        scales:{
            x:{title:{display:true,text:'Time'}},
            y:{title:{display:true,text:'Amplitude'}}
        }
    }
});

function start(){

    if(timer) clearInterval(timer);

    chart.data.labels=[];
    chart.data.datasets[0].data=[];
    t=0;

    timer = setInterval(drawSignal,200);
}

function stop(){
    clearInterval(timer);
}

function drawSignal(){

    let A = parseFloat(document.getElementById("amp").value);
    let f = parseFloat(document.getElementById("freq").value);

    let y = A * Math.sin(2 * Math.PI * f * t / 20);

    chart.data.labels.push(t);
    chart.data.datasets[0].data.push(y);

    if(chart.data.labels.length>50){
        chart.data.labels.shift();
        chart.data.datasets[0].data.shift();
    }

    chart.update();

    drawAnimation(y);

    t++;
}

/* simple signal animation */

function drawAnimation(y){

    let c = document.getElementById("anim");
    let g = c.getContext("2d");

    g.clearRect(0,0,c.width,c.height);

    let mid = c.height/2;

    let x = (t*10)%c.width;

    g.beginPath();
    g.arc(x, mid - y*20 , 6 ,0,2*Math.PI);
    g.fillStyle="#0d6efd";
    g.fill();
}

</script>

</body>
</html>
