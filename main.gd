extends Node3D
const UI_END = preload("uid://0c1myc43nfbv")

@export var end: Area3D

func _ready() -> void:
	end.body_entered.connect(on_end_entered)


func on_end_entered(body: Node3D) -> void:
	if body is RigidBody3D and body is Player:
		var instance := UI_END.instantiate()
		add_child(instance)
