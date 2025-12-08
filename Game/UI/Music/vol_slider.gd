extends HSlider

@export
var BusName: String

var busIndex: int


func _ready() -> void:
	busIndex = AudioServer.get_bus_index(BusName)
	value_changed.connect(_onvalchanged)
	#value = db_to_linear(AudioServer.get_bus_volume_db(busIndex))
	#setting default vol to 50%
	value = 0.5	# 50%
	AudioServer.set_bus_volume_db(busIndex, linear_to_db(value))
	
	
func _onvalchanged(value:float) -> void:
	AudioServer.set_bus_volume_db(busIndex,linear_to_db(value))
 
