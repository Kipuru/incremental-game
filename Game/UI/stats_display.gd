extends VBoxContainer

@export var bb_counter: Label
@export var bb_rate: Label
@export var prestige_counter: Label

func _ready() -> void:
	assert(bb_counter)
	assert(bb_rate)
	assert(prestige_counter)
	
	GameState.bubblebucks_updated.connect(on_bubblebucks_updated)
	GameState.bb_collection_rate_updated.connect(on_bb_collection_rate_updated)
	GameState.prestiege_points_updated.connect(on_prestige_points_updated)

func on_bubblebucks_updated(value: int):
	bb_counter.text = str(value) + " bubblebucks"

func on_bb_collection_rate_updated(value: float):
	bb_rate.text = str(value) + " bb/s"

func on_prestige_points_updated(value: int):
	prestige_counter.text = str(value) + " pp"
