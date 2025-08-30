class_name SongItem extends PanelContainer

signal play_now(song_name, location: String)
signal enqueue(song_name, location: String)

@export var name_label: Label

var song_name := "Example Song"
var location := "uid://bbys8joyxkkug":
	set(value):
		assert(ResourceLoader.exists(value))
		location = value

func _ready() -> void:
	assert(name_label)
	name_label.text = song_name

func _on_play_now_pressed() -> void:
	play_now.emit(song_name, location)

func _on_queue_pressed() -> void:
	enqueue.emit(song_name, location)
