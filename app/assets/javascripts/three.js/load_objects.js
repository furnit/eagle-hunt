function load_texture(file) {
  var texture = new THREE.Texture();
  var loader = new THREE.ImageLoader();
  loader.load(file, function ( image ) {
    texture.image = image;
    texture.needsUpdate = true;
    // repeat the texture
    texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
  });
  return texture;
}

function set_texture(object, texture) {
  object.traverse( function ( child ) {
    if ( child instanceof THREE.Mesh ) {
      child.material.map = texture;
    }
  });
}

function load_objects(models, callback) {
  var objects = {};
  for (var name in models) {
    setTimeout(function(model, id) {
      var texture = load_texture(model.texture);
    	// load a resource
    	 new THREE.OBJLoader().load(
    		// resource URL
    		model.file,
    		// Function when resource is loaded
    		function ( object ) {
          objects[id] = object;
          set_texture(object, texture);
          if(Object.keys(objects).length === Object.keys(models).length && typeof callback === "function")
            callback(objects);
    		}
    	);
    }, 10, models[name], name);
  }
}
