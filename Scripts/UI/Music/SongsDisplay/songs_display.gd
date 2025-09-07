extends PanelContainer

const song_item_scene: PackedScene = preload("uid://crukf30s30kkm")

# !!!!! These are temp, better solution should be implemented later using a json file or something !!!!!
const song_folder = "res://Assets/Demo Songs/"
func get_files_in_folder(path: String) -> Array:
	var files: Array
	var dir = DirAccess.open(path)

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".mp3"):
				files.append(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	return files
func load_songs():
	var files = get_files_in_folder(song_folder)
	for i in range(files.size()):
		var instance = instantiate_song_item()
		instance.song_name = files[i].split(".")[0]
		instance.location = "res://Assets/Demo Songs/" + files[i]
		instance.play_now.connect(play_now)
		instance.enqueue.connect(enqueue)
		container.add_child(instance)
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

@onready var container: Control = %SongItemContainer
@onready var player: MusicPlayer = %MusicPlayer

func _ready() -> void:
	assert(song_item_scene.can_instantiate())
	assert(player)
	load_songs()

func instantiate_song_item() -> SongItem:
	var instance = song_item_scene.instantiate()
	assert(instance is SongItem)
	return instance

func play_now(song_name: String, location: String):
	player.play_now(song_name, location)
func enqueue(song_name: String, location: String):
	player.push_queue(song_name, location)
