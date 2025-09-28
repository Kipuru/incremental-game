class_name GameStateAutoload extends Node


# private vars
func increase_bubblebucks(amount: int) -> void:
	_bubblebucks += amount
	_total_bubblebucks += amount
func decrease_bubblebucks(amount: int) -> void:
	_bubblebucks -= amount
func get_bubblebucks() -> int:
	return _bubblebucks
func get_total_bubblebucks() -> int:
	return _total_bubblebucks

signal bubblebucks_updated(value: int)
var _bubblebucks := 0:
	set(value):
		_bubblebucks = value
		bubblebucks_updated.emit(value)
var _total_bubblebucks := 0

# public vars
signal bubbles_updated(value: int)
var bubbles := 0:
	set(value):
		bubbles = value
		bubbles_updated.emit(value)

signal bb_collection_rate_updated(value: float)
var bb_collection_rate := 0.:
	set(value):
		bb_collection_rate = value
		bb_collection_rate_updated.emit(value)

var water_fill_ratio := 0.
var bubble_fill_ratio := 0.

signal prestiege_points_updated(value: int) 
var prestiege_points := 0:
	set(value):
		prestiege_points = value
		prestiege_points_updated.emit(value) 
signal stage_updated(value: int)
var stage := 0:
	set(value):
		stage = value
		stage_updated.emit(value)

signal bubble_spawner_cooldown_tier_updated(value: int)
var bubble_spawner_cooldown_tier := 0:
	set(value):
		bubble_spawner_cooldown_tier = value
		bubble_spawner_cooldown_tier_updated.emit(value)

signal bubble_decay_damage_tier_updated(value: int)
var bubble_decay_damage_tier := 0:
	set(value):
		bubble_decay_damage_tier = value
		bubble_decay_damage_tier_updated.emit(value)

signal bubble_click_damage_tier_updated(value: int)
var bubble_click_damage_tier := 0:
	set(value):
		bubble_click_damage_tier = value
		bubble_click_damage_tier_updated.emit(value)
