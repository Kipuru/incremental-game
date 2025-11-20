class_name Taskbar extends PanelContainer

const item_scene = preload("uid://bpup7sctor3jd")

@export var launcher: Launcher

@onready var items: Control = %Items
@onready var launcher_button: TextureButton = %LauncherButton

func _ready() -> void:
	assert(launcher)
	assert(item_scene.can_instantiate())
	
	launcher_button.pressed.connect(
		func():
			launcher.visible = not launcher.visible
	)

func add_item(window: GameWindow):
	var item = item_scene.instantiate()
	assert(item is TaskbarItem)
	
	item.window = window
	item.init()
	
	items.add_child(item)

# iteration is fine here bc we won't have many windows
func remove_item(window: GameWindow):
	for child in items.get_children():
		assert(child is TaskbarItem)
		var item = child as TaskbarItem
		if item.window == window:
			item.queue_free()
