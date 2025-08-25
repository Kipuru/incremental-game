extends TextureRect

func _ready() -> void:
	material.set_shader_parameter('fill', 0.)

func _on_fill_amount_value_changed(value: float) -> void:
	material.set_shader_parameter('fill', value)
