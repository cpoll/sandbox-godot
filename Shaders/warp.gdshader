shader_type spatial;
// render_mode cull_disabled;
render_mode cull_disabled;

varying vec3 local_position;

void vertex() {
	// Pass the local vertex position to the fragment shader
	local_position = VERTEX;
}

void fragment() {
	float threshold = 0.0; // Adjust this value to control the transparency boundary
	if (local_position.y > threshold) {
		ALPHA = 0.0; // Fully transparent
	} else {
		ALPHA = 1.0; // Fully opaque
	}

    //if(!FRONT_FACING) {
        //ALBEDO = vec3(0.0, 0.0, 0.0);
        //DEPTH = -100.0;
    //}

}
