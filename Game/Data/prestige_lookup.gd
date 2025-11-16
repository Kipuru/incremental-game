# Helper class for looking up values for prestige
@abstract class_name PrestigeLookup

# Safe lookup functions to prevent out of bounds errors
static func rate_lookup(current_points: int) -> Variant:
	if current_points < 0:
		return threshold_lua[0]
	if current_points >= threshold_lua.size():
		var last_index = threshold_lua.size() - 1
		return threshold_lua[last_index]
	return threshold_lua[current_points]

static var threshold_lua: Array[float] = [
	5.,
	10.,
	15.,
	20.,
	25.,
	30.,
	35.,
	40.,
	45.,
	50.,
]
