class_name LittleGuy
extends CharacterBody2D

@onready var squish_detector: Area2D = $SquishDetector
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var blood_explosion: CPUParticles2D = $BloodExplosion
@onready var squish_sound: AudioStreamPlayer2D = $SquishSound

const SPEED = 50.0
const JUMP_VELOCITY = -400.0

@export_range(-1, 1, 1) var starting_direction = 1

var direction = 0


func _ready() -> void:
	direction = starting_direction
	squish_detector.body_entered.connect(check_squish)
	


func check_squish(body):
	if body is Player and body.velocity.y > 0:
		squish()


func squish():
	GameManager.on_squish()
	animated_sprite_2d.visible = false
	blood_explosion.emitting = true
	squish_sound.play()
	await blood_explosion.finished
	queue_free()


func _physics_process(delta: float) -> void:
	# turns around if hits wall
	if is_on_wall():
		direction *=-1
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#adds movement
	if direction:
		velocity.x = direction * SPEED
		if direction >= 0:
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	
	move_and_slide()
	
	
