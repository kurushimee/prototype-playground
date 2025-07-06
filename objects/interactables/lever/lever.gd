extends Interactable

signal pulled

@export var is_toggled := false

@onready var animation_player: AnimationPlayer = $"lever-single2/AnimationPlayer"


func interact() -> void:
	animation_player.play(&"toggle-off" if is_toggled else &"toggle-on")
	is_toggled = !is_toggled
	pulled.emit()
