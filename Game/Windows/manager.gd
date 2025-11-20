class_name GameWindowManager extends Node2D

# TODO, dictionary-less implementation
const STORE_WINDOW_INFO = {
	"icon_resource": "uid://dv0l1mpllt0un",
	"title": "Store",
	"scene_to_load": "uid://b5xi2ilu6u1g6",
	"initial_size": Vector2(304, 128),
	"minimum_size": Vector2(304, 128)
}
const MUSIC_PLAYER_WINDOW_INFO = {
	"icon_resource": "uid://dvy1d2j4t6lrf",
	"title": "Music Player",
	"scene_to_load": "uid://dwtelixwjtlsk",
	"initial_size": Vector2(384, 192),
	"minimum_size": Vector2(384, 192)
}
const window_scene = preload("uid://ccdqkc2ixgwur")

@export var taskbar: Taskbar

func _ready() -> void:
	assert(taskbar)
	assert(window_scene.can_instantiate())

func add_or_show_window(info: Dictionary):
	if _show_window(info["title"]):
		return
	_add_window(info)

# returns true if able to open window, false otherwise
func _show_window(title: String):
	for child in get_children():
		assert(child is GameWindow)
		if child.title == title:
			child.visible = true
			return true
	return false

func _add_window(info: Dictionary):
	var instance = window_scene.instantiate()
	assert(instance is GameWindow)
	var window = instance as GameWindow
	
	add_child(window)
	window.initialize(
		info["icon_resource"],
		info["title"],
		info["scene_to_load"],
		info["initial_size"],
		info["minimum_size"],
		func(): _remove_window(window)
	)
	
	taskbar.add_item(window)

func _remove_window(window: GameWindow):
	taskbar.remove_item(window)
	window.queue_free()
