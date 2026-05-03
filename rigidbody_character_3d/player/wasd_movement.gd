extends RigidBody3D
class_name Player

@onready var pingvin: Node3D = $Pingvin
var lerped_direction := Vector3.ZERO
var acceleration_force := 10000.0
var max_speed := 6.0
var linear_damp_value := 6.0
@export var movement_enabled := true


func _ready() -> void:
	linear_damp = linear_damp_value  # Helps slow down when no input


func _physics_process(delta: float) -> void:
	# Apply force in input direction
	if movement_enabled:
		var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction != Vector3.ZERO:
			apply_central_force(direction * acceleration_force)
			lerped_direction = lerped_direction.lerp(direction, 30*delta)
			pingvin.look_at(pingvin.global_position + lerped_direction)
		# Clamp max speed
		if linear_velocity.length() > max_speed:
			linear_velocity = linear_velocity.normalized() * max_speed


func enable_movement(enable: bool) -> void:
	movement_enabled = enable


func _on_hit_area_body_entered(body: Node3D) -> void:
	if body.name == "PushableDoor":
		body.apply_force(-pingvin.basis.z * 200.0)
