shader_type spatial;

/**
* Used for w/h of field. 
*/
// uniform int density;

uniform sampler2D noise : filter_nearest;

/**
 * Order on the plane stack for grass elements. 0 is the base of the grass.
 */
instance uniform int stack_order;

// https://www.shadertoy.com/view/4djSRW
float hash12(vec2 p)
{
	vec3 p3  = fract(vec3(p.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

float hash13(vec3 p3)
{
	p3  = fract(p3 * .1031);
    p3 += dot(p3, p3.zyx + 31.32);
    return fract((p3.x + p3.y) * p3.z);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

// Get rid of the most significant part of the float, essentially zooming in
vec2 tile(vec2 _st, float _zoom){
    _st *= _zoom;
    return fract(_st);
}

void fragment() {
    // ALBEDO = vec3(0.0, 1.0, 0.0);
    
    //if(UV.x < 0.5) {
        //ALBEDO = vec3(1.0, 0.0, 0.0);
    //}
    

    
    vec2 p = UV;
    
    // Squish the x/y into 10 segments, then color the even ones. I.e. round to the nearest 0.1
    //p.x = fract(p.x * 10.0);
    //if(p.x > 0.5) {
        //ALBEDO = vec3(0.0, 0.0, 1.0);
    //}
    
    // Round the position
    p.x = round(p.x * 100.0) / 100.0;
    p.y = round(p.y * 100.0) / 100.0;
    
    // float grass_value = texture(noise, UV * 10.0).r;
    float grass_value = hash12(p * 50.0);

    if(grass_value - 0.1 * float(stack_order) > 0.3){
        ALBEDO = vec3(0.0, grass_value / 2.0 - float(stack_order) / 10.0, 0.0);
    } else {
        discard;
    }    

    //vec3 space = VERTEX * 1000000000.0;
    //if(hash13(space) < 0.5) {
        //ALBEDO = vec3(1.0, 0.0, 0.0);
    //}
    
    //vec2 space2 = UV * 10.0;
    //if(hash12(space2) < 0.5) {
        //ALBEDO = vec3(1.0, 0.0, 0.0);
    //}
    //
    
    

}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
