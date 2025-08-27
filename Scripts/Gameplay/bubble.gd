extends CharacterBody2D

const droplets_scene = preload("uid://dtcbmrnwmh1m6")

var touching_mouse := false

func _ready() -> void:
	assert(droplets_scene is PackedScene)
	assert(droplets_scene.can_instantiate())
	
	velocity = Vector2.from_angle(randf_range(0, 2 * PI)) * 128

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var bounce = velocity.bounce(collision.get_normal())
		position += bounce / 128
		velocity = bounce

func _input(event: InputEvent):
	if touching_mouse and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			handle_pop()

func _mouse_enter() -> void:
	touching_mouse = true

func _mouse_exit() -> void:
	touching_mouse = false

func handle_pop() -> void:
	var droplets_instance = droplets_scene.instantiate()
	assert(droplets_instance is GPUParticles2D)
	droplets_instance.global_position = global_position
	get_parent().add_child(droplets_instance)
	droplets_instance.emitting = true
	queue_free()
