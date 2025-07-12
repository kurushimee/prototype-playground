@icon("res://assets/icons/door.png")
class_name Door
extends AnimatableBody3D
## A node used for animated physical doors.

signal opened
signal closed

@export var _is_open: bool = false:
	set = set_is_open

@export_group("Nodes")
@export var _animation_player: AnimationPlayer


## Takes [param new_state] to determine which animation to play
## and correctly change [member _is_open].
func set_is_open(new_state: bool) -> void:
	_is_open = new_state

	if new_state:
		_animation_player.play(&"open", 0.25)
		opened.emit()
	else:
		_animation_player.play(&"close", 0.25)
		closed.emit()


## Calls [method set_is_open] to open the door.
func open() -> void:
	set_is_open(true)


## Calls [method set_is_open] to close the door.
func close() -> void:
	set_is_open(false)


## Calls [method set_is_open] to open the door if closed, otherwise close it.
func toggle() -> void:
	set_is_open(!_is_open)
