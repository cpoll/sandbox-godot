# Cribbed from https://www.youtube.com/watch?v=a9BiDC0xT-4
extends RigidBody3D

@onready var rays = get_tree().get_nodes_in_group("Raycasts")

var speed = 15000
var turn_speed = 2000
var reverse_speed = 10000
var hover_force = 500

func _physics_process(delta):
	for ray in rays:
		ray.force_raycast_update()
		if ray.is_colliding():
			var collision_point = ray.get_collision_point()
			var dist = collision_point.distance_to(ray.global_transform.origin)
			
			# hover
			apply_force(
				Vector3.UP * (1/dist) * hover_force * delta, 
				ray.global_transform.origin - global_transform.origin)

	# move
	if Input.is_action_pressed("forward"):
		apply_central_force(-global_transform.basis.z * speed * delta)
	
	if Input.is_action_pressed("backwards"):
		apply_central_force(global_transform.basis.z * speed * delta)
	

	# rotate
	if Input.is_action_pressed("right"):
		apply_torque(-global_transform.basis.y * turn_speed * delta)

	if Input.is_action_pressed("left"):
		apply_torque(global_transform.basis.y * turn_speed * delta)
