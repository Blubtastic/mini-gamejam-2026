extends Node3D

@onready var camera_3d: Camera3D = $Camera3D
var target_fov := 90.0


func _process(delta: float) -> void:
	camera_3d.fov = lerp(camera_3d.fov, target_fov, delta*20)
