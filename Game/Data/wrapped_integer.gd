# Wrapper class for int so we can store and pass by reference
# Supports observer pattern for updates
class_name WrappedInteger

signal updated(value: int)

var v: int:
	set(value):
		v = value
		updated.emit(value)

func _init(x):
	v = x
