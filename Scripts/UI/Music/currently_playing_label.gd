extends Label

func _on_music_player_curr_changed(curr: AudioStreamWrapper) -> void:
	if curr == null:
		text = "Not Playing"
	else:
		text = curr.name
