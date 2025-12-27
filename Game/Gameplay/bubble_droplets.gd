extends RigidBody2D

func _ready() -> void:
	var x_force = randf_range(-700, 700)
	var y_force = randf_range(-500, 0)
	apply_central_force(Vector2(x_force, y_force))

func _physics_process(_delta: float) -> void:
	var screen_y = WindowManagerAutoload.BASE_SCREEN_SIZE.y
	var water_level = (0.5 * screen_y) - (screen_y * GameState.water_fill_ratio)
	if position.y >= water_level:
		GameState.collected_droplets += 1
		queue_free()
