extends Node2D

var bubble_packed = preload("uid://de7lvnyp8gqh2")

func _on_add_bubble_pressed() -> void:
	var scene = bubble_packed.instantiate()
	#scene.position = Vector2(randf(-))
	add_child(scene)
