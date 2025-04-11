shader_type spatial;
render_mode cull_disabled;


// Varyings
varying vec3 var_WorldPos;

uniform vec4 base_color : source_color = vec4(0.541729, 0.965740, 0.914706, 1.000000);
uniform sampler2D perlin : filter_nearest;

/**
 * Set between 0.0 and 1.0
 */
uniform float burn_thresh = 0.0;

void vertex() {
	var_WorldPos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
// Output:0
	// ALBEDO = vec3(base_color.xyz);
    //ALBEDO = texture(perlin, UV).rgb;

    float a = texture(perlin, UV).r;
    ALPHA = a;

    // If the alpha is only slightly above the burn_thresh, color it red to look like a burning edge
    // TODO: This can be a step or something, right?
    if(a > burn_thresh && a < (burn_thresh+0.1)) {
        ALBEDO = vec3(1.0, 0.0, 0.0);
    }


   // ALPHA = var_WorldPos.g;
	ALPHA_SCISSOR_THRESHOLD = burn_thresh;
}
