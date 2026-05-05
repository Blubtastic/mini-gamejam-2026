extends Node3D


@onready var pushable_door: RigidBody3D = $PushableDoor

## The door can't be moved if it is frozen.
@export var is_frozen := false

## If set to anything else than 0, picking up a card with this ID unlocks the door.
@export var open_by_card_id := 0

func _ready() -> void:
	pushable_door.freeze = is_frozen


func open() -> void:
	pushable_door.freeze = false

# Open door if player is close and has correct card
func _on_detect_player_body_entered(body: Node3D) -> void:
	if body is Playable:
		if open_by_card_id in body.held_cards:
			pushable_door.freeze = false
