<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Mechanics 3D Model</title>
<style>body{margin:0;overflow:hidden;background:#000;}</style>
</head>
<body>

<script type="module">
import * as THREE from 'https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.module.js';
import { GLTFLoader } from 'https://cdn.jsdelivr.net/npm/three@0.160.0/examples/jsm/loaders/GLTFLoader.js';
import { OrbitControls } from 'https://cdn.jsdelivr.net/npm/three@0.160.0/examples/jsm/controls/OrbitControls.js';

const scene=new THREE.Scene();
scene.background=new THREE.Color(0x000000);

const camera=new THREE.PerspectiveCamera(60,innerWidth/innerHeight,0.1,1000);
camera.position.set(3,3,6);

const renderer=new THREE.WebGLRenderer({antialias:true});
renderer.setSize(innerWidth,innerHeight);
document.body.appendChild(renderer.domElement);

new OrbitControls(camera,renderer.domElement);

scene.add(new THREE.AmbientLight(0xffffff,0.6));
const l=new THREE.DirectionalLight(0xffffff,1);
l.position.set(4,6,4);
scene.add(l);

const loader=new GLTFLoader();
loader.load(
    './models/mechanism.glb',
    g=>{
        scene.add(g.scene);
    },
    undefined,
    e=>{
        // fallback crank slider
        const base=new THREE.Mesh(
            new THREE.BoxGeometry(4,0.2,2),
            new THREE.MeshStandardMaterial({color:0x444444})
        );
        scene.add(base);

        const wheel=new THREE.Mesh(
            new THREE.CylinderGeometry(0.7,0.7,0.2,32),
            new THREE.MeshStandardMaterial({color:0x00aaff})
        );
        wheel.rotation.x=Math.PI/2;
        wheel.position.y=0.7;
        scene.add(wheel);

        function anim(){
            wheel.rotation.z+=0.02;
            renderer.render(scene,camera);
            requestAnimationFrame(anim);
        }
        anim();
        return;
    }
);

function animate(){
    renderer.render(scene,camera);
    requestAnimationFrame(animate);
}
animate();
</script>
</body>
</html>
