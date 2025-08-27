class_name MusicPlayer extends AudioStreamPlayer

signal queue_changed
signal curr_changed(curr: AudioStreamWrapper)

const history_max_size = 10
const queue_max_size = 10

static var history: Array[AudioStreamWrapper] = []
static var current: AudioStreamWrapper = null
static var queue: Array[AudioStreamWrapper] = []

# *** Public ***

# If queue is empty, plays the song right away.
# Loads the given audio file into memory and adds it to the queue.
# Does not load anything if the queue is full.
func push_queue(song_name: String, location: String):
	if current == null:
		play_now(song_name, location)
		return
	if queue.size() >= queue_max_size:
		return
	queue.push_back(_load_audio_file(song_name, location))
	queue_changed.emit()

# Plays the given file immediately.
# Clears the queue.
func play_now(song_name: String, location: String):
	stop()
	
	queue.clear()
	current = _load_audio_file(song_name, location)
	stream = current.stream
	
	curr_changed.emit(current)
	queue_changed.emit()
	
	play()

# Plays the next song in the queue.
# Does nothing if the queue is empty.
func play_next():
	stop()
	
	if queue.size() == 0:
		current = null
		return
	_push_history()
	current = queue.pop_front()
	stream = current.stream
	
	curr_changed.emit(current)
	queue_changed.emit()
	
	play()

# Plays the previous song from history.
# Does nothing if history is empty.
func play_prev():
	
	stop()
	if history.size() == 0:
		current = null
		return
	queue.push_front(current)
	current = history.pop_back()
	stream = current.stream
	
	curr_changed.emit(current)
	queue_changed.emit()
	
	play()


# *** Private ***

static func _load_audio_file(song_name: String, location: String) -> AudioStreamWrapper:
	assert(ResourceLoader.exists(location))
	var loaded_res = load(location)
	assert(loaded_res is AudioStream)
	
	var wrapper = AudioStreamWrapper.new()
	wrapper.name = song_name
	wrapper.location = location
	wrapper.stream = loaded_res
	
	return wrapper

static func _push_history():
	history.push_back(current)
	current = null
	if history.size() > history_max_size:
		history.pop_front()

func _on_finished() -> void:
	play_next()
