extends Area3D

@onready var button: MeshInstance3D = $Button
var pressed_position := Vector3(0, -0.5, 0)


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		button.position = pressed_position
