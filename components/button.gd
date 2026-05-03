extends Area3D

var is_pressed := false
var pressed_position := Vector3(0, -0.5, 0)
@onready var poof: GPUParticles3D = $Poof
@onready var button_mesh: MeshInstance3D = $Button
@export var thing_to_open: Node3D


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		button_mesh.position = pressed_position
		if thing_to_open.has_method("open"):
			thing_to_open.open()
		if !is_pressed:
			is_pressed = true
			poof.restart()
