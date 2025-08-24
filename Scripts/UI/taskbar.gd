extends PanelContainer

@export var gameplay_window: Node2D


func _on_gameplay_button_pressed() -> void:
	gameplay_window.set_visible(true)
