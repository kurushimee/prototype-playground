class_name Player
extends CharacterBody3D

const WALK_SPEED = 5.0
const SPRINT_SPEED = 7.5

const ROTATION_SPEED = 10

@onready var body: Node3D = $figurine2
@onready var animation_tree: AnimationTree = $AnimationTree

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
	var horizontal_basis := Basis(Vector3.UP, camera.global_rotation.y)
	var direction := (horizontal_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		var speed := SPRINT_SPEED if Input.is_action_pressed(&"sprint") else WALK_SPEED
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

		rotate_body(direction, delta)
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		velocity.z = move_toward(velocity.z, 0, WALK_SPEED)


func rotate_body(direction: Vector3, delta: float) -> void:
	var target_rotation := atan2(direction.x, direction.z)
	body.rotation.y = lerp_angle(body.rotation.y, target_rotation, ROTATION_SPEED * delta)
