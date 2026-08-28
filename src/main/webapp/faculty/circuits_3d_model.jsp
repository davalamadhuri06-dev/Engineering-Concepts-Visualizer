<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Circuits 3D Model</title>
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
const dl=new THREE.DirectionalLight(0xffffff,1);
dl.position.set(5,5,5);
scene.add(dl);

const loader=new GLTFLoader();
loader.load(
    './models/pcb.glb',
    g=>{
        scene.add(g.scene);
    },
    undefined,
    e=>{
        // fallback circuit
        const base=new THREE.Mesh(
            new THREE.BoxGeometry(4,0.2,3),
            new THREE.MeshStandardMaterial({color:0x003300})
        );
        scene.add(base);

        for(let i=0;i<5;i++){
            const comp=new THREE.Mesh(
                new THREE.BoxGeometry(0.3,0.3,0.6),
                new THREE.MeshStandardMaterial({color:0xffaa00})
            );
            comp.position.set(-1.5+i*0.7,0.3,0);
            scene.add(comp);
        }
    }
);

function animate(){
    scene.rotation.y+=0.002;
    renderer.render(scene,camera);
    requestAnimationFrame(animate);
}
animate();
</script>
</body>
</html>
