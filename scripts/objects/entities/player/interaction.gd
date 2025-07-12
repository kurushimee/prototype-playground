extends Area3D

signal interacted

## The current [Interactable] object closest to [Player].[br]
## Calls [method _set_current_interactable] to change the value.
var _current_interactable: Interactable:
	set = _set_current_interactable

## Contains all [Interactable] objects within interaction range.
var _nearby_interactables: Array[Interactable]


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"interact"):
		_interact()


func _on_area_entered(area: Area3D) -> void:
	if area is Interactable:
		_nearby_interactables.append(area as Interactable)
		_find_closest_interactable()


func _on_area_exited(area: Area3D) -> void:
	if area is Interactable:
		_nearby_interactables.erase(area as Interactable)
		_find_closest_interactable()


func _set_current_interactable(new_interactable: Interactable) -> void:
	if _current_interactable:
		_current_interactable.set_highlight(false)

	if new_interactable:
		new_interactable.set_highlight(true)

	_current_interactable = new_interactable


## Finds the closest [Interactable] nearby and sets it to [member _current_interactable].
func _find_closest_interactable() -> void:
	var best: Interactable = null
	var best_distance: float = INF

	for interactable: Interactable in _nearby_interactables:
		if not interactable.can_interact:
			continue

		var distance: float = global_position.distance_to(interactable.global_position)

		if distance < best_distance:
			best = interactable
			best_distance = distance

	_current_interactable = best


## Tries to interact with the currently chosen interactable.
func _interact() -> void:
	if _current_interactable:
		_current_interactable.interact()
		interacted.emit()
