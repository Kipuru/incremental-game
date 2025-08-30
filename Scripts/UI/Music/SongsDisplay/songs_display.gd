extends PanelContainer

const song_item_scene: PackedScene = preload("uid://crukf30s30kkm")

# These are temp, better solution should be implemented later using a json file or something
const song_names = [
	"Aeropop",
	"floott",
	"merbe",
	"ok maybe 2",
	"uhhhh 5",
	"wheeeee",
	"Wii Aeropop Demo"
]
const song_locs = [
	"uid://bw16oceepad4s",
	"uid://bbys8joyxkkug",
	"uid://dbl0pf4cueu10",
	"uid://b3smntwdp16bv",
	"uid://t43rkmkwyf2d",
	"uid://bmxfhphbbfspd",
	"uid://b6baqodyaokkp"
]

@onready var container: Control = %SongItemContainer
@onready var player: MusicPlayer = %MusicPlayer

func _ready() -> void:
	assert(song_item_scene is PackedScene)
	assert(song_item_scene.can_instantiate())
	assert(player)
	
	for i in range(song_names.size()):
		var instance = instantiate_song_item()
		instance.song_name = song_names[i]
		instance.location = song_locs[i]
		instance.play_now.connect(play_now)
		instance.enqueue.connect(enqueue)
		container.add_child(instance)

func instantiate_song_item() -> SongItem:
	var instance = song_item_scene.instantiate()
	assert(instance is SongItem)
	return instance

func play_now(song_name: String, location: String):
	player.play_now(song_name, location)
func enqueue(song_name: String, location: String):
	player.push_queue(song_name, location)
