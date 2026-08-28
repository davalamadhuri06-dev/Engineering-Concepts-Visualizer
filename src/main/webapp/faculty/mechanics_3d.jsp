<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Mechanics 3D Pendulum</title>
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
camera.position.y=2;

const pivot=new THREE.Vector3(0,2,0);

const rodGeom=new THREE.CylinderGeometry(0.03,0.03,3);
const rodMat=new THREE.MeshBasicMaterial({color:0xffffff});
const rod=new THREE.Mesh(rodGeom,rodMat);

const bob=new THREE.Mesh(
    new THREE.SphereGeometry(0.3),
    new THREE.MeshNormalMaterial()
);

scene.add(rod);
scene.add(bob);

let t=0;

function animate(){

    let angle=Math.sin(t)*0.8;

    rod.position.set(
        Math.sin(angle)*1.5,
        2-Math.cos(angle)*1.5,
        0
    );
    rod.rotation.z=angle;

    bob.position.set(
        Math.sin(angle)*3,
        2-Math.cos(angle)*3,
        0
    );

    t+=0.02;

    renderer.render(scene,camera);
    requestAnimationFrame(animate);
}

animate();
</script>
</body>
</html>
