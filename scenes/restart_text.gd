extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.restarting.connect(oh_shoot)


func oh_shoot():
	visible = true
