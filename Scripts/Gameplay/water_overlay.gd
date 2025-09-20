extends TextureRect

const TIMER_RATE = 4. # 4 times per second
const EVALUATE_DURATION = 10. # 10 seconds
const ARRAY_LENGTH = EVALUATE_DURATION * TIMER_RATE 
const BASE_PRESTIEGE_THRESHOLD = 5. # 5 bubbles per second
const SHADER_SPEED = 0.5

@export var timer: Timer
@export var rate_label: Label

var bubbles_history: Array[int]
var shader_tween: Tween
var shader_target := 0.
var shader_value := 0.

func _ready() -> void:
	assert(timer)
	assert(rate_label)
	
	material.set_shader_parameter('fill', 0.)
	timer.wait_time = 1. / TIMER_RATE
	timer.autostart = true
	timer.start()
	
	for i in range(ARRAY_LENGTH):
		bubbles_history.push_back(0)

func _physics_process(delta: float) -> void:
	var t = 1.0 - pow(0.001, delta * SHADER_SPEED)
	shader_value = lerp(shader_value, shader_target, t) # smoothing
	material.set_shader_parameter('fill', shader_value)

func _on_timer_timeout() -> void:
	var then = bubbles_history.pop_front()
	var now = GameState.get_total_bubbles()
	bubbles_history.push_back(now)
	
	var rate = calculate_rate(then, now)
	shader_target = rate / BASE_PRESTIEGE_THRESHOLD
	rate_label.text = str(rate) + " bub/s"

func calculate_rate(then: int, now: int) -> float:
	var delta = now - then
	return float(delta) / EVALUATE_DURATION
