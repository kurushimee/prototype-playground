class_name Interactable
extends Area3D

@export var can_interact := true

@export_group("Outline")
@export var meshes: Array[MeshInstance3D]
@export var outline_material: Material


## Performs the interaction.
func interact() -> void:
	pass


## Enables or disables the outline shader depending on [param value].
func set_highlight(value: bool) -> void:
	if value:
		for mesh in meshes:
			mesh.material_overlay = outline_material
	else:
		for mesh in meshes:
			mesh.material_overlay = null
