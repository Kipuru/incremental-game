extends MarginContainer

@onready var player: MusicPlayer = %MusicPlayer

func _ready() -> void:
	assert(player)

func _on_previous_pressed() -> void:
	player.play_prev()

func _on_play_pause_pressed() -> void:
	if MusicPlayer.current == null:
		return
	
	if player.playing:
		player.stream_paused = true
	else:
		player.stream_paused = false

func _on_next_pressed() -> void:
	player.play_next()
