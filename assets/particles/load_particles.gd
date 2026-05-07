extends Node3D


## Start emitting ALL particle nodes in scene.
func _ready() -> void:
	var children := get_all_descendants(self)
	for child in children:
		if child is GPUParticles3D or child is CPUParticles3D:
			child.emitting = true
	await get_tree().create_timer(0.5).timeout
	queue_free()


func get_all_descendants(node: Node) -> Array[Node]:
	var descendants: Array[Node] = []
	for child in node.get_children():
		descendants.append(child)
		descendants += get_all_descendants(child)
	return descendants
