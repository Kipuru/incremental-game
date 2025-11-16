class_name StoreItem extends PanelContainer

const MAX_TEXT = "MAX"

@export var _name_label: Label
@export var _buy_button: Button

var upgrade_name: String
var unit: String
var lookup_array: Array
var increment_tier: Callable
var _cost: int

func _ready() -> void:
	assert(_name_label)
	assert(_buy_button)

func _on_buy_pressed() -> void:
	GameState.decrease_bubblebucks(_cost)
	increment_tier.call()

# call this to properly set up the node
func init(current_tier: int):
	assert(upgrade_name)
	assert(unit != null)
	assert(lookup_array)
	assert(increment_tier)
	
	on_tier_updated(current_tier)
	on_bubblebucks_updated(GameState.get_bubblebucks())

func on_bubblebucks_updated(bubblebucks: int):
	if _buy_button.text == MAX_TEXT:
		return

	_buy_button.disabled = bubblebucks < _cost

func on_tier_updated(tier: int):
	if (tier >= lookup_array.size() - 1):
		_buy_button.text = str(MAX_TEXT)
		_buy_button.disabled = true
		return
	
	var before_value = UpgradeLookup.value_lookup(tier, lookup_array)
	var after_value = UpgradeLookup.value_lookup(tier + 1, lookup_array)
	_name_label.text = upgrade_name + " (" + str(before_value) + unit + "->" + str(after_value) + unit + ")"
	_cost = UpgradeLookup.cost_lookup(tier, lookup_array)
	_buy_button.text = str(_cost)
