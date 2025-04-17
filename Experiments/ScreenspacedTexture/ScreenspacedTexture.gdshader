shader_type spatial;
render_mode unshaded;

/**
* Texture to use for screenspaced background. CompressedTexture2D with an image is usually good.
*/
uniform sampler2D screenspaced_texture;
uniform float tiling_scale = 1.0;

void fragment() {
    // Pick which part of the screenspaced_texture to draw based on our screen position (FRAGCOORD)
    
    // TODO: If instead of using FRAGCOORD, we use a uniform position (object's position) that we set, would that look nicer?
    // Using world_position calculated in vector() looks off because it gets wrapped around the sphere.
	vec2 uv = FRAGCOORD.xy;
	vec2 tiling_uv = uv / tiling_scale;
	vec4 result = texture(screenspaced_texture, tiling_uv);
    
	ALBEDO = result.rgb;
	ALPHA = result.a;
}
