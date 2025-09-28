class_name DebugHelperAutoload extends Node

var debug_label: Label = null
var game_state_var_names: Array[String] = []

func _ready() -> void:
	var script := GameState.get_script() as GDScript
	for variable in script.get_script_property_list():
		game_state_var_names.append(variable.name)

func _process(_delta: float) -> void:
	if debug_label != null:
		edit_debug()

func _input(event):
	if not (event is InputEventKey and event.pressed):
		return
	
	match event.keycode:
		KEY_F1:
			# set window mode to windowedd
			DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
		KEY_F2:
			# set window mode to fullscreen
			DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
		KEY_F12:
			# show debug
			toggle_debug()

func toggle_debug():
	if debug_label != null:
		var temp = debug_label
		debug_label = null
		temp.queue_free()
		return
	
	var canvas_layer = CanvasLayer.new()
	get_tree().root.add_child(canvas_layer)
	var label = Label.new()
	label.add_theme_color_override("font_color", Color.BLACK)
	label.add_theme_font_size_override("font_size", 12)
	canvas_layer.add_child(label)
	canvas_layer.layer = 999
	debug_label = label

func edit_debug():
	var text = ""
	text += "FPS: " + str(Engine.get_frames_per_second())
	text += "\n"
	
	for var_name in game_state_var_names:
		var value = GameState.get(var_name)
		if value == null:
			continue
		text += var_name + ":  " + str(value)
		text += "\n"
	
	debug_label.text = text
