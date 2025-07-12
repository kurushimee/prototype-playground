class_name Interactable
extends Area3D


## (abstract) A base class for all interactables.
##
## Handles the logic on interaction and the highlight outline of the interactable.

@export var can_interact: bool = true

@export_group("Nodes")
## The meshes to which the highlight outline will apply.
@export var _meshes: Array[MeshInstance3D]

@onready var _outline_material: Material = preload("res://shaders/outline/outline_material.tres")


## (abstract) Performs the interaction.
func interact() -> void:
	pass


func set_highlight(enable: bool) -> void:
	for mesh: MeshInstance3D in _meshes:
		mesh.material_overlay = _outline_material if enable else null
