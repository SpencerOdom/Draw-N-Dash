extends Node2D

# TODO: Make it so that the player can only draw whats on the canvas.


@onready var _lines: Node2D = $Line2D

var _pressed: bool = false
var _current_line: Line2D = null

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_pressed = event.pressed
			
			if _pressed:
				_current_line = Line2D.new()
				_current_line.default_color = Color.BLACK
				_current_line.width = 12
				_lines.add_child(_current_line)
				_current_line.add_point(event.position)
				
	elif event is InputEventMouseMotion and _pressed:
		_current_line.add_point(event.position)
