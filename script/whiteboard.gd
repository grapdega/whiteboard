extends Node2D

export var size = 3
export var color = Color.white
export var mode = "curve"

func _ready():
	get_tree().get_root().set_transparent_background(true)

var _pressed := false
var _curve = []
var state = {}
var update_request = false

func create_cur():
	var cur = preload("res://script/CurveLine.gd").new()
	cur.size = size
	cur.color = color
	cur.pressed = true
	cur.mode = mode
	return cur

func _input(event:InputEvent) -> void:
	# Tocuh screen
	if  event is InputEventScreenTouch:
		_pressed = event.pressed
		if event.pressed: # Down.
			state[event.index] = create_cur()
		else: # Up.
			state[event.index].pressed = false
			_curve.append(state[event.index])
			state.erase(event.index)
	if event is InputEventScreenDrag:
		if state[event.index].pressed:
			state[event.index].add(event.position)
			update_request = true

	
	# mouse
	if event is InputEventMouseButton:
		_pressed = event.pressed
		if _pressed:
			_curve.append(create_cur())
		else:
			_curve[-1].pressed = false
	if event is InputEventMouseMotion:
		if len(_curve) == 0:
			return
		if _curve[-1].pressed:
			_curve[-1].add(get_global_mouse_position())
			update_request = true

func _physics_process(delta):
	if update_request:
		update()
		update_request = false
	if Input.is_key_pressed(KEY_L):
		mode = "line"
	if Input.is_key_pressed(KEY_S):
		mode = "spline"
	if Input.is_key_pressed(KEY_C):
		mode = "circle"

func _draw():
	var cur = null
	if _curve != null:
		for _c in _curve:
			cur = _c
			_draw_common(cur)
		for _c in state.keys():
			cur = state[_c]
			_draw_common(cur)

func _draw_common(cur):
		if cur.mode == "line":
			draw_line(cur.begin,cur.end,cur.color,5,true)
		elif cur.mode == "circle":
			draw_arc(cur.begin,calc_radius(cur.begin,cur.end),0,TAU,1024,cur.color,cur.size,true)
		elif cur.mode == "spline":
			if cur.pget().size() >= 2:
				draw_polyline(cur.pget(),cur.color,cur.size,true)

func calc_radius(a,b):
	return b.y-a.y