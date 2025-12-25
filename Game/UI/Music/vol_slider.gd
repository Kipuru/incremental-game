extends HSlider

@export var audioPlayer: AudioStreamPlayer


func _ready() -> void:

	min_value = 0.0
	max_value = 1.0
	step = 0.05
	value_changed.connect(_onvalchanged)
	value = 0.5	# 50%
	audioPlayer.volume_db	= linear_to_db(value)
	

	

	
func _onvalchanged(value:float) -> void:
	audioPlayer.volume_db = linear_to_db(value)
