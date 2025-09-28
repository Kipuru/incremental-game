class_name QueueItem extends PanelContainer

signal dequeue(index: int)

@export var name_label: Label

var song_name := "Example Song"
var index := 0

func _ready() -> void:
	assert(name_label)
	name_label.text = song_name

func _on_dequeue_pressed() -> void:
	dequeue.emit(index)
