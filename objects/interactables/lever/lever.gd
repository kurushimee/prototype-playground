extends Interactable

@export var toggled := false

@onready var animation_player: AnimationPlayer = $"lever-single2/AnimationPlayer"


func interact() -> void:
	animation_player.play(&"toggle-off" if toggled else &"toggle-on")
	toggled = not toggled
