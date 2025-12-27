class_name PurchaseableItemsAutoload extends Node

var icon_guy = PurchaseableItem.new(
	"Icon Guy",
	PurchaseableItem.Currency.BUBBLE_BUCK,
	" guys",
	GameState.icon_guy_tier,
	[2, 4, 6, 8, 10, 12, 14, 16, 18, 20],
	[0, 1, 2, 3, 4,  5,  6,  7,  8,  9, 10]
)
var hold_click = PurchaseableItem.new(
	"Hold Click",
	PurchaseableItem.Currency.BUBBLE_BUCK,
	"s",
	GameState.hold_click_tier,
	[1],
	[null, 0.25]
)
var bubble_spawner_cooldown = PurchaseableItem.new(
	"Decrease Bubble Spawner Cooldown",
	PurchaseableItem.Currency.BUBBLE_BUCK,
	"s",
	GameState.bubble_spawner_cooldown_tier,
	[1,  2, 3, 4, 5, 6,   7,   8,   9],
	[10, 6, 4, 2, 1, 0.5, 0.4, 0.3, 0.2, 0.1]
)
var bubble_decay_damage = PurchaseableItem.new(
	"Increase Bubble Decay Damage",
	PurchaseableItem.Currency.BUBBLE_BUCK,
	"",
	GameState.bubble_decay_damage_tier,
	[2, 4, 6, 8, 10, 12, 14, 16, 18],
	[1, 2, 3, 4, 5,  6,  7,  8,  9, 10]
)
var bubble_click_damage = PurchaseableItem.new(
	"Increase Bubble Click Damage",
	PurchaseableItem.Currency.BUBBLE_BUCK,
	"",
	GameState.bubble_click_damage_tier,
	[2, 4, 6, 8, 10, 12, 14, 16, 18],
	[1, 2, 3, 4, 5,  6,  7,  8,  9, 10]
)
