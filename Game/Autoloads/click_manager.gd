class_name ClickManagerAutoload extends Node

var _mouse_left_down = false
var _hold_click_cooldown: float

var _hovered_window_corner: GameWindow = null
var _hovered_window_title_bar: GameWindowTitleBar = null
var _hovered_spawner: BubbleSpawner = null
var _hovered_bubble: Bubble = null

func _ready() -> void:
	_hold_click_cooldown = _get_hold_click_cooldown_duration()
	GameState.hold_click_cooldown_tier_updated.connect(func (_value: int):
		_hold_click_cooldown = _get_hold_click_cooldown_duration()
		print(_hold_click_cooldown)
	)

func _process(delta: float) -> void:
	if _hold_click_cooldown == 0.: 
		if _mouse_left_down:
			_handle_left_hold_click()
		return
	
	_hold_click_cooldown -= delta
	if _hold_click_cooldown < 0.:
		_hold_click_cooldown = 0.

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				_handle_left_click()
			else:
				_handle_left_unclick()
		else:
			if event.pressed:
				_handle_right_click()

func _handle_left_click() -> void:
	_mouse_left_down = true
	if _hovered_window_corner:
		_hovered_window_corner.handle_mouse_left_click()
	elif _hovered_window_title_bar:
		_hovered_window_title_bar.handle_mouse_left_click()
	elif _hovered_spawner:
		_hovered_spawner.handle_mouse_left_click()
	elif _hovered_bubble:
		_hovered_bubble.handle_mouse_left_click()

func _handle_left_hold_click() -> void:
	_hold_click_cooldown = _get_hold_click_cooldown_duration()
	if _hovered_spawner:
		_hovered_spawner.handle_mouse_left_click()
	elif _hovered_bubble:
		_hovered_bubble.handle_mouse_left_click()

func _handle_left_unclick() -> void:
	_mouse_left_down = false
	if _hovered_window_corner:
		Input.set_default_cursor_shape(Input.CursorShape.CURSOR_ARROW)
		_hovered_window_corner.handle_mouse_left_unclick()
	elif _hovered_window_title_bar:
		_hovered_window_title_bar.handle_mouse_left_unclick()

func _handle_right_click() -> void:
	if _hovered_window_corner:
		pass
	elif _hovered_window_title_bar:
		pass
	elif _hovered_spawner:
		pass
	elif _hovered_bubble:
		_hovered_bubble.handle_mouse_right_click()

func _get_hold_click_cooldown_duration() -> float:
	var tier = GameState.hold_click_cooldown_tier
	var lua = UpgradeLookup.hold_click_cooldown_lua
	return UpgradeLookup.value_lookup(tier, lua)

func register_hovered(item):
	if item is GameWindow:
		_hovered_window_corner = item
		Input.set_default_cursor_shape(Input.CursorShape.CURSOR_FDIAGSIZE)
	elif item is GameWindowTitleBar:
		_hovered_window_title_bar = item
	elif item is BubbleSpawner:
		_hovered_spawner = item
	elif item is Bubble:
		_hovered_bubble = item
	else:
		assert(false, "Unknown item type tried to register in ClickManager:\n" + str(item))

func unregister_hovered(item):
	if item is GameWindow:
		if _hovered_window_corner == item:
			_hovered_window_corner = null
			Input.set_default_cursor_shape(Input.CursorShape.CURSOR_ARROW)
	elif item is GameWindowTitleBar:
		if _hovered_window_title_bar == item:
			_hovered_window_title_bar = null
	elif item is BubbleSpawner:
		if _hovered_spawner == item:
			_hovered_spawner = null
	elif item is Bubble:
		if _hovered_bubble == item:
			_hovered_bubble = null
	else:
		assert(false, "Unknown item type tried to unregister in ClickManager")
