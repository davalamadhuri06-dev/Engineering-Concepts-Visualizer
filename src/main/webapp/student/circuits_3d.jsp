<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Circuits 3D</title>
<style>body{margin:0;background:#000;}</style>
</head>
<body>

<script type="module">
import * as THREE from 'https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.module.js';

const scene=new THREE.Scene();
const camera=new THREE.PerspectiveCamera(60,innerWidth/innerHeight,0.1,1000);
const renderer=new THREE.WebGLRenderer({antialias:true});
renderer.setSize(innerWidth,innerHeight);
document.body.appendChild(renderer.domElement);

camera.position.z=6;

const mat=new THREE.MeshNormalMaterial();

const resistor=new THREE.Mesh(new THREE.BoxGeometry(1,0.4,0.4),mat);
resistor.position.x=-2;

const capacitor=new THREE.Mesh(new THREE.CylinderGeometry(0.2,0.2,1),mat);
capacitor.rotation.z=Math.PI/2;

const inductor=new THREE.Mesh(new THREE.TorusGeometry(0.3,0.1,16,40),mat);
inductor.position.x=2;

scene.add(resistor);
scene.add(capacitor);
scene.add(inductor);

function animate(){

    inductor.rotation.y+=0.05;
    capacitor.rotation.x+=0.03;
    resistor.rotation.y+=0.01;

    renderer.render(scene,camera);
    requestAnimationFrame(animate);
}
animate();
</script>
</body>
</html>
