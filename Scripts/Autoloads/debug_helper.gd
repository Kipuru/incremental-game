extends Node

var fps_label: Label = null

func _process(_delta: float) -> void:
	if fps_label != null:
		fps_label.text = "FPS: " + str(Engine.get_frames_per_second())

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
			# show FPS on screen
			var canvas_layer = CanvasLayer.new()
			get_tree().root.add_child(canvas_layer)
			var label = Label.new()
			label.add_theme_font_size_override("font_size", 50)
			canvas_layer.add_child(label)
			canvas_layer.layer = 999
			fps_label = label
