extends Node3D

@onready var body = $%Body
@onready var look_target = $%LookTarget
@onready var down_target = $%DownTarget


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    
    # Figure out our down vector, i.e. our position relative to the down_target (our mini planet)
    var our_pos: Vector3 = body.global_position
    var down_pos: Vector3 = down_target.global_position
    var down_vector: Vector3 = down_pos - our_pos
    
    # Example: Look_at_2
    var relative_target: Vector3 = look_target.global_position - body.global_position
    body.basis = look_at_2(relative_target, Vector3.UP)
    
    # Example: Align to planet
    align_to_planet(body, down_target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func look_at_2(target: Vector3, up: Vector3) -> Basis:
    '''
    Manually implement Godot's lookat.
    See: https://github.com/godotengine/godot/blob/b957cf7/core/math/basis.cpp#L1033

    Given a target vector (relative to the looker) and an up vector, return a new basis that points to the target.
    '''
    
    # First we point our z-vector (forward vector) to the target.
    # Godot uses the negative z-vector as the forward vector, so we use a negative here.
    var v_z: Vector3 = -target.normalized()
    
    # Then we set our x-vector (left vector) perpendicular to the plane created by our forward vector
    # and the specified up vector.
    var v_x: Vector3 = up.cross(v_z)
    
    # TODO: There's some extra consideration here if the target and up vectors are colinear, leading
    # to a zero-vector for our x-vector.
    
    # Finally, set our y-vector (up vector) perpendicular to our x and z vectors.
    # We can't simply set y-vector to the provided up vector, because our z vector isn't necessarily
    # pointing parallel to the horizon.
    var v_y: Vector3 = v_z.cross(v_x)
    
    return Basis(v_x, v_y, v_z)

func align_to_planet(o: Node3D, target: Node3D) -> void:
    '''
    Given a Node o and a target "planet", points the down vector of that transform to the target.
    Otherwise preserves what o's pointing to.
    
    TODO: This isn't really preserving what o's pointing to... That makes sense, since we're
    not exactly preserving our left vector.
    '''
    
    var down = (target.global_position - o.global_position).normalized()
    
    # Set the new y-vector to point to our planet. I.e. point our feet to the planet
    var v_y = -down
    
    # Set our new left vector to be perpendicular to our feet and the direction we're pointing
    var v_x = v_y.cross(o.basis.z)
    
    # Set our forward vector to be perpendicular to our new x and y vectors.
    # This will preserve which way we're facing in terms of left/right, but won't preserver our
    # tilt. We've essentially snapped to the planet, and we're looking at the horizon.
    var v_z = v_x.cross(v_y)
    
    o.basis = Basis(v_x, v_y, v_z)
    
    
    
