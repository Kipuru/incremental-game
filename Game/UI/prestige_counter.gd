extends Label

func _ready() -> void:
	GameState.prestiege_points_updated.connect(on_prestige_points_updated)

func on_prestige_points_updated(value: int):
	text = str(value) + " pp"
