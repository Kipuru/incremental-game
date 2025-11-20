class_name TaskbarItem extends Button

var window: GameWindow

# call this to properly set up the node
func init():
	pressed.connect(
		func():
			window.visible = not window.visible
	)
	window.visibility_changed.connect(
		func():
			button_pressed = window.visible
	)
	
	assert(window)
	text = window.title
	var loaded_icon = load(window.icon_resource)
	icon = loaded_icon
