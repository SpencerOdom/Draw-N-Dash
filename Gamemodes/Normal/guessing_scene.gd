extends Control

@onready var line_edit = $LineEdit  # Adjust path if LineEdit is not directly under Control
@onready var button = get_node("/root/GuessingScene/SubmitButtonGuess")

# Flag to track if the timer has finished
var timer_finished: bool = false


func _on_tree_entered() -> void:
	MultiplayerManager.submit_string.connect(guessing_scene_send_prompt)
	pass # Replace with function body.


func _on_tree_exiting() -> void:
	MultiplayerManager.submit_string.disconnect(guessing_scene_send_prompt)
	pass # Replace with function body.


func _ready():
	#$Timer.start()
	# Disconnect the signal if it's already connected
	if !$Timer.is_connected("timeout", Callable(self, "_on_timer_timeout")):
		#$Timer.disconnect("timeout", Callable(self, "_on_timer_timeout"))
	
		# Reconnect the signal
		$Timer.connect("timeout", Callable(self, "_on_timer_timeout"))
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
