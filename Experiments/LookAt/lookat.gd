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
    
    # TODO: Is there any reason to normalize the down vector?
    var up_vector: Vector3 = -down_vector
    
    
    
    body.look_at(look_target.global_position, up_vector)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
