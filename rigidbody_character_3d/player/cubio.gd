extends RigidBody3D

@onready var shape_cast: ShapeCast3D = $ShapeCast3D
@onready var camera: Camera3D = $Target/Camera3D
@onready var start_position := position

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed(&"exit"):
		get_tree().quit()
	if Input.is_action_just_pressed(&"reset_position") or global_position.y < -6.0:
		# Pressed the reset key or fell off the ground.
		position = start_position
		linear_velocity = Vector3.ZERO
		# We teleported the player on the lines above. Reset interpolation
		# to prevent it from interpolating from the old player position
		# to the new position.
		reset_physics_interpolation()

	var dir := Vector3()
	dir.x = Input.get_axis(&"move_left", &"move_right")
	dir.z = Input.get_axis(&"move_forward", &"move_back")

	# Get the camera's transform basis, but remove the X rotation such
	# that the Y axis is up and Z is horizontal.
	var cam_basis := camera.global_transform.basis
	cam_basis = cam_basis.rotated(cam_basis.x, -cam_basis.get_euler().x)
	dir = cam_basis * dir

	# Air movement.
	apply_central_impulse(dir.normalized() * 5.0 * delta)

	var max_speed: float = 7.0
	var deceleration_force: float = 100.0
	if on_ground():
		# Ground movement (higher acceleration).
		if dir != Vector3.ZERO:
			if linear_velocity.length() < max_speed:
				apply_central_impulse(dir.normalized() * 60.0 * delta)
		else:
			if linear_velocity.length() > 0.2:
				var decel_dir: Vector3 = -linear_velocity.normalized()
				apply_central_force(decel_dir * deceleration_force)
			else:
				linear_velocity = Vector3.ZERO


		# Jumping code.
		# It's acceptable to set `linear_velocity` here as it's only set once, rather than continuously.
		# Vertical speed is set (rather than added) to prevent jumping higher than intended
		# if the ShapeCast3D collides for multiple frames.
		if Input.is_action_pressed(&"jump"):
			linear_velocity.y = 7


# Test if there is a body below the player.
func on_ground() -> bool:
	return shape_cast.is_colliding()


func _on_tcube_body_entered(body: Node) -> void:
	if body == self:
		$WinText.visible = true
