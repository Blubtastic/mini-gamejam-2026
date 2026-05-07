extends Node3D


@onready var player: Playable = $Player
@onready var ui_start: Control = $ui_start


func _ready() -> void:
	ui_start.start_pressed.connect(on_start_pressed)

func on_start_pressed() -> void:
	player.enable_movement(true)
