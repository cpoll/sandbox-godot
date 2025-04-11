shader_type spatial;
render_mode cull_disabled;

varying vec3 local_position;

/**
Threshold between 0.5 and -0.5. 0.5 is fully visible, -0.5 is fully gone.
The object will warp/dissolve from top to bottom.
*/
uniform float threshold = 0.0;

void vertex() {
	// Pass the local vertex position to the fragment shader
	local_position = VERTEX;
    // world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	if (local_position.y > threshold) {
        // TODO: Next step is multiply some perlin noise on the edge?
        // Maybe add it to the local_position.y. If it's too far it won't do anything, if it's close it'll set it solid only if the noise
        // is solid.

        // Also remember, you can multiply two black-or-white textures to get the intersection...
		ALPHA = 0.0;
	} else {
		ALPHA = 1.0;
	}

    // Essential. WTF Does this do? It makes ALPHA all-or-nothing, which somehow stops the Z-fighting.
    // The z-fighting is something to do with the cull_disabled setting.
    ALPHA_SCISSOR_THRESHOLD = 0.5;

    if(!FRONT_FACING) {
        ALBEDO = vec3(0.2, 0.2, 0.2);
    }

}




//
//shader_type spatial;
//
///**
 //* Base Color
 //* [b]boop[/b]
//*/
//uniform vec3 base_color : source_color = vec3(1.0, 0.0, 0.0);
//
//
//void vertex() {
	//// Called for every vertex the material is visible on.
//}
//
//void fragment() {
	//// Called for every pixel the material is visible on.
    //ALBEDO = base_color;
//}
