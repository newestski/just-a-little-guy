extends Node

var squish_counter = 0

var main_camera: MainCamera

signal squish

func _ready():
	main_camera = get_tree().get_first_node_in_group("main_camera")

#called by guys when they are squished
func on_squish():
	squish_counter += 1
	squish.emit()


func camera_shake(strength):
	main_camera.shake(strength)
