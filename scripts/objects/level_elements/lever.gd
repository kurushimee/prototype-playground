extends Node3D

signal pulled

@export var _is_toggled: bool = false

@export_group("Nodes")
@export var _animation_player: AnimationPlayer
@export var _interactable: Interactable


func _ready() -> void:
	_interactable.interact = _on_interact


func _on_interact() -> void:
	_animation_player.play(&"toggle-off" if _is_toggled else &"toggle-on")
	_is_toggled = not _is_toggled
	pulled.emit()
