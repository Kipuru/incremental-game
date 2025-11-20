class_name Taskbar extends PanelContainer

const item_scene = preload("uid://bpup7sctor3jd")

@export var windows: Array[GameWindow]
@export var launcher: Launcher

@onready var items: Control = %Items
@onready var launcher_button: TextureButton = %LauncherButton

func _ready() -> void:
	assert(windows and launcher)
	assert(item_scene.can_instantiate())
	
	launcher_button.pressed.connect(
		func():
			launcher.visible = not launcher.visible
	)
	
	for window in windows:
		var item = item_scene.instantiate()
		assert(item is TaskbarItem)
		
		item.window = window
		item.init()
		
		items.add_child(item)
