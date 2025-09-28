class_name GameWindowTitleBar extends PanelContainer

@export var window: GameWindow

func _ready() -> void:
	assert(window)

func _on_mouse_entered() -> void:
	ClickManager.register_hovered(self)

func _on_mouse_exited() -> void:
	ClickManager.unregister_hovered(self)

func handle_mouse_click():
	if window.drag_mode == GameWindow.DragModes.NONE:
		# start move
		window.original_state = window.position
		window.original_mouse_pos = get_viewport().get_mouse_position()
		window.drag_mode = GameWindow.DragModes.MOVE
		mouse_default_cursor_shape = Control.CursorShape.CURSOR_DRAG

func handle_mouse_unclick():
	if window.drag_mode != GameWindow.DragModes.MOVE:
		return
	
	# stop move
	window.drag_mode = GameWindow.DragModes.NONE
	mouse_default_cursor_shape = Control.CursorShape.CURSOR_POINTING_HAND
