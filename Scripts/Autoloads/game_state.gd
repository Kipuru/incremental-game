extends Node

signal bubbles_updated(bubbles: int)
var bubbles := 0:
	set(value):
		bubbles = value
		bubbles_updated.emit(value)

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
