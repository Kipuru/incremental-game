extends HSlider

@onready var player: MusicPlayer = %MusicPlayer
var dragging = false

func _ready() -> void:
	assert(player)

func _process(_delta: float) -> void:
	if not dragging:
		value = player.get_playback_position()

func _on_music_player_curr_changed(curr: AudioStreamWrapper) -> void:
	value = 0
	
	if curr == null:
		editable = false
	else:
		editable = true
		max_value = curr.length

func _on_drag_started() -> void:
	dragging = true

func _on_drag_ended(value_changed: bool) -> void:
	if value_changed:
		player.seek(value)
	dragging = false
