class_name Launcher extends PanelContainer

@export var windows: GameWindowManager

func _ready() -> void:
	assert(windows)
	visible = false

func _on_store_pressed() -> void:
	windows.add_or_show_window(GameWindowManager.STORE_WINDOW_INFO)
	visible = false

func _on_music_player_pressed() -> void:
	windows.add_or_show_window(GameWindowManager.MUSIC_PLAYER_WINDOW_INFO)
	visible = false

func _on_settings_pressed() -> void:
	pass
