class_name MusicPlayer extends AudioStreamPlayer

signal queue_changed
signal curr_changed(curr: AudioStreamWrapper)

const history_max_size = 10
const queue_max_size = 10

static var history: Array[AudioStreamWrapper] = []
static var current: AudioStreamWrapper = null
static var queue: Array[AudioStreamWrapper] = []

# *** Public ***

# Stops playback and clears the currently playing song.
func clear_curr():
	stop()
	stream = null
	current = null
	curr_changed.emit(current)

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
	queue_changed.emit()
	
	current = _load_audio_file(song_name, location)
	curr_changed.emit(current)
	
	stream = current.stream
	
	play()

# Plays the next song in the queue.
# Does nothing if the queue is empty.
func play_next():
	stop()
	
	_push_history()
	
	if queue.size() == 0:
		clear_curr()
		return
	
	current = queue.pop_front()
	queue_changed.emit()
	curr_changed.emit(current)
	
	stream = current.stream
	
	play()

# Plays the previous song from history.
# Does nothing if history is empty.
func play_prev():
	stop()
	
	if current != null:
		queue.push_front(current)
		queue_changed.emit()
	
	if history.size() == 0:
		clear_curr()
		return
	
	current = history.pop_back()
	curr_changed.emit(current)
	stream = current.stream
	
	play()

# Removes the song from the queue at the selected index.
# Does nothing if the queue is empty.
func dequeue(index: int):
	if queue.is_empty():
		return
	
	queue.remove_at(index)
	queue_changed.emit()

# *** Private ***

static func _load_audio_file(song_name: String, location: String) -> AudioStreamWrapper:
	assert(ResourceLoader.exists(location))
	var loaded_res = load(location)
	assert(loaded_res is AudioStream)
	var aud_stream = loaded_res as AudioStream
	
	var wrapper = AudioStreamWrapper.new()
	wrapper.name = song_name
	wrapper.location = location
	wrapper.stream = aud_stream
	wrapper.length = aud_stream.get_length()
	
	return wrapper

static func _push_history():
	if (current == null):
		return
	
	history.push_back(current)
	current = null
	if history.size() > history_max_size:
		history.pop_front()

func _on_finished() -> void:
	play_next()
