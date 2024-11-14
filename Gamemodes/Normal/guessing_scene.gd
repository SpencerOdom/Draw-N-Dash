extends Control

@onready var line_edit = $LineEdit  # Adjust path if LineEdit is not directly under Control
#@onready var button = $QuickTextureButton       # Adjust path if Button is not directly under Control
@onready var button = get_node("/root/GuessingScene/SubmitButtonGuess")

func _ready():
	button.connect("pressed", Callable(self, "_on_quick_texture_button_pressed"))

func _on_quick_texture_button_pressed() -> void:
	var user_text = line_edit.text
	print("User entered: ", user_text)
	# Add your custom handling here (e.g., pass the text to another part of your game)
