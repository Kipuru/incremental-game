# Helper class for looking up values for upgrades
# Lookup arrays (luas) contain subarrays with format: [value, cost]
@abstract class_name TierLookup

const VALUE_INDEX = 0
const COST_INDEX = 1

# Safe lookup functions to prevent out of bounds errors
static func value_lookup(tier: int, lookup_array: Array) -> Variant:
	if tier < 0:
		return lookup_array[0][VALUE_INDEX]
	if tier >= lookup_array.size():
		var last_index = lookup_array.size() - 1
		return lookup_array[last_index][VALUE_INDEX]
	return lookup_array[tier][VALUE_INDEX]
static func cost_lookup(tier: int, lookup_array: Array) -> Variant:
	if tier < 0:
		return lookup_array[0][COST_INDEX]
	if tier >= lookup_array.size():
		var last_index = lookup_array.size() - 1
		return lookup_array[last_index][COST_INDEX]
	return lookup_array[tier][COST_INDEX]

static var bubble_spawner_cooldown_name = "Decrease Bubble Spawner Cooldown"
static var bubble_spawner_cooldown_unit = "s"
static var bubble_spawner_cooldown_lua = [
	[10, 1],
	[6, 2],
	[4, 3],
	[2, 4],
	[1, 5],
	[0.5, 6],
	[0.4, 7],
	[0.3, 8],
	[0.2, 9],
	[0.1, 10],
]
static var bubble_decay_damage_name = "Increase Bubble Decay Damage"
static var bubble_decay_damage_unit = ""
static var bubble_decay_damage_lua = [
	[1, 1],
	[2, 2],
	[3, 3],
	[4, 4],
	[5, 5],
	[6, 6],
	[7, 7],
	[8, 8],
	[9, 9],
	[10, 10]
]
static var bubble_click_damage_name = "Increase Bubble Click Damage"
static var bubble_click_damage_unit = ""
static var bubble_click_damage_lua = [
	[1, 1],
	[2, 2],
	[3, 3],
	[4, 4],
	[5, 5],
	[6, 6],
	[7, 7],
	[8, 8],
	[9, 9],
	[10, 10]
]
