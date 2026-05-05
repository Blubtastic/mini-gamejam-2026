extends RigidBody3D
class_name Player

@onready var pingvin: Node3D = $Pingvin
@onready var jetpack: Node3D = $Pingvin/jetpack
var lerped_direction := Vector3.ZERO
var acceleration_force := 1000.0
var max_speed := 6.0
var linear_damp_value := 6.0
@export var movement_enabled := true
var held_cards := []
var fuel := 0.0

# TODO: enable code below and see if it affects gravity
#func _ready() -> void:
	#linear_damp = linear_damp_value  # Helps slow down when no input


func _physics_process(delta: float) -> void:
	jetpack.visible = true if fuel > 0 else false

	# Apply force in input direction
	if movement_enabled:
		var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction != Vector3.ZERO:
			apply_central_force(direction * acceleration_force)
			lerped_direction = lerped_direction.lerp(direction, 30*delta)
			pingvin.look_at(pingvin.global_position + lerped_direction)

		# Jetpack force
		if Input.is_action_pressed(&"jump") and fuel > 0.0:
			var new_fuel := fuel - 5*delta
			fuel = new_fuel if new_fuel > 0.0 else 0.0
			apply_central_force(Vector3(0,1,0) * 500)

		# TODO: Find a better way to solve this.
		# Clamp max speed (BAD SOLUTION!!)
		#if linear_velocity.length() > max_speed:
			#linear_velocity = linear_velocity.normalized() * max_speed


func enable_movement(enable: bool) -> void:
	movement_enabled = enable


func _on_hit_area_body_entered(body: Node3D) -> void:
	if body.name == "PushableDoor":
		body.apply_force(-pingvin.basis.z * 200.0)


func add_held_card(card_id: int) -> void:
	if card_id not in held_cards:
		held_cards.append(card_id)


func add_fuel(amount: float) -> void:
	fuel += amount
