extends Node2D

@export var title := "Window Name"
@export var initial_size := Vector2(800., 300.)
@export var scene_to_load := "uid://bga3nuxnrcu7v"

@onready var ui: Control = %UI
@onready var title_bar: Control = %TitleBar
@onready var title_label: Label = %TitleLabel
@onready var content: Control = %Content
@onready var resize_area: Node2D = %ResizeArea

enum DragModes { NONE, MOVE_HOVER, MOVE, RESIZE_HOVER, RESIZE }
var drag_mode: DragModes = DragModes.NONE
var original_state: Vector2
var original_mouse_pos: Vector2

func _ready() -> void:
	assert(ui and title_bar and title_label and content and resize_area)
	
	content.custom_minimum_size = initial_size
	title_label.text = title
	
	load_scene_into_content_node()
	
	# small hack where we wait one frame
	# so ui can update before we grab its size
	await get_tree().process_frame
	resize_area.position = ui.size

func _process(delta: float) -> void:
	if drag_mode == DragModes.MOVE:
		handle_move()
	elif drag_mode == DragModes.RESIZE:
		handle_resize()

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		handle_click(event)

func _on_title_bar_mouse_entered() -> void:
	if drag_mode == DragModes.NONE:
		drag_mode = DragModes.MOVE_HOVER

func _on_title_bar_mouse_exited() -> void:
	if drag_mode == DragModes.MOVE_HOVER:
		drag_mode = DragModes.NONE

func _on_resize_area_mouse_entered() -> void:
	if drag_mode == DragModes.NONE:
		drag_mode = DragModes.RESIZE_HOVER
		Input.set_default_cursor_shape(Input.CursorShape.CURSOR_FDIAGSIZE)

func _on_resize_area_mouse_exited() -> void:
	if drag_mode == DragModes.RESIZE_HOVER:
		drag_mode = DragModes.NONE
		Input.set_default_cursor_shape(Input.CursorShape.CURSOR_ARROW)

func _on_close_button_pressed() -> void:
	set_visible(false)

func load_scene_into_content_node():
	if not ResourceLoader.exists(scene_to_load):
		print("Window '" + title + "' could not find scene to load.")
		return
	
	var loaded_res = load(scene_to_load)
	assert(loaded_res is PackedScene)
	assert(loaded_res.can_instantiate())
	var scene_instance = loaded_res.instantiate()
	assert(scene_instance is Control)
	content.add_child(scene_instance)

func handle_click(event: InputEventMouseButton):
	if event.pressed:
		if drag_mode == DragModes.MOVE_HOVER:
			# start move
			original_state = position
			original_mouse_pos = get_viewport().get_mouse_position()
			drag_mode = DragModes.MOVE
			title_bar.mouse_default_cursor_shape = Control.CursorShape.CURSOR_DRAG
		elif drag_mode == DragModes.RESIZE_HOVER:
			# start resize
			original_state = content.custom_minimum_size
			original_mouse_pos = get_viewport().get_mouse_position()
			drag_mode = DragModes.RESIZE
			Input.set_default_cursor_shape(Input.CursorShape.CURSOR_DRAG)
	else:
		if drag_mode == DragModes.MOVE:
			# stop resize
			drag_mode = DragModes.MOVE_HOVER
			title_bar.mouse_default_cursor_shape = Control.CursorShape.CURSOR_POINTING_HAND
		elif drag_mode == DragModes.RESIZE:
			# stop resize
			drag_mode = DragModes.RESIZE_HOVER
			Input.set_default_cursor_shape(Input.CursorShape.CURSOR_FDIAGSIZE)

func handle_move():
	# mov ewindow based on mouse position delta and original position
	var mouse_pos = get_viewport().get_mouse_position()
	var delta = mouse_pos - original_mouse_pos
	position = original_state + delta

func handle_resize():
	# resize content based on mouse position delta and original size
	var mouse_pos = get_viewport().get_mouse_position()
	var delta = mouse_pos - original_mouse_pos
	content.custom_minimum_size = original_state + delta
	
	# reposition resize area
	resize_area.position = ui.size
