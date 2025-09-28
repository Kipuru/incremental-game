extends Node2D

const SCREEN_AREA = WindowManagerAutoload.BASE_SCREEN_SIZE.x * WindowManagerAutoload.BASE_SCREEN_SIZE.y
const EVENT_THRESHOLD = 0.50

func _ready() -> void:
	GameState.bubbles_updated.connect(on_bubbles_change)

func on_bubbles_change(value: int):
	var ratio = (value * Bubble.AREA) / SCREEN_AREA
	GameState.bubble_fill_ratio = ratio
	if not ratio >= EVENT_THRESHOLD:
		return
	
	for child in get_children():
		if child is Bubble:
			child.handle_pop(false)
	
	GameState.stage += 1
