// https://www.youtube.com/watch?v=6-eIEFPcvrU
// https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html

shader_type spatial;

// Can be modified in editor or code
uniform float wave_height;

// Ripple
void vertex() {
    
    // Squish to half-size on X
    //VERTEX.x *= 0.5;
    
    // VERTEX.x and Y are between -0.5 and 0.5
    // TODO: Is this true for all shapes/meshes?
    // See: https://learnopengl.com/Getting-started/Coordinate-Systems "Local Space"
    if(VERTEX.x > 0.45) {
        VERTEX.y = 0.5;
    }
    if(VERTEX.x < -0.45) {
        VERTEX.y = -0.5;
    }
    
    
    // VERTEX.x += sin(TIME * 5.0) * 0.2;
    //VERTEX.y += sin(TIME * 5.0 + VERTEX.x * 10.0) * wave_height;
    
}

// Bouncy
//void vertex() {
    //VERTEX.y += sin(TIME * 5.0) * 0.2;
//}

//void fragment() {
    //// Sin goes from -1 to 1, so we shift it to 0 - 1; can we do this better with step/smoothstep?)
    //ALBEDO = vec3( (sin(TIME*5.0) + 1.0) * 0.5, 0.0, 0.0);
//}

// Rainbow
void fragment() {
    vec3 color;
    color.r = (sin(TIME * 6.0 + VERTEX.x * 10.0) + 1.0) * 0.5;
    color.g = (sin(TIME * 7.0 + VERTEX.x * 10.0) + 1.0) * 0.5;
    color.b = (sin(TIME * 8.0 + VERTEX.x * 10.0) + 1.0) * 0.5;
    ALBEDO = color;
}

// Vertex-based coloring:
//void fragment() {
    //vec3 color = vec3(1.0, 0.0, 0.0);
    //color.r = VERTEX.x * 0.4;
    //ALBEDO = color;
//}