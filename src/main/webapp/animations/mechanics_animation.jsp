<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Mechanics – 3D Motion Animation</title>

<style>
body{
    margin:0;
    overflow:hidden;
    font-family:Arial;
}
#panel{
    position:absolute;
    top:10px;
    left:10px;
    background:#ffffffcc;
    padding:10px;
    border-radius:8px;
}
</style>

</head>
<body>

<div id="panel">
<b>Mechanics – Particle Motion</b><br>
Velocity:
<input type="range" id="v" min="1" max="10" value="5">
<span id="vv">5</span>
</div>

<script src="https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.min.js"></script>

<script>

let scene = new THREE.Scene();
scene.background = new THREE.Color(0xeeeeee);

let camera = new THREE.PerspectiveCamera(
    60, window.innerWidth/window.innerHeight, 0.1, 1000
);

let renderer = new THREE.WebGLRenderer({antialias:true});
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

camera.position.set(0,4,8);

/* light */
scene.add(new THREE.AmbientLight(0xffffff,0.7));

let d = new THREE.DirectionalLight(0xffffff,0.6);
d.position.set(5,5,5);
scene.add(d);

/* floor */
let floor = new THREE.Mesh(
    new THREE.PlaneGeometry(20,20),
    new THREE.MeshStandardMaterial({color:0xcccccc})
);
floor.rotation.x = -Math.PI/2;
scene.add(floor);

/* moving object */
let ball = new THREE.Mesh(
    new THREE.SphereGeometry(0.5,32,32),
    new THREE.MeshStandardMaterial({color:0x0077ff})
);
ball.position.y = 0.5;
scene.add(ball);

let speed = 0.05;
let x = -8;

document.getElementById("v").oninput = function(){
    speed = this.value * 0.01;
    document.getElementById("vv").innerText = this.value;
}

function animate(){

    requestAnimationFrame(animate);

    x += speed;
    if(x > 8) x = -8;

    ball.position.x = x;

    renderer.render(scene,camera);
}

animate();

window.onresize = function(){
    camera.aspect = window.innerWidth/window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth,window.innerHeight);
}

</script>

</body>
</html>
