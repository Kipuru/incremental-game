extends PanelContainer

@export var gameplay_window: Node2D
@export var music_window: Node2D

func _ready() -> void:
	assert(gameplay_window)
	assert(music_window)

func _on_gameplay_button_pressed() -> void:
	gameplay_window.set_visible(true)

func _on_music_button_pressed() -> void:
	music_window.visible = not music_window.visible
