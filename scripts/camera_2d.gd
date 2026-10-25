class_name MainCamera
extends Camera2D

var shake_strength = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func shake(strength):
	shake_strength = strength
	
func _process(_delta: float) -> void:
	offset = Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
	shake_strength *= 0.9
