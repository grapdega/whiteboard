extends AntialiasedLine2D

export var color = Color.black

export var pressed = false

export var mode = "spline"

export var begin = Vector2.ZERO
export var end = Vector2.ZERO

func set_size(size):
	width = size
	add_to_group("curveline")


func add(pos):

	if mode == "spline":
		add_point(pos)
	else:
		if begin == Vector2.ZERO:
			begin = pos
		end = pos
