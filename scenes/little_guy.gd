class_name LittleGuy
extends CharacterBody2D

@onready var squish_detector: Area2D = $SquishDetector

const SPEED = 50.0
const JUMP_VELOCITY = -400.0
var direction = 1


func _ready() -> void:
	squish_detector.body_entered.connect(check_squish)


func check_squish(body):
	print(body.velocity.y )
	if body is Player and body.velocity.y > 0:
		squish()


func squish():
	queue_free()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
