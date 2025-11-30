class_name BubbleSpawner extends Area2D

const bubble_scene = preload("uid://cqegup4gnccd3")

@export var bubble_container: Node2D
var cooldown = 0.

func _ready() -> void:
	assert(bubble_scene.can_instantiate())

func _process(delta: float) -> void:
	_tick_timer(delta)
	
	# temp visual for timer
	var t = (1 - cooldown / _get_cooldown_duration())
	modulate = Color(1, t, t)

func _mouse_enter() -> void:
	ClickManager.register_hovered(self)

func _mouse_exit() -> void:
	ClickManager.unregister_hovered(self)

func _spawn_bubble():
	var bubble_instance = bubble_scene.instantiate()
	assert(bubble_instance is PhysicsBody2D)
	bubble_instance.global_position = global_position
	bubble_container.add_child(bubble_instance)
	GameState.bubbles += 1
	cooldown = _get_cooldown_duration()

func _tick_timer(delta: float) -> void:
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
