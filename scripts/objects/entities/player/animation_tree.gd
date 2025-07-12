extends AnimationTree

@export_group("Nodes")
@export var _idle_timer: Timer

@onready var _playback: AnimationNodeStateMachinePlayback = get(&"parameters/playback")


func _ready() -> void:
	_reset_timer()


func _on_idle_timer_timeout() -> void:
	set(&"parameters/Idle/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	_reset_timer()


func _on_interaction_interacted() -> void:
	if _playback.get_current_node() == &"Idle":
		_playback.travel(&"Interact")


func _reset_timer() -> void:
	_idle_timer.wait_time = randf_range(5.0, 10.0)
	_idle_timer.start()
