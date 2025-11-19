extends PanelContainer

const item_scene = preload("res://Game/UI/Taskbar/taskbar_item.tscn")

@export var windows: Array[Node2D]
@onready var items: Control = %Items

func _ready() -> void:
	assert(item_scene.can_instantiate())
	
	for window in windows:
		var item = item_scene.instantiate()
		assert(item is TaskbarItem)
		
		item.window = window
		item.init()
		
		items.add_child(item)
