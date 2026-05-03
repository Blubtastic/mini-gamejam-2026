extends Node3D

@onready var pushable_door: RigidBody3D = $PushableDoor
@export var is_frozen := false

func _ready() -> void:
	pushable_door.freeze = is_frozen


func open() -> void:
	pushable_door.freeze = false
