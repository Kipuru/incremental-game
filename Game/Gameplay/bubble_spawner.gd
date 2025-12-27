class_name BubbleSpawner extends CharacterBody2D

const bubble_scene = preload("uid://cqegup4gnccd3")
const SQUISH_DURATION = 0.3 # secs
const HEAD_OFFSET = Vector2(1, -14)

@onready var anim := %AnimationPlayer
@onready var timer := %Timer
@onready var sprite := %Sprite2D

@export var bubble_container: Node2D
var cooldown = 0.

func _ready() -> void:
	assert(anim)
	assert(bubble_scene.can_instantiate())
	
	_set_timer()

func _process(delta: float) -> void:
	_tick_cooldown(delta)
	
	# temp visual for timer
	var t = (1 - cooldown / _get_cooldown_duration())
	modulate = Color(1, t, t)

func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, 10.0)
	else:
		velocity.y += 1500. * delta
	
	move_and_slide()

func _mouse_enter() -> void:
	ClickManager.register_hovered(self)

func _mouse_exit() -> void:
	ClickManager.unregister_hovered(self)

func _spawn_bubble():
	var ratio = SQUISH_DURATION / _get_cooldown_duration()
	var speed = 1
	if ratio > 1:
		speed = ratio
	if anim.is_playing():
		anim.stop()
	anim.play("squish_down", -1, speed)
	
	var bubble_instance = bubble_scene.instantiate()
	assert(bubble_instance is PhysicsBody2D)
	bubble_instance.global_position = global_position + HEAD_OFFSET
	bubble_container.add_child(bubble_instance)
	GameState.bubbles += 1
	cooldown = _get_cooldown_duration()

func _tick_cooldown(delta: float) -> void:
	if cooldown == 0.: 
		return
	cooldown -= delta
	if cooldown < 0.:
		cooldown = 0.

func _get_cooldown_duration() -> float:
	return PurchaseableItems.bubble_spawner_cooldown.value

func handle_mouse_left_click() -> void:
	if cooldown == 0.:
		_spawn_bubble()

func _on_timer_timeout() -> void:
	_set_timer()
	anim.play("hop")

func _set_timer() -> void:
	timer.wait_time = randf_range(1.0, 5.0)
	timer.start()

func hop() -> void:
	position.y -= 5.
	var new_x = randf_range(50., 150.)
	if randi_range(0,1):
		new_x *= -1
		sprite.scale = Vector2(-1., 1.)
	else:
		sprite.scale = Vector2.ONE
	velocity = Vector2(new_x, -200.)
