extends Area3D

@export var fuel_amount := 10.0
@onready var fuel_mesh: Node3D = $fuel
var rotation_speed := 1.5

func _physics_process(delta: float) -> void:
	# Rotate around the Y axis
	fuel_mesh.rotate_y(rotation_speed * delta)


func _on_body_entered(body: Node3D) -> void:
	if body is Playable:
		body.add_fuel(fuel_amount)
		queue_free()
