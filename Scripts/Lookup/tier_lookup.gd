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

static var bubble_spawner_cooldown_lua = [
	[10, 1],
	[6, 1],
	[4, 1],
	[2, 1],
	[1, 1],
	[0.5, 1],
	[0.4, 1],
	[0.3, 1],
	[0.2, 1],
	[0.1, 1],
]
static var bubble_decay_damage_lua = [
	[1, 1],
	[2, 1],
	[3, 1],
	[4, 1],
	[5, 1],
	[6, 1],
	[7, 1],
	[8, 1],
	[9, 1],
	[10, 1]
]
static var bubble_click_damage_lua = [
	[1, 1],
	[2, 1],
	[3, 1],
	[4, 1],
	[5, 1],
	[6, 1],
	[7, 1],
	[8, 1],
	[9, 1],
	[10, 1]
]
