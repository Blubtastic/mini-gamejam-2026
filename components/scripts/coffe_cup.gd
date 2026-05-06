extends Node3D

@export var speed_multiplier := 3.0
@export var duration := 1.2
@onready var kaffekopp: Node3D = $kaffekopp
var rotation_speed := 1.5

func _physics_process(delta: float) -> void:
	# Rotate around the Y axis
	kaffekopp.rotate_y(rotation_speed * delta)


func _on_body_entered(body: Node3D) -> void:
	if body is Playable:
		body.drink_coffee(speed_multiplier, duration)
		queue_free()
