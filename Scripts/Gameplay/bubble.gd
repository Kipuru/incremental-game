class_name Bubble extends CharacterBody2D

const bubble_scene = preload("uid://cqegup4gnccd3")
const droplets_scene = preload("uid://dtcbmrnwmh1m6")

@onready var refraction: Sprite2D = %Refraction

var tier := 0
var touching_mouse := false

func _ready() -> void:
	assert(bubble_scene.can_instantiate())
	assert(droplets_scene.can_instantiate())
	
	velocity = Vector2.from_angle(randf_range(0, 2 * PI)) * 64

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		handle_collision(collision)

func _input(event: InputEvent):
	if touching_mouse and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not BubbleSpawner.touching_mouse: # small hack to prevent popping bubbles under the spawner
				handle_pop()

func _mouse_enter() -> void:
	touching_mouse = true

func _mouse_exit() -> void:
	touching_mouse = false

func handle_collision(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	if collider is not Bubble:
		bounce(collision)
		return
	
	var bubble = collider as Bubble
	if bubble.tier != tier:
		bounce(collision)
		return
	
	bounce(collision) # temp, prevent merging until mechanic is fully implemented
	#merge_bubbles(bubble)

# Bubble with higher coordinate will spawn new bubble
func merge_bubbles(collided_with: Bubble) -> void:
	if position.x < collided_with.position.x:
		queue_free()
		return
	elif position.x == collided_with.position.x and position.y < collided_with.position.y:
		queue_free()
		return
	
	var bubble_instance = bubble_scene.instantiate()
	assert(bubble_instance is Bubble)
	bubble_instance.position = position.lerp(collided_with.position, 0.5) # avg position of both bubbles
	bubble_instance.velocity = velocity.lerp(collided_with.velocity, 0.5) # avg velocity of both bubbles
	get_parent().add_child(bubble_instance)
	bubble_instance.tier = tier + 1
	queue_free()

func bounce(collision: KinematicCollision2D) -> void:
	var bounced = velocity.bounce(collision.get_normal())
	position += bounced / 64
	velocity = bounced

func handle_pop() -> void:
	var droplets_instance = droplets_scene.instantiate()
	assert(droplets_instance is GPUParticles2D)
	droplets_instance.global_position = global_position
	get_parent().add_child(droplets_instance)
	droplets_instance.emitting = true
	queue_free()
