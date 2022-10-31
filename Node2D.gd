extends Node2D

func _ready():
	get_tree().get_root().set_transparent_background(true)

onready var _lines := $Lines

var _pressed := false
var _current_line: Line2D

func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		_pressed = event.pressed
		
		if _pressed:
			_current_line = Line2D.new()
			_current_line.default_color = Color.white
			_current_line.width = 3
			_lines.add_child(_current_line)
			_current_line.antialiased = true
	if event is InputEventMouseMotion && _pressed:
		_current_line.add_point(event.position)
