extends Node2D

# Placeholder variables
var display_image_path: String = "res://Mainmenuimage/menuupdate.jpg"
var desired_size: Vector2 = Vector2(500, 500)  # Desired width and height in pixels
var label_text: String = "Image has been updated!"  # The text to display in the Label


func _ready():
	# Connect the button's pressed signal
	if !$QuickTextureButton.is_connected("pressed", Callable(self, "_on_quick_texture_button_pressed")):
		print("Final Scene is having to connect button.\n", get_stack())
		$QuickTextureButton.connect("pressed", Callable(self, "_on_quick_texture_button_pressed"))



func _on_quick_texture_button_pressed() -> void:
	MultiplayerManager.get_next_submition()



func _on_tree_entered() -> void:
	MultiplayerManager.shot_cycle_signal.connect(start_cycle)
	MultiplayerManager.shot_prompt_signal.connect(display_prompt)
	MultiplayerManager.shot_drawing_signal.connect(display_drawing)

func _on_tree_exiting() -> void:
	MultiplayerManager.shot_cycle_signal.disconnect(start_cycle)
	MultiplayerManager.shot_prompt_signal.disconnect(display_prompt)
	MultiplayerManager.shot_drawing_signal.disconnect(display_drawing)



func start_cycle(id:int, username:String, txt: String) -> void:
	for child in $ScrollContainer/VBoxContainer.get_children():
		$ScrollContainer/VBoxContainer.remove_child(child)
		child.queue_free()  # Properly deletes the child node
	display_prompt(id, username, txt)
	pass


func deserialize_image(serialized_data: Dictionary) -> Line2D:
	var node = Line2D.new()
	
	node.name = serialized_data["name"]
	node.antialiased = serialized_data["antialiased"]
	node.begin_cap_mode = serialized_data["begin_cap_mode"]
	node.closed = serialized_data["closed"]
	node.default_color = serialized_data["default_color"]
	node.end_cap_mode = serialized_data["end_cap_mode"]
	node.gradient = serialized_data["gradient"]
	node.joint_mode = serialized_data["joint_mode"]
	node.points = serialized_data["points"]
	node.round_precision = serialized_data["round_precision"]
	node.sharp_limit = serialized_data["sharp_limit"]
	node.sharp_limit = serialized_data["sharp_limit"]
	node.texture = serialized_data["texture"]
	node.width = serialized_data["width"]
	node.width_curve = serialized_data["width_curve"]
	
	# Recursively add children
	for child_data in serialized_data["children"]:
		var child_node = deserialize_image(child_data) # Recursively recreate child nodes
		node.add_child(child_node)

	return node


func display_prompt(id:int, username:String, txt: String) -> void:
	print("display_prompt\n", get_stack())
	
	# Load the font resource
	var custom_font = FontFile.new()
	custom_font.font_data = load("res://Fonts/Godot-Fontpack-master/fonts/linux-libertine/LinLibertine_5.3.0_2012_07_02/LinLibertineOTF_5.3.0_2012_07_02/LinLibertine_RB.otf")
	
	var prompt_container = HBoxContainer.new()
	prompt_container.add_theme_constant_override("separation", 122)
	
	var author_credit_container = VBoxContainer.new()
	
	var icon = TextureRect.new()
	icon.texture = load("res://icon.svg")
	author_credit_container.add_child(icon)
	
	
	# Adding Username(Label) Theme Overrides
	var name_container = Label.new()
	name_container.text = username
	name_container.add_theme_font_size_override("size", 36)
	name_container.add_theme_font_override("font", custom_font)
	name_container.add_theme_color_override("color", Color.BLACK)
	author_credit_container.add_child(name_container)
	
	
	# Adding ID(Label) Theme Overrides
	var id_container = Label.new()
	id_container.text = str(id)
	id_container.add_theme_font_size_override("size", 36)
	id_container.add_theme_font_override("font", custom_font)
	id_container.add_theme_color_override("color", Color.BLACK)
	author_credit_container.add_child(id_container)
	
	
	#Adding the VBOXContainer to the HBOXContainer
	prompt_container.add_child(author_credit_container)
	
	
	#Adding prompt(Label) Theme Overrides
	var label = Label.new()
	label.text = txt
	label.add_theme_font_size_override("font_size", 115)
	label.add_theme_font_override("font", custom_font)
	label.add_theme_color_override("color", Color.BLACK)
	prompt_container.add_child(label)
	
	
	$ScrollContainer/VBoxContainer.add_child(prompt_container)
	pass


func display_drawing(id:int, username:String, img: Dictionary) -> void:
	print("display_drawing\n", get_stack())
	
	# Load the font resource
	var custom_font = FontFile.new()
	custom_font.font_data = load("res://Fonts/Godot-Fontpack-master/fonts/linux-libertine/LinLibertine_5.3.0_2012_07_02/LinLibertineOTF_5.3.0_2012_07_02/LinLibertine_RB.otf")
	
	
	var drawing_container = HBoxContainer.new()
	
	
	var image = Node2D.new()
	image.add_child(deserialize_image(img))
	drawing_container.add_child(image)
	
	
	var author_credit_container = VBoxContainer.new()
	
	
	var icon = TextureRect.new()
	icon.texture = load("res://icon.svg")
	author_credit_container.add_child(icon)
	
	
	# Adding Username(Label) Theme Overrides
	var name_container = Label.new()
	name_container.text = username
	name_container.add_theme_font_size_override("size", 36)
	name_container.add_theme_font_override("font", custom_font)
	name_container.add_theme_color_override("color", Color.BLACK)
	author_credit_container.add_child(name_container)
	
	
	# Adding ID(Label) Theme Overrides
	var id_container = Label.new()
	id_container.text = str(id)
	id_container.add_theme_font_size_override("size", 36)
	id_container.add_theme_font_override("font", custom_font)
	id_container.add_theme_color_override("color", Color.BLACK)
	author_credit_container.add_child(id_container)
	
	
	var spacer = ColorRect.new()
	spacer.custom_minimum_size.y = 500
	spacer.color.a = 0
	
	
	author_credit_container.add_child(spacer)
	
	drawing_container.add_child(author_credit_container)
	
	
	$ScrollContainer/VBoxContainer.add_child(drawing_container)  # Add the image (now referencing img) to the scene
