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
	item.lookup_array = TierLookup.bubble_spawner_cooldown_lua
	item.increment_tier = func():
		GameState.bubble_spawner_cooldown_tier += 1
	item.init("Decrease Bubble Spawner Cooldown", GameState.bubble_spawner_cooldown_tier)
	GameState.bubbles_updated.connect(item.on_bubbles_updated)
	GameState.bubble_spawner_cooldown_tier_updated.connect(item.on_tier_updated)
	container.add_child(item)
	
	item = create_upgrade_item()
	item.lookup_array = TierLookup.bubble_decay_damage_lua
	item.increment_tier = func():
		GameState.bubble_decay_damage_tier += 1
	item.init("Increase Bubble Decay Damage", GameState.bubble_decay_damage_tier)
	GameState.bubbles_updated.connect(item.on_bubbles_updated)
	GameState.bubble_decay_damage_tier_updated.connect(item.on_tier_updated)
	container.add_child(item)
	
	item = create_upgrade_item()
	item.lookup_array = TierLookup.bubble_click_damage_lua
	item.increment_tier = func():
		GameState.bubble_click_damage_tier += 1
	GameState.bubbles_updated.connect(item.on_bubbles_updated)
	GameState.bubble_click_damage_tier_updated.connect(item.on_tier_updated)
	item.init("Increase Bubble Click Damage", GameState.bubble_click_damage_tier)
	container.add_child(item)
