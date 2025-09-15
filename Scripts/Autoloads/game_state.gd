extends Node

signal bubbles_updated(bubbles: int)

var bubbles := 0:
	set(value):
		bubbles = value
		bubbles_updated.emit(value)
