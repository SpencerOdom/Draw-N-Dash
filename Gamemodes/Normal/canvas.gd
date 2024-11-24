# This is canvas.gd
extends Node2D

@onready var _lines: Node2D = $Line2D
@onready var pencil_button = get_node("/root/DrawingCanvas/Main_VBoxContainer/MainBody_HBoxContainer/UtilityBar_VBoxContainer/PencilButton")
@onready var eraser_button = get_node("/root/DrawingCanvas/Main_VBoxContainer/MainBody_HBoxContainer/UtilityBar_VBoxContainer/EraserButton")

@onready var black_button = get_node("/root/DrawingCanvas/Main_VBoxContainer/MainBody_HBoxContainer/ColorSelectVBoxContainer/BlackTextureButton")
@onready var blue_button = get_node("/root/DrawingCanvas/Main_VBoxContainer/MainBody_HBoxContainer/ColorSelectVBoxContainer/BlueTextureButton")
@onready var yellow_button = get_node("/root/DrawingCanvas/Main_VBoxContainer/MainBody_HBoxContainer/ColorSelectVBoxContainer/YellowTextureButton")
@onready var red_button = get_node("/root/DrawingCanvas/Main_VBoxContainer/MainBody_HBoxContainer/ColorSelectVBoxContainer/RedTextureButton")
@onready var green_button = get_node("/root/DrawingCanvas/Main_VBoxContainer/MainBody_HBoxContainer/ColorSelectVBoxContainer/GreenTextureButton")
@onready var purple_button = get_node("/root/DrawingCanvas/Main_VBoxContainer/MainBody_HBoxContainer/ColorSelectVBoxContainer/PurpleTextureButton")
@onready var orange_button = get_node("/root/DrawingCanvas/Main_VBoxContainer/MainBody_HBoxContainer/ColorSelectVBoxContainer/OrangeTextureButton")

@onready var musicAudioStreamBG = $"AudioStreamPlayer2D"

var _pressed: bool = false
var _current_line: Line2D = null
var tool_mode: String = "pencil"  # Tracks the current tool, either "pencil" or "eraser"
var current_color: Color = Color.BLACK  # Default color

# Load custom cursor images
var pencil_cursor_texture = preload("res://Cursor_Images/pencil_cursor.png")
var eraser_cursor_texture = preload("res://Cursor_Images/eraser_cursor.png")

# Define hotspot positions for custom cursors
var pencil_cursor_hotspot = Vector2(0, 16)
var eraser_cursor_hotspot = Vector2(0, 16)

# Music Variable definition
var BackgroundMusicOn = true

# Called when the pencil button is pressed
func _on_pencil_button_pressed() -> void:
	tool_mode = "pencil"
	Input.set_custom_mouse_cursor(pencil_cursor_texture, Input.CURSOR_ARROW, pencil_cursor_hotspot)

# Called when the eraser button is pressed
func _on_eraser_button_pressed() -> void:
	tool_mode = "eraser"
	Input.set_custom_mouse_cursor(eraser_cursor_texture, Input.CURSOR_ARROW, eraser_cursor_hotspot)


	
	
# Called when a color button is pressed
func _set_current_color(color: Color) -> void:
	current_color = color
	tool_mode = "pencil"  # Ensure we're in pencil mode when selecting a color
	Input.set_custom_mouse_cursor(pencil_cursor_texture, Input.CURSOR_ARROW, pencil_cursor_hotspot)

# Main input function
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_pressed = event.pressed
			
			if _pressed:
				_current_line = Line2D.new()
				
				if tool_mode == "pencil":
					_current_line.default_color = current_color
					_current_line.width = 12
				elif tool_mode == "eraser":
					_current_line.default_color = Color.WHITE
					_current_line.width = 24

				_lines.add_child(_current_line)
				_current_line.add_point(event.position)
				
	elif event is InputEventMouseMotion and _pressed:
		_current_line.add_point(event.position)

# Connect button signals in _ready
func _ready():
	# Tool buttons
	pencil_button.connect("pressed", Callable(self, "_on_pencil_button_pressed"))
	eraser_button.connect("pressed", Callable(self, "_on_eraser_button_pressed"))
	
	# Color buttons
	black_button.connect("pressed", Callable(self, "_set_current_color").bind(Color.BLACK))
	red_button.connect("pressed", Callable(self, "_set_current_color").bind(Color(1, 0, 0)))
	blue_button.connect("pressed", Callable(self, "_set_current_color").bind(Color(0, 0, 1)))
	yellow_button.connect("pressed", Callable(self, "_set_current_color").bind(Color(1, 1, 0)))
	green_button.connect("pressed", Callable(self, "_set_current_color").bind(Color(0, 1, 0)))
	orange_button.connect("pressed", Callable(self, "_set_current_color").bind(Color(1, 0.5, 0)))
	purple_button.connect("pressed", Callable(self, "_set_current_color").bind(Color(0.5, 0, 0.5)))

func _process(delta):
	update_music_stats()
	
func update_music_stats():
	if BackgroundMusicOn:
		if !musicAudioStreamBG.playing:
			musicAudioStreamBG.play()
	else:
		musicAudioStreamBG.stop()


func get_image() -> Node2D:
	return _lines


#func _on_clear_button_pressed() -> void:
	#for child in _lines.get_children():
		#_lines.remove_child(child)
		#child.queue_free()  # Properly deletes the Line2D node
