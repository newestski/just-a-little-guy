extends RichTextLabel

const SHAKE_TIME = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.squish.connect(update_counter)


func update_counter():
	text = "[shake] Casualties remaining: " + str(3 - GameManager.squish_counter)
	await get_tree().create_timer(SHAKE_TIME).timeout
	text = "[wave] Casualties remaining: " + str(3 - GameManager.squish_counter) 
