## A node used for animated physical doors.
@icon("res://objects/door/assets/icon.png")
class_name Door
extends AnimatableBody3D

signal opened
signal closed

@export var is_open := false:
	set = set_is_open

@export var animation_player: AnimationPlayer


## Takes [param new_state] to determine which animation to play
## and correctly change [member is_open].
func set_is_open(new_state: bool) -> void:
	is_open = new_state
	if new_state:
		animation_player.play(&"open")
		opened.emit()
	else:
		animation_player.play(&"close")
		closed.emit()


## Calls [method set_is_open] to open the door.
func open() -> void:
	set_is_open(true)


## Calls [method set_is_open] to close the door.
func close() -> void:
	set_is_open(false)


## Calls [method set_is_open] to open the door if closed, otherwise close it.
func toggle() -> void:
	set_is_open(!is_open)
