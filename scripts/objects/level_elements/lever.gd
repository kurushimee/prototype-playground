extends Interactable

signal pulled

@export var _is_toggled: bool = false

@export_group("Nodes")
@export var _animation_player: AnimationPlayer


func interact() -> void:
	_animation_player.play(&"toggle-off" if _is_toggled else &"toggle-on")
	_is_toggled = !_is_toggled
	pulled.emit()
