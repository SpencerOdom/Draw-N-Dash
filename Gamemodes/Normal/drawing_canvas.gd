extends Node


func _on_tree_entered() -> void:
	MultiplayerManager.submit_node2d.connect(drawing_phase_shot_image)
	MultiplayerManager.set_prompt_signal.connect(drawing_phase_set_prompt)
	pass # Replace with function body.


func _on_tree_exiting() -> void:
	MultiplayerManager.submit_node2d.disconnect(drawing_phase_shot_image)
	MultiplayerManager.set_prompt_signal.disconnect(drawing_phase_set_prompt)
	pass # Replace with function body.


# Flag to track if the timer has finished
var timer_finished: bool = false

func _ready() -> void:
	
	if !$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.is_connected("timeout", Callable(self, "_on_timer_timeout")):
		# Reconnect the signal
		$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	
	$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.wait_time = MultiplayerManager.drawing_time
	$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.start()
	
	pass




func _process(_delta: float) -> void:
	
	# Only update the label if the timer is running
	# TODO: Remove this.
	if not timer_finished:
		$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/TimeRemaining.text = "%d" % $Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.time_left

func _on_timer_timeout() -> void:
	# Set the flag to indicate the timer has finished
	timer_finished = true




func drawing_phase_shot_image() -> void:
	MultiplayerManager.send_drawing($Canvas.get_image())
	pass


func drawing_phase_set_prompt(_txt: String) -> void:
	print("Setting Drawing Canvas prompt to: ", _txt)
	$Main_VBoxContainer/Phrase_MarginContainer/DrawingLabel.set_text(_txt)
	pass


func _on_submit_button_pressed() -> void:
	print("Our item is of type: ", typeof($Canvas.get_image()))
	MultiplayerManager.send_drawing($Canvas.get_image())
	pass # Replace with function body.
