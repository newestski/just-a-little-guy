class_name Player
extends CharacterBody2D

const MAX_WALK_SPEED = 200.0 # top speed achievable while walking (px/s)
const WALK_ACCELERATION = 500# rate of acceleration of walking (px/s/s)
const JUMP_VELOCITY = -300.0 # speed of jump (px/s)
const GROUND_FRICTION = 0.9 # determines rate you slow down while touching the ground, ranges from 0 (no friction) to 1 (instant stop))



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var direction := Input.get_axis("walk_left", "walk_right")
	if direction and abs(velocity.x) <= MAX_WALK_SPEED:
		velocity.x += direction * WALK_ACCELERATION * delta
	else:
		velocity.x *= 0.95

	move_and_slide()
