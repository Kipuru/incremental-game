extends Button

signal award_points

@onready var timer: Timer = $SquareTimer

var collectable = false
var wait_time = 3.0

func _pressed() -> void:
	pass
	if collectable:
		award_points.emit()
		collectable = false
		text = ""
		timer.start(wait_time)
	else:
		timer.decrement_time()


func _on_square_timer_timeout() -> void:
	collectable = true
	text = "READY"
