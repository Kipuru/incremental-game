class_name Bubble extends CharacterBody2D

const bubble_scene = preload("uid://cqegup4gnccd3")
const droplets_scene = preload("uid://dtcbmrnwmh1m6")

const RADIUS = 32.
const AREA = PI * (RADIUS ** 2)

const SPEED = 64
const MOUSE_PUSH_AMOUNT = 16
const STARTING_HEALTH = 100
const BOUNCE_DAMAGE = 1

@onready var refraction: Sprite2D = %Refraction
@onready var visual: Node2D = %Visual

var health := STARTING_HEALTH
var touching_mouse := false

func _ready() -> void:
	assert(bubble_scene.can_instantiate())
	assert(droplets_scene.can_instantiate())
	
	assert(refraction)
	assert(visual)
	
	velocity = Vector2.from_angle(randf_range(0, 2 * PI)) * SPEED

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		handle_collision(collision)
	visual.position = Vector2.ZERO
	visual.global_position = visual.global_position.round()

func _mouse_enter() -> void:
	ClickManager.register_hovered(self)

func _mouse_exit() -> void:
	ClickManager.unregister_hovered(self)
	
func _on_decay_timer_timeout() -> void:
	deal_decay_damage()

func handle_mouse_left_click():
	handle_mouse_right_click()
	deal_click_damage()

func handle_mouse_right_click():
	var mouse_pos = get_global_mouse_position()
	var global_pos = global_position
	velocity += (global_pos - mouse_pos).normalized() * MOUSE_PUSH_AMOUNT

func handle_collision(collision: KinematicCollision2D) -> void:
	bounce(collision)
	
	var collider = collision.get_collider()
	if collider is not Bubble:
		return
	
	hurt(BOUNCE_DAMAGE)

func bounce(collision: KinematicCollision2D) -> void:
	var bounced = velocity.bounce(collision.get_normal())
	velocity = bounced

func hurt(damage: int):
	health -= damage
	if health <= 0:
		handle_pop()
	
	# temp damage visualizer
	shake(damage / 2.)
	var c = (float(health) / STARTING_HEALTH)
	modulate = Color(1., c, c)

func handle_pop(gain_bubblebucks: bool = true) -> void:
	var droplets_instance = droplets_scene.instantiate()
	assert(droplets_instance is GPUParticles2D)
	droplets_instance.global_position = global_position
	get_parent().add_child(droplets_instance)
	droplets_instance.emitting = true
	GameState.bubbles -= 1
	
	if gain_bubblebucks:
		GameState.increase_bubblebucks(1)
	
	queue_free()

func deal_click_damage():
	var tier = GameState.bubble_click_damage_tier
	var lua = UpgradeLookup.bubble_click_damage_lua
	var damage = UpgradeLookup.value_lookup(tier, lua)
	hurt(damage)

func deal_decay_damage():
	var tier = GameState.bubble_decay_damage_tier
	var lua = UpgradeLookup.bubble_decay_damage_lua
	var damage = UpgradeLookup.value_lookup(tier, lua)
	hurt(damage)

func shake(magnitude: float) -> void:
	var duration := 0.1
	var interval := 0.02
	
	var tween := create_tween()
	var elapsed := 0.0
	
	while elapsed < duration:
		var offset = Vector2(
			randf_range(-magnitude, magnitude),
			randf_range(-magnitude, magnitude)
		)
		tween.tween_property(visual, "position", Vector2.ZERO + offset, interval)
		elapsed += interval
	tween.tween_property(visual, "position", Vector2.ZERO, interval)
