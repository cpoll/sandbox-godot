shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_lambert, specular_schlick_ggx;


// Varyings
varying vec3 var_WorldPos;

uniform vec4 base_color : source_color = vec4(0.541729, 0.965740, 0.914706, 1.000000);



void vertex() {
	var_WorldPos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;

    // So, what's localPos?
}

void fragment() {
// Output:0
	ALBEDO = vec3(base_color.xyz);
	ALPHA = var_WorldPos.g;
	ALPHA_SCISSOR_THRESHOLD = 0.5;
}
