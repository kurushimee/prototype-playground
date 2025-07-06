@icon("res://objects/door/assets/icon.png")
class_name Door
extends AnimatableBody3D

## Describes whether the door is opened or closed.
## true if open, false if closed.
@export var state := false: set = set_state

@export var animation_player: AnimationPlayer


## Takes [param new_state] to determine which animation to play
## and correctly change the [member state].
func set_state(new_state: bool) -> void:
	var animation_name := &"open" if new_state else &"close"
	animation_player.play(animation_name)
	state = new_state


## Calls [method set_state] to open the door.
func open() -> void:
	set_state(true)


## Calls [method set_state] to close the door.
func close() -> void:
	set_state(false)


## Calls [method set_state] to open the door if closed, otherwise close it.
func toggle() -> void:
	set_state(!state)
