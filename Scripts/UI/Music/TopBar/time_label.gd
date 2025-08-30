extends Label

func _on_seeker_value_changed(value: float) -> void:
	if MusicPlayer.current == null:
		text = "0:00 / 0:00"
		return
		
	var progress = TimeHelper.seconds_to_min_sec_string(value)
	var song_length = TimeHelper.seconds_to_min_sec_string(MusicPlayer.current.length)
	
	text = progress + " / " + song_length
