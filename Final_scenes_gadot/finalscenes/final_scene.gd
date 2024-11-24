extends Node2D

# Placeholder variables
var display_image_path: String = "res://Mainmenuimage/menuupdate.jpg"
var desired_size: Vector2 = Vector2(500, 500)  # Desired width and height in pixels
var label_text: String = "Image has been updated!"  # The text to display in the Label

var switch = true


func _ready():
	# Connect the button's pressed signal
	var button = get_node("QuickTextureButton")
	button.connect("pressed", Callable(self, "_on_quick_texture_button_pressed"))
	print("Debug: Button pressed!")


func _on_quick_texture_button_pressed() -> void:
	
	if(switch):
		MultiplayerManager.get_next_prompt()
		switch = false
	else:	
		MultiplayerManager.get_next_drawing()
		switch = true
		


func _on_tree_entered() -> void:
	MultiplayerManager.shot_prompt_signal.connect(display_prompt)
	MultiplayerManager.shot_drawing_signal.connect(display_drawing)
	
func display_prompt(txt: String) -> void:
	var parent_node = $ScrollContainer/VBoxContainer
	# Create a new Label node
	var label = Label.new()
	label.text = txt
	parent_node.add_child(label)
	

func display_drawing(img: Node2D) -> void:
	var parent_node = $ScrollContainer/VBoxContainer
	parent_node.add_child(img)  # Add the image (now referencing img) to the scene
	
func _on_tree_exiting() -> void:
	MultiplayerManager.shot_prompt_signal.disconnect(display_prompt)
	MultiplayerManager.shot_drawing_signal.disconnect(display_drawing)
