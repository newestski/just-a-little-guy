class_name Player
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var land_sound: AudioStreamPlayer2D = $LandSound
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var step_sound: AudioStreamPlayer2D = $StepSound

const MAX_WALK_SPEED = 200.0 # top speed achievable while walking (px/s)
const WALK_ACCELERATION = 500 # rate of acceleration of walking (px/s/s)
const JUMP_VELOCITY = -300.0 # speed of jump (px/s)
const GROUND_FRICTION = 0.9 # determines rate you slow down while touching the ground, ranges from 0 (no friction) to 1 (instant stop))

var time_in_the_air = 0
var time_since_last_step = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		time_in_the_air += delta
	else:
		# does effects if landing
		if time_in_the_air != 0:
			GameManager.camera_shake(time_in_the_air*10)
			land_sound.volume_linear = time_in_the_air
			land_sound.play()
		time_in_the_air = 0
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.pitch_scale = randf_range(0.9, 1.1)
		jump_sound.play()


	var direction := Input.get_axis("walk_left", "walk_right")
	if direction and abs(velocity.x) <= MAX_WALK_SPEED:
		velocity.x += direction * WALK_ACCELERATION * delta
	else:
		velocity.x *= 0.95
	
	# sets animation
	if is_on_floor():
		if abs(velocity.x) >= 20:
			if sign(velocity.x) == direction or direction == 0:
				animated_sprite_2d.play("walk")
				animated_sprite_2d.speed_scale = abs(velocity.x/MAX_WALK_SPEED)
			else:
				animated_sprite_2d.play("slide")
		else:
			animated_sprite_2d.play("stand")
	else:
		animated_sprite_2d.play("fall")
	
	animated_sprite_2d.scale.y = (1 + abs(velocity.y/1000))
	animated_sprite_2d.scale.x = 1/(1 + abs(velocity.y/1000))
	
	
	# sets flip directiond
	if direction > 0:
		animated_sprite_2d.flip_h = false
	if direction < 0:
		animated_sprite_2d.flip_h = true
	
	# do regular step sounds
	time_since_last_step += delta
	var time_between_steps = abs(0.2/(velocity.x/MAX_WALK_SPEED))
	if time_since_last_step >= time_between_steps and animated_sprite_2d.animation == "walk":
		time_since_last_step = 0
		step_sound.pitch_scale = randf_range(0.9, 1.1)
		step_sound.play()
	
	#set collision for semisolid platforms
	if velocity.y >= 0 and !Input.is_action_pressed("fall_through"):
		set_collision_mask_value(4, true)
	else:
		set_collision_mask_value(4, false)
	
	move_and_slide()
