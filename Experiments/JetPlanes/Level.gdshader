shader_type spatial;

uniform sampler2D noise;

void vertex() {
	// Called for every vertex the material is visible on.
    VERTEX.y = texture(noise, UV).r * 10.0;
}

void fragment() {
	// Called for every pixel the material is visible on.
    ALBEDO = vec3(0.5, 0.5, 0.4) * 0.6 - texture(noise, UV).xyz * 0.4;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
