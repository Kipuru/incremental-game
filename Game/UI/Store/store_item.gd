class_name StoreItem extends PanelContainer

const MAX_TEXT = "MAX"

const BUBBLE_ICON: Texture2D = preload("uid://cari3pi0stwmv")
const ICON_GUY_ICON: Texture2D = preload("uid://dcdkwilpews08")
const SPARKLE_ICON: Texture2D = preload("uid://cweqr10npopto")

@export var _name_label: Label
@export var _buy_button: Button

var _item: PurchaseableItem

func _ready() -> void:
	assert(_name_label)
	assert(_buy_button)

# call this to properly set up the node
func init(item: PurchaseableItem):
	_item = item
	
	match item.currency:
		PurchaseableItem.Currency.BUBBLE_BUCK:
			_buy_button.icon = BUBBLE_ICON
		PurchaseableItem.Currency.ICON_GUY:
			_buy_button.icon = ICON_GUY_ICON
		PurchaseableItem.Currency.PRESTIGE_POINT:
			_buy_button.icon = SPARKLE_ICON
	
	item.currency_updated.connect(on_currency_updated)
	item.tier.updated.connect(on_tier_updated)
	
	on_currency_updated()
	on_tier_updated()

func _on_buy_pressed() -> void:
	_item.purchase()

func on_currency_updated(_amount: int = 0):
	if _item.is_maxed():
		return
	
	_buy_button.disabled = not _item.can_purchase()

func on_tier_updated(_tier: int = 0):
	if _item.is_maxed():
		_buy_button.text = str(MAX_TEXT)
		_buy_button.disabled = true
		_buy_button.icon = null
		return
	
	var before_value = _item.value
	var after_value = _item.next_value
	var before_null = before_value == null
	var after_null = after_value == null
	
	_name_label.text = _item.name
	if not (before_null and after_null):
		_name_label.text += " ("
	if not before_null:
		_name_label.text += str(before_value) + _item.unit
		_name_label.text += "->"
	if not after_null:
		_name_label.text += str(after_value) + _item.unit
	if not (before_null and after_null):
		_name_label.text += ")"
	
	_buy_button.text = str(_item.cost)
