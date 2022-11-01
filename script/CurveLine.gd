extends Curve2D

export var size = 2.0

export var color = Color.black

export var pressed = false

export var mode = "spline"

export var begin = Vector2.ZERO
export var end = Vector2.ZERO


func pget():
	return get_baked_points()

func add(pos):
	if mode == "spline":
		add_point(pos,Vector2.UP,Vector2.LEFT)
	else:
		if begin == Vector2.ZERO:
			begin = pos
		end = pos
