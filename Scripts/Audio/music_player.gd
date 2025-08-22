class_name MusicPlayer extends AudioStreamPlayer

const history_max_size = 10
const queue_max_size = 10

static var history: Array[AudioStream] = []
static var current: AudioStream = null
static var queue: Array[AudioStream] = []

# *** Public ***

# Plays the given file immediately.
# Clears the queue.
func play_now(file_location: String):
	stop()
	queue.clear()
	current = _load_audio_file(file_location)
	stream = current
	play()

# Loads the given audio file into memory and adds it to the queue.
# Does not load anything if the queue is full.
func push_queue(file_location: String):
	if queue.size() >= queue_max_size:
		return
	queue.push_back(_load_audio_file(file_location))

# Plays the next song in the queue.
# Does nothing if the queue is empty.
func play_next():
	stop()
	if queue.size() == 0:
		return
	current = queue.pop_front()
	stream = current
	play()


# *** Private ***

func _load_audio_file(file_location: String) -> AudioStream:
	assert(ResourceLoader.exists(file_location))
	var loaded_res = load(file_location)
	assert(loaded_res is AudioStream)
	return loaded_res

func _push_history():
	history.push_back(current)
	current = null
	if history.size() > history_max_size:
		history.pop_front()

func _on_finished() -> void:
	_push_history()
	play_next()
