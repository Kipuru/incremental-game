class_name Bubble extends CharacterBody2D

const bubble_scene = preload("uid://cqegup4gnccd3")
const droplets_scene = preload("uid://dtcbmrnwmh1m6")

const SPEED = 64
const STARTING_HEALTH = 50
const BOUNCE_DAMAGE = 5

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
	position = position.round()

func _input(event: InputEvent):
	if touching_mouse and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not BubbleSpawner.touching_mouse: # small hack to prevent popping bubbles under the spawner
				deal_click_damage()

func _mouse_enter() -> void:
	touching_mouse = true

func _mouse_exit() -> void:
	touching_mouse = false
	
func _on_decay_timer_timeout() -> void:
	deal_decay_damage()

func handle_collision(collision: KinematicCollision2D) -> void:
	bounce(collision)
	
	var collider = collision.get_collider()
	if collider is not Bubble:
		return
	
	hurt(BOUNCE_DAMAGE)

func bounce(collision: KinematicCollision2D) -> void:
	var bounced = velocity.bounce(collision.get_normal())
	position += bounced / 128
	velocity = bounced

func hurt(damage: int):
	health -= damage
	if health <= 0:
		handle_pop()
	
	# temp damage visualizer
	shake(damage)
	var c = (float(health) / STARTING_HEALTH)
	modulate = Color(1., c, c)

func handle_pop() -> void:
	var droplets_instance = droplets_scene.instantiate()
	assert(droplets_instance is GPUParticles2D)
	droplets_instance.global_position = global_position
	get_parent().add_child(droplets_instance)
	droplets_instance.emitting = true
	GameState.bubbles += 1
	queue_free()

func deal_click_damage():
	var tier = GameState.bubble_click_damage_tier
	var lua = TierHelper.bubble_click_damage_lua
	var damage = TierHelper.value_lookup(tier, lua)
	hurt(damage)

func deal_decay_damage():
	var tier = GameState.bubble_click_damage_tier
	var lua = TierHelper.bubble_click_damage_lua
	var damage = TierHelper.value_lookup(tier, lua)
	hurt(damage)

func shake(magnitude: int) -> void:
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
