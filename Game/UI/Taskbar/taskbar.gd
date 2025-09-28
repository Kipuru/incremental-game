extends PanelContainer

@export var upgrades_window: Node2D
@export var music_window: Node2D

func _ready() -> void:
	assert(upgrades_window)
	assert(music_window)

func _on_music_button_pressed() -> void:
	music_window.visible = not music_window.visible

func _on_upgrades_button_pressed() -> void:
	upgrades_window.visible = not upgrades_window.visible
