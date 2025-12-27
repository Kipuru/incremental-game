extends TextureRect

const TIMER_RATE = 4. # 4 times per second
const EVALUATE_DURATION = 10. # 10 seconds
const ARRAY_LENGTH = EVALUATE_DURATION * TIMER_RATE 
const SHADER_SPEED = 0.5

@export var timer: Timer

var droplets_history: Array[int]
var threshold := PrestigeLookup.threshold_lua[0]
var shader_tween: Tween
var shader_value := 0.

func _ready() -> void:
	assert(timer)
	
	material.set_shader_parameter('fill', 0.)
	timer.wait_time = 1. / TIMER_RATE
	timer.autostart = true
	timer.start()
	
	for i in range(ARRAY_LENGTH):
		droplets_history.push_back(0)

func _physics_process(delta: float) -> void:
	var t = 1.0 - pow(0.001, delta * SHADER_SPEED)
	shader_value = lerp(shader_value, GameState.water_fill_ratio, t) # smoothing
	material.set_shader_parameter('fill', shader_value)

func _on_timer_timeout() -> void:
	var then = droplets_history.pop_front()
	var now = GameState.collected_droplets
	droplets_history.push_back(now)
	
	var rate = calculate_rate(then, now) / Bubble.DROPLETS_PER_POP
	var ratio = rate / threshold
	GameState.bb_collection_rate = rate
	GameState.water_fill_ratio = ratio
	
	if ratio >= 1.:
		on_fill()

func calculate_rate(then: int, now: int) -> float:
	var delta = now - then
	return float(delta) / EVALUATE_DURATION

func on_fill():
	GameState.increase_prestige_points(1)
	threshold = PrestigeLookup.rate_lookup(GameState.prestige_points)
