extends Timer

func decrement_time():
	var new_time = time_left - 0.2
	start(new_time)
