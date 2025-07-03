class_name Player
extends CharacterBody3D

const SPEED = 5
const ROTATION_SPEED = 10

@onready var body: Node3D = $figurine2
@onready var camera: Camera3D = $Camera3D


func _physics_process(delta: float) -> void:
	add_gravity(delta)
	handle_movement(delta)
	move_and_slide()


func add_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


func handle_movement(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		rotate_body(direction, delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


func rotate_body(direction: Vector3, delta: float) -> void:
	var target_rotation := atan2(direction.x, direction.z)
	body.rotation.y = lerp_angle(body.rotation.y, target_rotation, ROTATION_SPEED * delta)
