class_name Interactable
extends Area3D

@export var is_interactable: bool = true

@export_group("Nodes")
## The meshes to which the highlight outline will apply.
@export var _meshes: Array[MeshInstance3D]

var interact := func() -> void: pass

@onready var _outline_material: Material = preload("res://shaders/outline/outline_material.tres")


func set_highlight(enable: bool) -> void:
	for mesh in _meshes:
		mesh.material_overlay = _outline_material if enable else null
