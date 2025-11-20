class_name Launcher extends PanelContainer

@export var windows: Node2D
@export var taskbar: Taskbar

func _ready() -> void:
	assert(windows and taskbar)
	visible = false

func _on_store_pressed() -> void:
	pass

func _on_music_player_pressed() -> void:
	pass

func _on_settings_pressed() -> void:
	pass

func _add_or_show_window():
	pass
