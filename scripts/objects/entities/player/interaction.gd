extends Node3D

var _nearest_interaction: Interactable:
	get:
		return _current_interactions.front()

var _current_interactions: Array[Interactable] = []
var _can_interact: bool = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and _can_interact:
		if _current_interactions:
			_can_interact = false
			_nearest_interaction.set_highlight(false)

			await _nearest_interaction.interact.call()

			_can_interact = true


func _physics_process(_delta: float) -> void:
	if _current_interactions.is_empty():
		return

	if _can_interact:
		var last_nearest: Interactable = _nearest_interaction
		_current_interactions.sort_custom(_sort_by_nearest)
		if _nearest_interaction != last_nearest:
			last_nearest.set_highlight(false)

		if _nearest_interaction.is_interactable:
			_nearest_interaction.set_highlight(true)
	else:
		_nearest_interaction.set_highlight(false)


func _sort_by_nearest(a: Node3D, b: Node3D) -> bool:
	var a_dist: float = global_position.distance_to(a.global_position)
	var b_dist: float = global_position.distance_to(b.global_position)
	return a_dist < b_dist


func _on_interact_range_area_entered(area: Interactable) -> void:
	_current_interactions.push_back(area)


func _on_interact_range_area_exited(area: Interactable) -> void:
	_current_interactions.erase(area)
	area.set_highlight(false)
