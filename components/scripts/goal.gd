extends Area3D

const UI_END = preload("uid://0c1myc43nfbv")
var has_ended := false


func _on_body_entered(body: Node3D) -> void:
	if body is RigidBody3D and body is Playable and !has_ended:
		has_ended = true
		body.enable_movement(false)
		var instance := UI_END.instantiate()
		add_child(instance)
