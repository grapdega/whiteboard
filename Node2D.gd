extends Node2D

func _ready():
	_curve = []
	get_tree().get_root().set_transparent_background(true)

var _pressed := false
var _curve = null
var lastpos = null

func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		_pressed = event.pressed
		if _pressed:
			_curve.append(Curve2D.new())
			lastpos = null
	if event is InputEventMouseMotion && _pressed:
		var epos = event.position
		if lastpos != null:
			epos.x = (lastpos.x + epos.x) /2
			epos.y = (lastpos.y + epos.y) /2
		lastpos = event.position
		_curve[-1].add_point(epos)
	update()

func _draw():
	if _curve != null:
		for _c in _curve:
			draw_polyline(_c.get_baked_points(),Color.white,2.0,true)
