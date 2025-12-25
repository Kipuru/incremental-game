extends HSlider

@export var audioPlayer: AudioStreamPlayer
#var BusName: String

#var busIndex: int


func _ready() -> void:
	#busIndex = AudioServer.get_bus_index(BusName)
	#value_changed.connect(_onvalchanged)
	#value = db_to_linear(AudioServer.get_bus_volume_db(busIndex))
	#setting default vol to 50%
	#AudioServer.set_bus_volume_db(busIndex, linear_to_db(value))
	min_value = 0.0
	max_value = 1.0
	step = 0.05
	value_changed.connect(_onvalchanged)
	value = 0.5	# 50%
	audioPlayer.volume_db	= linear_to_db(value)
	

	

	
func _onvalchanged(value:float) -> void:
	audioPlayer.volume_db = linear_to_db(value)
	#AudioServer.set_bus_volume_db(busIndex,linear_to_db(value))
