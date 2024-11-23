extends Node


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

# Flag to track if the timer has finished
var timer_finished: bool = false

func _ready() -> void:
	
	if !$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.is_connected("timeout", Callable(self, "_on_timer_timeout")):
		# Reconnect the signal
		$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.connect("timeout", Callable(self, "_on_timer_timeout"))

#@rpc("any_peer")
#func client_start_timer(_time: float) -> void:
	#$Timer.wait_time = _time
	#$Timer.start()
	#pass

func _process(_delta: float) -> void:
	
	# Only update the label if the timer is running
	# TODO: Remove this.
	if not timer_finished:
		$Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/TimeRemaining.text = "%d" % $Main_VBoxContainer/Phrase_MarginContainer/MarginContainer/Timer.time_left

func _on_timer_timeout() -> void:
	# Set the flag to indicate the timer has finished
	timer_finished = true

#@rpc("any_peer")
#func submit_canvas() -> void:
	#pass
