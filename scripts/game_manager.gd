extends Node

var squish_counter = 0

signal squish

#called by guys when they are squished
func on_squish():
	squish_counter += 1
	squish.emit()
