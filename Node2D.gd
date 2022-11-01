extends Node2D

export var size = 1.9
export var color = Color.white

func _ready():
	get_tree().get_root().set_transparent_background(true)

var _pressed := false
var _curve = []
var state = {}
func _input(event:InputEvent) -> void:
	update()
	# Tocuh screen
	if  event is InputEventScreenTouch:
		_pressed = event.pressed
		if event.pressed: # Down.
			var cur = preload("res://CurveLine.gd").new()
			cur.size = size
			cur.color = color
			cur.pressed = true
			state[event.index] = cur
		else: # Up.
			state[event.index].pressed = false
			_curve.append(state[event.index])
			state.erase(event.index)
	if event is InputEventScreenDrag:
		if state[event.index].pressed:
			state[event.index].add(event.position)
			return
	
	# mouse
	if event is InputEventMouseButton:
		_pressed = event.pressed
		if _pressed:
			var cur = preload("res://CurveLine.gd").new()
			cur.size = size
			cur.color = color
			cur.pressed = true
			_curve.append(cur)
		else:
			_curve[-1].pressed = false
	if event is InputEventMouseMotion:
		if len(_curve) == 0:
			return
		if _curve[-1].pressed:
			_curve[-1].add(event.position)
			return

func _draw():
	var cur = null
	if _curve != null:
		for _c in _curve:
			cur = _c
			if cur.pget().size() >= 2:
				draw_polyline(cur.pget(),cur.color,_c.size,true)
		for _c in state.keys():
			cur = state[_c]
			if cur.pget().size() >= 2:
				draw_polyline(cur.pget(),cur.color,cur.size,true)

