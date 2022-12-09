extends AntialiasedLine2D

export var color = Color.black

export var pressed = false

export var removed = false

export var mode = "spline"

export var begin = Vector2.ZERO
export var end = Vector2.ZERO

func set_size(size):
	width = size
	add_to_group("curveline")

func detect_line(pos,rec):
	for p in get_point_count():
		var x = pos.x - get_point_position(p).x
		var y = pos.y - get_point_position(p).y
		if x*x + y*y < rec*rec:
			return true
	return false

func add(pos):

	if mode == "spline":
		add_point(pos)
	else:
		if begin == Vector2.ZERO:
			begin = pos
		end = pos
