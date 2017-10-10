function build_scene_info(dom) {
  return {
    dom: dom,
    size: {
      w: dom.clientWidth,
      h: dom.clientHeight
    }
  };
}

function init_scene(dom) {
  var container = build_scene_info(dom);
  // make a scene and camera
  var scene = new THREE.Scene();
  var camera = new THREE.PerspectiveCamera( 75, container.size.w / container.size.h , 0.1, 1000 );
  // define the renderer
  var renderer = new THREE.WebGLRenderer();
  renderer.setSize(container.size.w, container.size.h);
  // append the renderer scene
  container.dom.appendChild( renderer.domElement );

  // set camera position
  camera.position.z = 100;
  // add ambien light
  scene.add(new THREE.AmbientLight( 0x404040 ));

  // define trackball controls
	controls = new THREE.TrackballControls( camera, container.dom );
	controls.rotateSpeed = 1.0;
	controls.zoomSpeed = 1.2;
	controls.noZoom = false;
	controls.noPan = false;
	controls.staticMoving = true;
	controls.dynamicDampingFactor = 0.3;
	controls.keys = [ 65, 83, 68 ];
	controls.addEventListener( 'change', function() {
    // remove the previous light if any exists
    if(typeof directionalLight !== "undefined")
      scene.remove(directionalLight);
    // make directional light align with the camera view
    directionalLight = new THREE.DirectionalLight( 0xffffff , 1);
  	directionalLight.position.set(camera.position.x, camera.position.y, camera.position.z);
    directionalLight.target.position.set( 0, 0, 0 );
    scene.add(directionalLight);
    renderer.render( scene, camera );
  });
  // triger the initial lighting event to the scene
  controls.dispatchEvent(new Event('change'));

  return {
    scene: scene,
    camera: camera,
    renderer: renderer,
    controls: controls,
    container: container
  };
}
