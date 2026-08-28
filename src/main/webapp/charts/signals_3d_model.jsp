<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Signals 3D Model</title>
<style>
body{margin:0;overflow:hidden;background:#000;}
</style>
</head>
<body>

<script type="module">
import * as THREE from 'https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.module.js';
import { GLTFLoader } from 'https://cdn.jsdelivr.net/npm/three@0.160.0/examples/jsm/loaders/GLTFLoader.js';
import { OrbitControls } from 'https://cdn.jsdelivr.net/npm/three@0.160.0/examples/jsm/controls/OrbitControls.js';

const scene=new THREE.Scene();
scene.background=new THREE.Color(0x000000);

const camera=new THREE.PerspectiveCamera(60,innerWidth/innerHeight,0.1,1000);
camera.position.set(2,2,5);

const renderer=new THREE.WebGLRenderer({antialias:true});
renderer.setSize(innerWidth,innerHeight);
document.body.appendChild(renderer.domElement);

new OrbitControls(camera,renderer.domElement);

// lights
scene.add(new THREE.AmbientLight(0xffffff,0.6));
const d=new THREE.DirectionalLight(0xffffff,1);
d.position.set(5,5,5);
scene.add(d);

// load model (if present)
const loader=new GLTFLoader();
loader.load(
    './models/antenna.glb',
    g=>{
        scene.add(g.scene);
    },
    undefined,
    e=>{
        // fallback
        const geo=new THREE.CylinderGeometry(0.1,0.15,3);
        const mat=new THREE.MeshStandardMaterial({color:0x00ffff});
        const tower=new THREE.Mesh(geo,mat);
        tower.position.y=1.5;
        scene.add(tower);
    }
);

let t=0;
const waveMat=new THREE.LineBasicMaterial({color:0x00ff00});
const wavePts=[];
for(let i=0;i<80;i++) wavePts.push(new THREE.Vector3(i*0.05,0,0));
const waveGeo=new THREE.BufferGeometry().setFromPoints(wavePts);
const wave=new THREE.Line(waveGeo,waveMat);
wave.position.set(-2,1,0);
scene.add(wave);

function animate(){
    const arr=waveGeo.attributes.position.array;
    for(let i=0;i<80;i++){
        arr[i*3+1]=Math.sin(i*0.4+t)*0.3;
    }
    waveGeo.attributes.position.needsUpdate=true;

    t+=0.05;
    renderer.render(scene,camera);
    requestAnimationFrame(animate);
}
animate();
</script>
</body>
</html>
