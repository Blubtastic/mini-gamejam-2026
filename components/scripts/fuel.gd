extends Area3D

@onready var fuel: Node3D = $fuel
var rotation_speed := 1.5

func _process(delta: float) -> void:
	# Rotate around the Y axis
	fuel.rotate_y(rotation_speed * delta)


func _on_body_entered(body: Node3D) -> void:
	if body is Playable:
		body.add_fuel(10.0)
		queue_free()
