extends PanelContainer

const upgrade_item_scene: PackedScene = preload("uid://1vu12efbt1f1")
@onready var container: Control = %UpgradeItems

func _ready() -> void:
	add_items()

func create_upgrade_item() -> UpgradeItem:
	var instance = upgrade_item_scene.instantiate()
	assert(instance is UpgradeItem)
	return instance

func add_items() -> void:
	var item: UpgradeItem
	
	item = create_upgrade_item()
	item.upgrade_name = UpgradeLookup.hold_click_cooldown_name
	item.unit = UpgradeLookup.hold_click_cooldown_unit
	item.lookup_array = UpgradeLookup.hold_click_cooldown_lua
	item.increment_tier = func():
		GameState.hold_click_cooldown_tier += 1
	item.init(GameState.hold_click_cooldown_tier)
	GameState.bubblebucks_updated.connect(item.on_bubblebucks_updated)
	GameState.hold_click_cooldown_tier_updated.connect(item.on_tier_updated)
	container.add_child(item)
	
	item = create_upgrade_item()
	item.upgrade_name = UpgradeLookup.bubble_spawner_cooldown_name
	item.unit = UpgradeLookup.bubble_spawner_cooldown_unit
	item.lookup_array = UpgradeLookup.bubble_spawner_cooldown_lua
	item.increment_tier = func():
		GameState.bubble_spawner_cooldown_tier += 1
	item.init(GameState.bubble_spawner_cooldown_tier)
	GameState.bubblebucks_updated.connect(item.on_bubblebucks_updated)
	GameState.bubble_spawner_cooldown_tier_updated.connect(item.on_tier_updated)
	container.add_child(item)
	
	item = create_upgrade_item()
	item.upgrade_name = UpgradeLookup.bubble_decay_damage_name
	item.unit = UpgradeLookup.bubble_decay_damage_unit
	item.lookup_array = UpgradeLookup.bubble_decay_damage_lua
	item.increment_tier = func():
		GameState.bubble_decay_damage_tier += 1
	item.init(GameState.bubble_decay_damage_tier)
	GameState.bubblebucks_updated.connect(item.on_bubblebucks_updated)
	GameState.bubble_decay_damage_tier_updated.connect(item.on_tier_updated)
	container.add_child(item)
	
	item = create_upgrade_item()
	item.upgrade_name = UpgradeLookup.bubble_click_damage_name
	item.unit = UpgradeLookup.bubble_click_damage_unit
	item.lookup_array = UpgradeLookup.bubble_click_damage_lua
	item.increment_tier = func():
		GameState.bubble_click_damage_tier += 1
	GameState.bubblebucks_updated.connect(item.on_bubblebucks_updated)
	GameState.bubble_click_damage_tier_updated.connect(item.on_tier_updated)
	item.init(GameState.bubble_click_damage_tier)
	container.add_child(item)
