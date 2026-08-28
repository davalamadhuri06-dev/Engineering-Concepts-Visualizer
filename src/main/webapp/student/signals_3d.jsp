<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Signals 3D Wave</title>
<style>
body{margin:0;background:#000;}
</style>
</head>
<body>

<script type="module">
import * as THREE from 'https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.module.js';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(60,innerWidth/innerHeight,0.1,1000);
const renderer = new THREE.WebGLRenderer({antialias:true});
renderer.setSize(innerWidth,innerHeight);
document.body.appendChild(renderer.domElement);

camera.position.z=6;

const points=[];
for(let i=0;i<100;i++){
    let x=i/10-5;
    points.push(new THREE.Vector3(x,0,0));
}

let geometry=new THREE.BufferGeometry().setFromPoints(points);
let material=new THREE.LineBasicMaterial({color:0x00ffff});
let line=new THREE.Line(geometry,material);
scene.add(line);

let t=0;

function animate(){

    let arr=geometry.attributes.position.array;

    for(let i=0;i<100;i++){
        arr[i*3+1]=Math.sin(i*0.3+t);
    }

    geometry.attributes.position.needsUpdate=true;

    t+=0.05;

    renderer.render(scene,camera);
    requestAnimationFrame(animate);
}

animate();
</script>
</body>
</html>
