extends Node

<<<<<<< Updated upstream

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


"""
@rpc("any_peer")
func client_start_game() -> void:
	print("Client Start Game.\n", get_stack())
	get_tree().change_scene_to_file("res://Gamemodes/Normal/starting_word_prompt.tscn")
	pass


@rpc("any_peer")
func server_start_game() -> void:
	pass
"""
=======
# Flag to track if the timer has finished
var timer_finished: bool = false

func _ready() -> void:
	# Start the Timer when the scene is loaded
	$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.start()
	
	# Disconnect the signal if it's already connected
	if $Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.is_connected("timeout", Callable(self, "_on_timer_timeout")):
		$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.disconnect("timeout", Callable(self, "_on_timer_timeout"))
	
	# Reconnect the signal
	$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _process(delta: float) -> void:
	# Only update the label if the timer is running
	if not timer_finished:
		$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/TimeRemaining.text = "%d" % $Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.time_left

func _on_timer_timeout() -> void:
	# Set the flag to indicate the timer has finished
	timer_finished = true
>>>>>>> Stashed changes
