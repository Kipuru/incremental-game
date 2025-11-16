class_name PurchaseableItem

const MAX_INT = 9223372036854775807
enum Currency {BUBBLE_BUCK, ICON_GUY, PRESTIGE}

# readonly vars
# setters do nothing
var name: String:
	get():
		return _name
	set(value):
		return
var currency: Currency:
	get():
		return _currency
	set(value):
		return
var unit: String:
	get():
		return _unit
	set(value):
		return
var cost: int:
	get():
		if (is_maxed()):
			return MAX_INT
		return _costs[_tier.v]
	set(value):
		return
var value: Variant:
	get():
		return _values[_tier.v]
	set(value):
		return
var next_value: Variant:
	get():
		if (is_maxed()):
			return null
		return _values[_tier.v + 1]
	set(value):
		return

# private vars
var _name: String
var _currency: Currency
var _unit: String
var _tier: WrappedInteger
var _max_tier: int
var _costs: Array[int]
var _values: Array[Variant] # first item contains initial value, null if there is none
var _on_purchase: Callable

@warning_ignore("shadowed_variable")
func _init(
	name: String, currency: Currency, unit: String, tier: WrappedInteger,
	costs: Array[int], values: Array[Variant], on_purchase: Callable = Callable()
) -> void:
	assert(costs.size() == values.size() + 1)
	
	_name = name
	_currency = currency
	_unit = unit
	_tier = tier
	_max_tier = costs.size() - 1
	_costs = costs
	_values = values
	_on_purchase = on_purchase

func is_maxed() -> bool:
	return _tier.v == _max_tier

func can_purchase() -> bool:
	if (is_maxed()):
		return false
	
	match _currency:
		Currency.BUBBLE_BUCK:
			return cost >= GameState.get_bubblebucks()
		Currency.ICON_GUY:
			return cost >= GameState.get_icon_guys()
		_:
			return cost >= GameState.get_prestige_points()

func purchase() -> void:
	assert(can_purchase())
	
	match _currency:
		Currency.BUBBLE_BUCK:
			GameState.decrease_bubblebucks(cost)
		Currency.ICON_GUY:
			GameState.increase_occupied_icon_guys(cost)
		Currency.PRESTIGE:
			GameState.update_used_prestige_points(cost)
	
	_tier.v += 1
	
	if not _on_purchase.is_null():
		_on_purchase.call()
