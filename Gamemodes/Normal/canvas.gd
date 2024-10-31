## This is canvas.gd
#extends Node2D
#
#
#@onready var _lines: Node2D = $Line2D
#
#var _pressed: bool = false
#var _current_line: Line2D = null
#
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#_pressed = event.pressed
			#
			#if _pressed:
				#_current_line = Line2D.new()
				#_current_line.default_color = Color.BLACK
				#_current_line.width = 12
				#_lines.add_child(_current_line)
				#_current_line.add_point(event.position)
				#
	#elif event is InputEventMouseMotion and _pressed:
		#_current_line.add_point(event.position)

# This is canvas.gd
extends Node2D

@onready var _lines: Node2D = $Line2D
@onready var pencil_button = $PencilButton  # Assuming button nodes in the scene
@onready var eraser_button = $EraserButton

var _pressed: bool = false
var _current_line: Line2D = null
var tool_mode: String = "pencil"  # Tracks the current tool, either "pencil" or "eraser"

# Load custom cursor images
var pencil_cursor_texture = preload("res://Cursor_Images/pencil-cursor.png")
var eraser_cursor_texture = preload("res://Cursor_Images/eraser-cursor.png")

# Define hotspot positions for custom cursors
var pencil_cursor_hotspot = Vector2(0, 16)  # Adjust as needed for the active part of the pencil
var eraser_cursor_hotspot = Vector2(0, 16)  # Adjust as needed for the eraser center

# Called when the pencil button is pressed
func _on_pencil_button_pressed() -> void:
	tool_mode = "pencil"
	Input.set_custom_mouse_cursor(pencil_cursor_texture, Input.CURSOR_ARROW, pencil_cursor_hotspot)  # Set cursor to pencil image

# Called when the eraser button is pressed
func _on_eraser_button_pressed() -> void:
	tool_mode = "eraser"
	Input.set_custom_mouse_cursor(eraser_cursor_texture, Input.CURSOR_ARROW, eraser_cursor_hotspot)  # Set cursor to eraser image

# Main input function
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_pressed = event.pressed
			
			if _pressed:
				_current_line = Line2D.new()
				
				if tool_mode == "pencil":
					_current_line.default_color = Color.BLACK
					_current_line.width = 12
				elif tool_mode == "eraser":
					_current_line.default_color = Color.WHITE  # Transparent color for erasing
					_current_line.width = 24  # Larger width for the eraser effect

				_lines.add_child(_current_line)
				_current_line.add_point(event.position)
				
	elif event is InputEventMouseMotion and _pressed:
		_current_line.add_point(event.position)


# Connect button signals in _ready
func _ready():
	pencil_button.connect("pressed", Callable(self, "_on_pencil_button_pressed"))
	eraser_button.connect("pressed", Callable(self, "_on_eraser_button_pressed"))
