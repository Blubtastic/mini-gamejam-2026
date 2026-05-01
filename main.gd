extends Node3D

@export var end: Area3D

func _ready() -> void:
	end.body_entered.connect(on_end_entered)


func on_end_entered(_body: Node3D) -> void:
	print("game over")
