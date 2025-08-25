extends CharacterBody2D

func _ready() -> void:
	velocity = Vector2.from_angle(randf_range(0, 2 * PI)) * 128

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var bounce = velocity.bounce(collision.get_normal())
		position += bounce / 128
		velocity = bounce
