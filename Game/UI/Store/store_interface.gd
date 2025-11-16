extends PanelContainer

const store_item_scene: PackedScene = preload("uid://1vu12efbt1f1")
@onready var container: Control = %StoreItems

func _ready() -> void:
	add_items()

func create_store_item() -> StoreItem:
	var instance = store_item_scene.instantiate()
	assert(instance is StoreItem)
	return instance

func add_items() -> void:
	var item: StoreItem
	
	item = create_store_item()
	item.init(PurchaseableItems.hold_click)
	container.add_child(item)
	
	item = create_store_item()
	item.init(PurchaseableItems.bubble_spawner_cooldown)
	container.add_child(item)
	
	item = create_store_item()
	item.init(PurchaseableItems.bubble_decay_damage)
	container.add_child(item)
	
	item = create_store_item()
	item.init(PurchaseableItems.bubble_click_damage)
	container.add_child(item)
