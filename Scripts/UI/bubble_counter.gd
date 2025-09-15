extends Label

func _ready() -> void:
	GameState.bubbles_updated.connect(on_bubbles_updated)

func on_bubbles_updated(bubbles: int):
	text = str(bubbles) + " bubbles"
