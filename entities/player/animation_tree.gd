extends AnimationTree

@onready var idle_timer: Timer = $IdleTimer


func _ready() -> void:
	reset_timer()


func _on_idle_timer_timeout() -> void:
	set(&"parameters/Idle/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	reset_timer()


func reset_timer() -> void:
	idle_timer.wait_time = randf_range(3.0, 9.0)
	idle_timer.start()
