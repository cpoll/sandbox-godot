extends CharacterBody3D

var rot = Vector2.ZERO;
var sensitivity = Vector2.ONE;
var vel = 0

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    
func _unhandled_input(event: InputEvent) -> void:
    print(event)
    if Input.is_action_just_pressed("quit"):
        get_tree().quit()
    
    if Input.is_action_pressed("forward"):
        vel = 10
    else:
        vel = 0
    
    if (event is InputEventMouseMotion):
        rot -= event.relative * sensitivity
        
        if(abs(rot.x) > 360.0):
            rot.x = 0.0;
        
        if(abs(rotation.y) > 89.9):
            rot.y = sign(rot.y) * 89.9
            
    
func _physics_process(_delta):        
    global_rotation_degrees = Vector3(rot.y, rot.x, 0)
    velocity = -global_transform.basis.z.normalized() * vel
    move_and_slide()
