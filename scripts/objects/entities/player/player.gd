class_name Player
extends CharacterBody3D

const WALK_SPEED = 5.0
const SPRINT_SPEED = 7.5

const ROTATION_SPEED = 10.0

@export_group("Nodes")
@export var _body: Node3D
@export var _camera_pivot: Node3D


func _physics_process(delta: float) -> void:
	_add_gravity(delta)
	_handle_movement(delta)
	move_and_slide()


func _add_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


## Gets user input and changes character's velocity and rotation appropriately.
func _handle_movement(delta: float) -> void:
	var input_dir := Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
	var direction := (_camera_pivot.global_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		var speed := SPRINT_SPEED if Input.is_action_pressed(&"sprint") else WALK_SPEED
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

		_body.rotation.y = _rotate_body(direction, delta)
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		velocity.z = move_toward(velocity.z, 0, WALK_SPEED)


func _rotate_body(direction: Vector3, delta: float) -> float:
	var target_rotation := atan2(direction.x, direction.z)
	return lerp_angle(_body.rotation.y, target_rotation, ROTATION_SPEED * delta)
