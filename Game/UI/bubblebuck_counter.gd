extends Label

func _ready() -> void:
	GameState.bubblebucks_updated.connect(on_bubblebucks_updated)

func on_bubblebucks_updated(bubblebucks: int):
	text = str(bubblebucks) + " bubblebucks"
