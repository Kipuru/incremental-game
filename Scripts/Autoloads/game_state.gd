extends Node

func increase_bubbles(amount: int) -> void:
	_bubbles += _total_bubbles
	_total_bubbles += amount
func get_bubbles() -> int:
	return _bubbles
func get_total_bubbles() -> int:
	return _total_bubbles

# private vars
signal bubbles_updated(bubbles: int)
var _bubbles := 0:
	set(value):
		_bubbles = value
		bubbles_updated.emit(value)
var _total_bubbles := 0

# public vars
signal stage_updated(tier: int)
var stage := 0:
	set(value):
		stage = value
		stage_updated.emit(value)

signal bubble_spawner_cooldown_tier_updated(tier: int)
var bubble_spawner_cooldown_tier := 0:
	set(value):
		bubble_spawner_cooldown_tier = value
		bubble_spawner_cooldown_tier_updated.emit(value)

signal bubble_decay_tier_updated(tier: int)
var bubble_decay_tier := 0:
	set(value):
		bubble_decay_tier = value
		bubble_decay_tier_updated.emit(value)

signal bubble_click_damage_tier_updated(tier: int)
var bubble_click_damage_tier := 0:
	set(value):
		bubble_click_damage_tier = value
		bubble_click_damage_tier_updated.emit(value)
