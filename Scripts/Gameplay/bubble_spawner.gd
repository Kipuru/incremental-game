class_name BubbleSpawner extends Area2D

const bubble_scene = preload("uid://cqegup4gnccd3")

@export var bubble_container: Node2D
static var touching_mouse := false
var cooldown = 0.

func _ready() -> void:
	assert(bubble_scene.can_instantiate())

func _process(delta: float) -> void:
	tick_timer(delta)
	rotation = 2 * PI * cooldown / get_cooldown_duration() # temp visual for timer

func _mouse_enter() -> void:
	touching_mouse = true

func _mouse_exit() -> void:
	touching_mouse = false

func _input(event: InputEvent):
	if touching_mouse and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if cooldown == 0.:
				spawn_bubble()

func spawn_bubble():
	var bubble_instance = bubble_scene.instantiate()
	assert(bubble_instance is PhysicsBody2D)
	bubble_instance.global_position = global_position
	bubble_container.add_child(bubble_instance)
	cooldown = get_cooldown_duration()

func tick_timer(delta: float) -> void:
	if cooldown == 0.: 
		return
	cooldown -= delta
	if cooldown < 0.:
		cooldown = 0.

func get_cooldown_duration() -> float:
	var tier = GameState.bubble_spawner_cooldown_tier
	var lua = TierLookup.bubble_spawner_cooldown_lua
	return TierLookup.value_lookup(tier, lua)
