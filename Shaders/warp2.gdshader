shader_type spatial;

/**
 * Base Color
 * [b]boop[/b]
*/
uniform vec3 base_color : source_color = vec3(1.0, 0.0, 0.0);


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
    ALBEDO = base_color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
