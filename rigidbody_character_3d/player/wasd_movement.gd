extends RigidBody3D

@export var acceleration_force: float = 10.0
@export var max_speed: float = 3.0
@export var linear_damp_value: float = 6.0
@onready var pingvin: Node3D = $Pingvin

func _ready() -> void:
	linear_damp = linear_damp_value  # Helps slow down when no input

func _physics_process(delta: float) -> void:
	var input_dir: Vector3 = Vector3.ZERO

	# Capture input (WASD)
	if Input.is_action_pressed("move_forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("move_back"):
		input_dir.z += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1

	input_dir = input_dir.normalized()

	if input_dir != Vector3.ZERO:
		# Apply force in input direction
		apply_central_force(input_dir * acceleration_force)

	# Clamp max speed
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed


	# Rotate player mesh
	var horizontal_velocity: Vector3 = linear_velocity
	horizontal_velocity.y = 0  # Ignore vertical velocity

	if horizontal_velocity.length() > 0.1:
		var target_dir: Vector3 = horizontal_velocity.normalized()
		# Calculate target rotation (around Y axis)
		var target_rotation: float = atan2(-target_dir.x, -target_dir.z)
		# Smoothly interpolate rotation
		var current_rotation: float = pingvin.rotation.y
		pingvin.rotation.y = lerp_angle(current_rotation, target_rotation, 50 * delta)
