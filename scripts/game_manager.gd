extends Node

var squish_counter = 0
var max_squishes = 3

var main_camera: MainCamera

signal squish
signal restarting

func _ready():
	squish_counter = 0
	main_camera = get_tree().get_first_node_in_group("main_camera")


func restart():
	restarting.emit()
	await get_tree().create_timer(1.5).timeout
	squish_counter = 0
	get_tree().reload_current_scene()
	


#called by guys when they are squished
func on_squish():
	squish_counter += 1
	squish.emit()
	if squish_counter >= max_squishes:
		restart()


func camera_shake(strength):
	get_tree().get_first_node_in_group("main_camera").shake(strength)
