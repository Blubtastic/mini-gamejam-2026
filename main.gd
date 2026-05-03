extends Node3D


const UI_END = preload("uid://0c1myc43nfbv")
@onready var player: Player = $Player
@onready var ui_start: Control = $ui_start
@export var end: Area3D
var has_ended := false


func _ready() -> void:
	end.body_entered.connect(on_end_entered)
	ui_start.start_pressed.connect(on_start_pressed)


func on_end_entered(body: Node3D) -> void:
	if body is RigidBody3D and body is Player and !has_ended:
		has_ended = true
		player.enable_movement(false)
		var instance := UI_END.instantiate()
		add_child(instance)


func on_start_pressed() -> void:
	player.enable_movement(true)
