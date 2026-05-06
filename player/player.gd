extends RigidBody3D

class_name Playable

@onready var camera: Node3D = $CameraPivot
@onready var thruster_1: Node3D = $Pingvin/Particles/Thruster1
@onready var thruster_2: Node3D = $Pingvin/Particles/Thruster2
@onready var pingvin: Node3D = $Pingvin
@onready var jetpack: Node3D = $Pingvin/jetpack
var lerped_direction := Vector3.ZERO
var held_cards := []
var fuel := 0.0
var speed_multiplier := 1.0
@export var movement_enabled := true
@export var jetpack_force := 40000.0

func _physics_process(delta: float) -> void:
	jetpack.visible = true if fuel > 0 else false
	var acceleration_force := 200000.0 * speed_multiplier
	var max_speed := 10.0 * speed_multiplier

	# Apply force in input direction
	if movement_enabled:
		var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		var xy_linear_velocity := Vector3(linear_velocity.x, 0, linear_velocity.z)
		if direction != Vector3.ZERO and xy_linear_velocity.length() < max_speed:
			apply_central_force(direction * acceleration_force*delta)
			lerped_direction = lerped_direction.lerp(direction, 50*delta)
			pingvin.look_at(pingvin.global_position + lerped_direction)
		else:
			if xy_linear_velocity.length() > 0.01:
				var drag_force := -xy_linear_velocity.normalized() * acceleration_force / 10
				apply_central_force(drag_force*3*delta)
		# Jetpack force
		if Input.is_action_pressed(&"jump") and fuel > 0.0:
			var new_fuel := fuel - 5*delta
			fuel = new_fuel if new_fuel > 0.0 else 0.0
			apply_central_force(Vector3(0,1,0) * jetpack_force*delta)
			thruster_1.start_particles()
			thruster_2.start_particles()
		else:
			thruster_1.stop_particles()
			thruster_2.stop_particles()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset_position"):
		get_tree().reload_current_scene()

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

func drink_coffee(speed_mult: float = 3.0, duration: float = 1.2) -> void:
	speed_multiplier = speed_mult
	camera.target_fov = 100.0
	await get_tree().create_timer(duration).timeout
	speed_multiplier = 1.0
	camera.target_fov = 90.0
