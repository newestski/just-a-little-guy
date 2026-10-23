extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.squish.connect(update_counter)


func update_counter():
	text = "Kills: " + str(GameManager.squish_counter)
