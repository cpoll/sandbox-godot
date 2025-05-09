extends MeshInstance3D

@export var grass_plane: MeshInstance3D

var plane_scene = preload("res://Experiments/ShellGrass/GrassPlane.tscn")

func _ready() -> void:
    
    for i in range(0, 40):
        print(i)
        var dup = plane_scene.instantiate()
        add_child(dup)
        dup.position = Vector3(0, 0.003*i, 0)
        var plane = dup.get_node("Plane")
        plane.set_instance_shader_parameter("stack_order", i)
        ## dup.mesh.material
        ## material.set("shader_parameter/stack_order", i);
        #print(plane)
