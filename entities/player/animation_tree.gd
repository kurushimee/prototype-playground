extends AnimationTree

@onready var idle_timer: Timer = $IdleTimer
@onready var playback: AnimationNodeStateMachinePlayback = get(&"parameters/playback")


func _ready() -> void:
	reset_timer()


func _on_idle_timer_timeout() -> void:
	set(&"parameters/Idle/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	reset_timer()


func _on_interaction_interacted() -> void:
	# Plays the interact animation only from idle
	if playback.get_current_node() == &"Idle":
		playback.travel(&"Interact")


func reset_timer() -> void:
	idle_timer.wait_time = randf_range(5.0, 10.0)
	idle_timer.start()
