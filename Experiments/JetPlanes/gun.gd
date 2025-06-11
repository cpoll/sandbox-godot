extends Node3D

func _unhandled_input(event: InputEvent) -> void:
    if Input.is_action_just_pressed("shoot"):
        # Raycast outwards checking if we hit something
        
        
        # Draw a line between us and the thing we hit (or maxrange if we missed)
        # We can make a custom mesh to draw the line (ImmediateMesh?)
        # Maybe https://www.youtube.com/watch?v=JnrhURF1jgM
        pass
