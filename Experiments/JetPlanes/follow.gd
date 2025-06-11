extends RigidBody3D

var speed = 1
@export var target: Node3D
    
func _physics_process(delta):        
    if not target:
        return
    
    var direction_to_move = (target.global_position - global_position).normalized()
    global_position += direction_to_move * speed * delta
