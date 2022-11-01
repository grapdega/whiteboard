extends Curve2D

export var size = 2.0

export var color = Color.black

export var pressed = false

var lastpos = null

func pget():
	return get_baked_points()

func add(pos):
	if lastpos != null:
		pos.x = (lastpos.x*3 + pos.x) /4
		pos.y = (lastpos.y*3 + pos.y) /4
	lastpos = pos
	add_point(pos)
