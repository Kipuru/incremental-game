extends PanelContainer

@export var music_window: Node2D

func _ready() -> void:
	assert(music_window)

func _on_music_button_pressed() -> void:
	music_window.visible = not music_window.visible
