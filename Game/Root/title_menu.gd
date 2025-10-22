extends Control

const main_game_scene = preload("uid://c6qv4h7006s3o")

func _ready() -> void:
	assert(main_game_scene is PackedScene)
	assert(main_game_scene.can_instantiate())

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_game_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
