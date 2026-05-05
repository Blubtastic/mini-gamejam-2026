extends Node3D

@onready var kaffekopp: Node3D = $kaffekopp
var rotation_speed := 1.5

func _process(delta: float) -> void:
	# Rotate around the Y axis
	kaffekopp.rotate_y(rotation_speed * delta)


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.drink_coffee()
		queue_free()
