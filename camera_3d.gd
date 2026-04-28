extends Camera3D

@export var target: Node3D  # Assign your player node in the inspector
@export var height: float = 3.0  # Fixed camera height
@export var follow_speed: float = 10.0  # Smooth follow speed

func _process(delta: float) -> void:
	if not target:
		return

	var target_pos: Vector3 = target.global_transform.origin

	# Keep camera's own Y, follow player's X and Z
	var desired_pos: Vector3 = Vector3(target_pos.x, height, target_pos.z)

	# Smoothly interpolate camera position
	global_transform.origin = global_transform.origin.lerp(desired_pos, follow_speed * delta)
