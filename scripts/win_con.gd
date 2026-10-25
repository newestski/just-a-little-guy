extends Area2D
@export var winScene: PackedScene


func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		get_tree().change_scene_to_packed(winScene)
	pass # Replace with function body.
