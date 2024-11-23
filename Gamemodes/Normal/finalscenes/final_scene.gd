extends Node2D

# Placeholder variables
var display_image_path: String = "res://Mainmenuimage/menuupdate.jpg"
var desired_size: Vector2 = Vector2(500, 500)  # Desired width and height in pixels
var label_text: String = "Image has been updated!"  # The text to display in the Label


func _ready():
	# Connect the button's pressed signal
	var button = get_node("QuickTextureButton")
	button.connect("pressed", Callable(self, "_on_quick_texture_button_pressed"))

func _on_quick_texture_button_pressed() -> void:
	# Get the Sprite node
	var sprite = $Sprite

	var label = $Label  # Adjust this path to match your scene structure
	label.text = label_text

	# Ensure display_image_path is set
	if display_image_path != "":
		var texture = load(display_image_path)
		if texture:
			# Apply the texture to the Sprite
			sprite.texture = texture

			# Calculate and apply the scale for the desired size
			var texture_size = sprite.texture.get_size()
			sprite.scale = desired_size / texture_size
		else:
			print("Failed to load texture: ", display_image_path)

	
