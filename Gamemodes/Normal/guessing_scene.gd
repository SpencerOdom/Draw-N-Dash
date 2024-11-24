extends Control

@onready var line_edit = $LineEdit  # Adjust path if LineEdit is not directly under Control
@onready var button = get_node("/root/GuessingScene/SubmitButtonGuess")

# Flag to track if the timer has finished
var timer_finished: bool = false


func _on_tree_entered() -> void:
	MultiplayerManager.submit_string.connect(guessing_scene_send_prompt)
	MultiplayerManager.set_drawing_signal.connect(guessing_scene_set_drawing)
	pass # Replace with function body.


func _on_tree_exiting() -> void:
	MultiplayerManager.submit_string.disconnect(guessing_scene_send_prompt)
	MultiplayerManager.set_drawing_signal.disconnect(guessing_scene_set_drawing)
	pass # Replace with function body.


func _ready():
	#$Timer.start()
	# Disconnect the signal if it's already connected
	if !$Timer.is_connected("timeout", Callable(self, "_on_timer_timeout")):
		# Reconnect the signal
		$Timer.connect("timeout", Callable(self, "_on_timer_timeout"))
		
	if !button.is_connected("pressed", Callable(self, "_on_quick_texture_button_pressed")):
		button.connect("pressed", Callable(self, "_on_quick_texture_button_pressed"))
		
	$Timer.wait_time = MultiplayerManager.prompt_time
	$Timer.start()



func _process(_delta: float) -> void:
	# Only update the label if the timer is running
	# TODO: Remove this; we will be going to the next phase once the time expires.
	if not timer_finished:
		$TimeRemaining.text = "%d" % $Timer.time_left



func _on_quick_texture_button_pressed() -> void:
	print_debug("User entered: ", $LineEdit.text)
	MultiplayerManager.send_prompt($LineEdit.text)
	# TODO: Submit prompt



func _on_timer_timeout() -> void:
	# Set the flag to indicate the timer has finished
	timer_finished = true

# TODO: next_phase



func guessing_scene_send_prompt() -> void:
	MultiplayerManager.send_prompt($LineEdit.text)
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



func guessing_scene_set_drawing(_img: Dictionary) -> void:
	#add_child(_img)
	#add_child(_img.instantiate())
	
	print("guessing scene has recieve the \"image\": ", _img, '\n\n')
	
	# TODO: Deserialize the data
	var deserialized_img:Line2D = deserialize_image(_img)
	
	$Node2D.add_child(deserialized_img)
	
	pass
