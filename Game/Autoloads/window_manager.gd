class_name WindowManagerAutoload extends Node

const BASE_SCREEN_SIZE = Vector2i(960, 540)

# TEMP SOLUTION FOR ENFORCING WINDOW SIZE
# Set up a variable for the window size with the value as the default resolution. 
var window_size = BASE_SCREEN_SIZE

func _process(_delta):
	# check to see if the window size changes
	if DisplayServer.window_get_size() != window_size:
		# Get the current window width
		var window_w = DisplayServer.window_get_size().x
		# Since the resolution is 16:9; to get the height, divide the width by 16 and multiply by 9
		# Or you can set the resolution width and height as variables, to suit other resolutions.
		var window_h = window_w / 16.0 * 9
		# Set the window size to the current width and the new height
		DisplayServer.window_set_size(Vector2(window_w, window_h))
		# Change the window_size variable to match the new size
		window_size = DisplayServer.window_get_size()
