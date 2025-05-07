extends MeshInstance3D

@export var grass_plane: MeshInstance3D

var plane_scene = preload("res://Experiments/ShellGrass/GrassPlane.tscn")

func _ready() -> void:
    print(grass_plane)
    for i in range(1, 10):
        var dup = plane_scene.instantiate()
        var plane = dup.get_node("Plane")
        plane.position.x += 5;
        plane.set_instance_shader_parameter("stack_order", i)
        plane.set_instance_shader_parameter("test_color", Vector3(1.0, 0.0, 0.0))
        # dup.mesh.material
        # material.set("shader_parameter/stack_order", i);
        print(plane)
