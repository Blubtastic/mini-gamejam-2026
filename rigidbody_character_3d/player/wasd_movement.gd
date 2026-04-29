extends RigidBody3D

var lerped_direction := Vector3.ZERO
@onready var pingvin := $Pingvin
@export var acceleration_force := 1000.0
@export var max_speed := 9.0
@export var linear_damp_value := 6.0

func _ready() -> void:
	linear_damp = linear_damp_value  # Helps slow down when no input


func _physics_process(delta: float) -> void:
	# Apply force in input direction
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction != Vector3.ZERO:
		apply_central_force(direction * acceleration_force)
		lerped_direction = lerped_direction.lerp(direction, 30*delta)
		pingvin.look_at(pingvin.global_position + lerped_direction)
	# Clamp max speed
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

	# Rotate player by direction of movement instead of input
	#var horizontal_movement := Vector3(linear_velocity.x, 0, linear_velocity.z)
	#if horizontal_movement.length() > 0.1:
		#pingvin.look_at(pingvin.global_position + horizontal_movement.normalized())
