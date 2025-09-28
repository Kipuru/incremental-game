class_name GameStateAutoload extends Node

func increase_bubblebucks(amount: int) -> void:
	_bubblebucks += amount
	_total_bubblebucks += amount
func decrease_bubblebucks(amount: int) -> void:
	_bubblebucks -= amount
func get_bubblebucks() -> int:
	return _bubblebucks
func get_total_bubblebucks() -> int:
	return _total_bubblebucks

# private vars
signal bubblebucks_updated(value: int)
var _bubblebucks := 0:
	set(value):
		_bubblebucks = value
		bubblebucks_updated.emit(value)
var _total_bubblebucks := 0

# public vars
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
