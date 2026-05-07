extends Node3D


@onready var smoke: CPUParticles3D = $Smoke
@onready var fire: CPUParticles3D = $Fire


func start_particles() -> void:
	smoke.emitting = true
	fire.emitting = true
func stop_particles() -> void:
	smoke.emitting = false
	fire.emitting = false
