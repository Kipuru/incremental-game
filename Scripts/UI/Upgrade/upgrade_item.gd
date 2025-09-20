class_name UpgradeItem extends PanelContainer

const MAX_TEXT = "MAX"

@export var _name_label: Label
@export var _buy_button: Button

var lookup_array: Array
var increment_tier: Callable
var _cost: int

func _ready() -> void:
	assert(_name_label)
	assert(_buy_button)

func _on_buy_pressed() -> void:
	GameState.decrease_bubbles(_cost)
	increment_tier.call()

# call this to properly set up the node
func init(upgrade_name: String, current_tier: int):
	assert(upgrade_name)
	assert(lookup_array)
	assert(increment_tier)
	
	_name_label.text = upgrade_name
	on_tier_updated(current_tier)
	on_bubbles_updated(GameState.get_bubbles())

func on_bubbles_updated(bubbles: int):
	if _buy_button.text == MAX_TEXT:
		return
	
	_buy_button.disabled = bubbles < _cost

func on_tier_updated(tier: int):
	if (tier >= lookup_array.size() - 1):
		_buy_button.text = str(MAX_TEXT)
		_buy_button.disabled = true
		return
	
	_cost = TierLookup.cost_lookup(tier, lookup_array)
	_buy_button.text = str(_cost)
