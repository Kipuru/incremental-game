extends Control

@export var bb_counter: Label
@export var ig_counter: Label
@export var prestige_counter: Label
@export var bb_rate: Label

func _ready() -> void:
	assert(bb_counter)
	assert(ig_counter)
	assert(prestige_counter)
	assert(bb_rate)
	
	GameState.bubblebucks_updated.connect(on_bubblebucks_updated)
	GameState.icon_guys_updated.connect(on_icon_guys_updated)
	GameState.prestige_points_updated.connect(on_prestige_points_updated)
	GameState.bb_collection_rate_updated.connect(on_bb_collection_rate_updated)

func on_bubblebucks_updated(value: int):
	bb_counter.text = str(value)

func on_icon_guys_updated(value: int):
	ig_counter.text = str(value)

func on_prestige_points_updated(value: int):
	prestige_counter.text = str(value)

func on_bb_collection_rate_updated(value: float):
	bb_rate.text = str(value)
