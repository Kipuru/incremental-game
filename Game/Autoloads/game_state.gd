class_name GameStateAutoload extends Node

# *** live states ***
var bubbles := 0:
	set(value):
		bubbles = value
		bubbles_updated.emit(value)
signal bubbles_updated(value: int)

var bb_collection_rate := 0.:
	set(value):
		bb_collection_rate = value
		bb_collection_rate_updated.emit(value)
signal bb_collection_rate_updated(value: float)

var water_fill_ratio := 0.
var bubble_fill_ratio := 0.

# *** currencies ***
func increase_bubblebucks(amount: int) -> void:
	_bubblebucks += amount
	_total_bubblebucks += amount
func decrease_bubblebucks(amount: int) -> void:
	_bubblebucks -= amount
func get_bubblebucks() -> int:
	return _bubblebucks
func get_total_bubblebucks() -> int:
	return _total_bubblebucks

var _bubblebucks := 0:
	set(value):
		_bubblebucks = value
		bubblebucks_updated.emit(value)
var _total_bubblebucks := 0
signal bubblebucks_updated(value: int)

func increase_icon_guys(amount: int) -> void:
	_total_icon_guys += amount
	_update_icon_guys()
func increase_occupied_icon_guys(amount: int) -> void:
	_occupied_icon_guys += amount
	assert(_occupied_icon_guys <= _total_icon_guys)
	_update_icon_guys()
func get_icon_guys() -> int:
	return _icon_guys
func _update_icon_guys() -> void:
	_icon_guys = _total_icon_guys - _occupied_icon_guys

var _total_icon_guys := 0
var _occupied_icon_guys := 0
var _icon_guys := 0:
	set(value):
		_icon_guys = value
		icon_guys_updated.emit(value)
signal icon_guys_updated(value: int)

# *** progression ***
var prestiege_points := 0:
	set(value):
		prestiege_points = value
		prestiege_points_updated.emit(value)
signal prestiege_points_updated(value: int) 

var stage := 0:
	set(value):
		stage = value
		stage_updated.emit(value)
signal stage_updated(value: int)

# *** purchases ***
var hold_click_tier := WrappedInteger.new(0)
var bubble_spawner_cooldown_tier := WrappedInteger.new(0)
var bubble_decay_damage_tier := WrappedInteger.new(0)
var bubble_click_damage_tier := WrappedInteger.new(0)
