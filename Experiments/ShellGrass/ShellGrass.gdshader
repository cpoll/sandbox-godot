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
    // 55.514432 -> 55.51 
    p.x = round(p.x * 100.0) / 100.0;
    p.y = round(p.y * 100.0) / 100.0;
    
    // The remainder will be everything after two decimal places
    // E.g. 0.004432
    // We also multiply by 100 to get a number between 0 and 1.
    // We'll use this later to determine how far our pixel is from the center (0.5, 0.5)
    // This seems reasonable, but we're botching the hash function somehow?
    vec2 remainder = (UV - p) * 100.0;
    
    
    // float grass_value = texture(noise, UV * 10.0).r;
    float grass_value = hash12(p * 50.0);

    //if(grass_value - 1.0 * float(stack_order / 40) > 0.7){
        //ALBEDO = vec3(0.1, 0.2, 0.1);
    //} else {
        //discard;
    //}
    
    // Grass value is between 0 and 1
    // stack_order is 0-40 (TODO: Pass it in)
    // Stack order 0 is at the bottom, and we want grass to render bottom-to-top
    // Incidentally, will the top plane always be < 0.5? Should we randomize separately?
    // Or rather, isn't grass_value already height?
    
    if(grass_value * float(40-stack_order)/40.0 > 0.5){
        // See if the sub-blade-of-grass (remainder) is incide a circle of r 0.5 centered on 0.5,0.5
        // This should round off our grass
        // We just get the absolute distance between the two points
        
        // This is wrong, run it to see why. It gets less accurate in the corners...
        float dist = abs(p.x - remainder.x) + abs(p.y - remainder.y);
        if(dist > 1.5) {
            discard;
        } else {
            ALBEDO = vec3(0.1, 0.2, 0.1);
        }
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
