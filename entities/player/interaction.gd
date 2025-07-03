extends Area3D

## The current [Interactable] object closest to [Player].[br]
## Calls [method Interactable.set_highlight] appropriately when changing the value.
var current_interactable: Interactable:
	set(value):
		if current_interactable:
			current_interactable.set_highlight(false)

		current_interactable = value
		if current_interactable:
			current_interactable.set_highlight(true)

## Contains all [Interactable] objects within interaction range.
var nearby_interactables: Array[Interactable] = []


func _input(event):
	if event.is_action_pressed(&"interact"):
		interact()


func _on_area_entered(area: Area3D) -> void:
	if area is Interactable:
		var interactable := area as Interactable
		nearby_interactables.append(interactable)

		find_closest_interactable()


func _on_area_exited(area: Area3D) -> void:
	if area is Interactable:
		var interactable := area as Interactable
		nearby_interactables.erase(interactable)

		find_closest_interactable()


## Finds the closest [Interactable] nearby and sets it to [member current_interactable].
func find_closest_interactable() -> void:
	var best: Interactable = null
	var best_distance: float = INF

	for interactable in nearby_interactables:
		if not interactable.can_interact:
			continue

		var distance := global_position.distance_to(interactable.global_position)
		if distance < best_distance:
			best = interactable
			best_distance = distance

	current_interactable = best


## Tries to interact with the currently chosen interactable.
func interact():
	if current_interactable:
		current_interactable.interact()
