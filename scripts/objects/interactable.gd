class_name Interactable
extends Area3D

@export var can_interact: bool = true

@export_group("Nodes")
## The object's meshes that will be used for applying the outline shader to.
@export var _meshes: Array[MeshInstance3D]

@onready var _outline_material: Material = preload("res://shaders/outline/outline_material.tres")


## (abstract) Performs the interaction.
func interact() -> void:
	pass


## Enables or disables the outline shader depending on [param enable].
func set_highlight(enable: bool) -> void:
	for mesh: MeshInstance3D in _meshes:
		mesh.material_overlay = _outline_material if enable else null
