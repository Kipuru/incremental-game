extends Control

const queue_item_scene: PackedScene = preload("uid://bovn8jo24ixaj")

@onready var container: Control = %QueueItemContainer

func _ready() -> void:
	assert(queue_item_scene is PackedScene)
	assert(queue_item_scene.can_instantiate())

func _on_music_player_queue_changed() -> void:
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()
	
	var queue := MusicPlayer.queue
	for i in range(queue.size()):
		assert(queue[i] is AudioStreamWrapper)
		var instance = instantiate_queue_item()
		instance.index = i
		instance.song_name = queue[i].name
		container.add_child(instance)

func instantiate_queue_item() -> QueueItem:
	var instance = queue_item_scene.instantiate()
	assert(instance is QueueItem)
	return instance
