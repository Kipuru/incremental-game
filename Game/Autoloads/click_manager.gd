class_name ClickManagerAutoload extends Node

var _hovered_window_corner: GameWindow = null
var _hovered_window_title_bar: GameWindowTitleBar = null
var _hovered_spawner: BubbleSpawner = null
var _hovered_bubble: Bubble = null

func register_hovered(item):
	if item is GameWindow:
		_hovered_window_corner = item
		Input.set_default_cursor_shape(Input.CursorShape.CURSOR_FDIAGSIZE)
	elif item is GameWindowTitleBar:
		_hovered_window_title_bar = item
	elif item is BubbleSpawner:
		_hovered_spawner = item
	elif item is Bubble:
		_hovered_bubble = item
	else:
		assert(false, "Unknown item type tried to register in ClickManager:\n" + str(item))

func unregister_hovered(item):
	if item is GameWindow:
		if _hovered_window_corner == item:
			_hovered_window_corner = null
			Input.set_default_cursor_shape(Input.CursorShape.CURSOR_ARROW)
	elif item is GameWindowTitleBar:
		if _hovered_window_title_bar == item:
			_hovered_window_title_bar = null
	elif item is BubbleSpawner:
		if _hovered_spawner == item:
			_hovered_spawner = null
	elif item is Bubble:
		if _hovered_bubble == item:
			_hovered_bubble = null
	else:
		assert(false, "Unknown item type tried to unregister in ClickManager")

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_handle_left_click()
		else:
			_handle_left_unclick()

func _handle_left_click() -> void:
	if _hovered_window_corner:
		_hovered_window_corner.handle_mouse_click()
	elif _hovered_window_title_bar:
		_hovered_window_title_bar.handle_mouse_click()
	elif _hovered_spawner:
		_hovered_spawner.handle_mouse_click()
	elif _hovered_bubble:
		_hovered_bubble.handle_mouse_click()

func _handle_left_unclick() -> void:
	if _hovered_window_corner:
		Input.set_default_cursor_shape(Input.CursorShape.CURSOR_ARROW)
		_hovered_window_corner.handle_mouse_unclick()
	elif _hovered_window_title_bar:
		_hovered_window_title_bar.handle_mouse_unclick()
