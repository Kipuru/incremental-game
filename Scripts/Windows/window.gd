extends Node2D

# we want to square this value so we can calculate distance
# without having to do sqrt which is expensive
const corner_detection_rad_sq = 26. ** 2.

@export var window_icon := "uid://b21msh4k62j8q"
@export var title := "Window Name"
@export var scene_to_load := "uid://bga3nuxnrcu7v"
@export var initial_size := Vector2(800., 300.)
@export var minimum_size := Vector2(800., 300.)

@onready var ui: Control = %UI
@onready var title_bar: Control = %TitleBar
@onready var title_label: Label = %TitleLabel
@onready var content: Control = %Content
@onready var icon: TextureRect = $UI/VBoxContainer/TitleBar/LeftSideMargin/HBoxContainer/Icon

enum DragModes { NONE, MOVE_HOVER, MOVE, RESIZE_HOVER, RESIZE }
var drag_mode: DragModes = DragModes.NONE
var original_state: Vector2
var original_mouse_pos: Vector2


func _ready() -> void:
	assert(ui and title_bar and title_label and content and icon)
	
	setup_window_propreties()
	load_scene_into_content_node()


func _process(delta: float) -> void:
	if not visible:
		return
	
	if drag_mode == DragModes.NONE and mouse_is_touching_corner():
		on_mouse_touching_corner()
	elif drag_mode == DragModes.RESIZE_HOVER and not mouse_is_touching_corner():
		on_mouse_untouching_corner()
	elif drag_mode == DragModes.MOVE:
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


func on_mouse_touching_corner() -> void:
	drag_mode = DragModes.RESIZE_HOVER
	Input.set_default_cursor_shape(Input.CursorShape.CURSOR_FDIAGSIZE)


func on_mouse_untouching_corner() -> void:
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


func setup_window_propreties():
	content.custom_minimum_size = initial_size
	title_label.text = title
	var loaded_icon = load(window_icon)
	icon.set_texture(loaded_icon)


func mouse_is_touching_corner() -> bool:
	var mouse_pos = get_global_mouse_position()
	var corner_pos = global_position + ui.size
	return corner_pos.distance_squared_to(mouse_pos) <= corner_detection_rad_sq


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
	var new_size = original_state + delta
	content.custom_minimum_size = new_size.max(minimum_size)
