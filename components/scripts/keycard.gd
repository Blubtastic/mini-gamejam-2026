extends Node3D

@export var card_id := 1
@onready var card: Node3D = $card
var rotation_speed := 1.5

func _physics_process(delta: float) -> void:
	# Rotate around the Y axis
	card.rotate_y(rotation_speed * delta)


func _on_body_entered(body: Node3D) -> void:
	if body is Playable:
		queue_free()
		if body.has_method("add_held_card"):
			body.add_held_card(card_id)
