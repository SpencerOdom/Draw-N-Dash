extends Control

@onready var line_edit = $LineEdit  # Adjust path if LineEdit is not directly under Control
@onready var button = get_node("/root/GuessingScene/SubmitButtonGuess")

# Flag to track if the timer has finished
var timer_finished: bool = false

func _ready():
	#$Timer.start()
	# Disconnect the signal if it's already connected
	if !$Timer.is_connected("timeout", Callable(self, "_on_timer_timeout")):
		#$Timer.disconnect("timeout", Callable(self, "_on_timer_timeout"))
	
		# Reconnect the signal
		$Timer.connect("timeout", Callable(self, "_on_timer_timeout"))
		button.connect("pressed", Callable(self, "_on_quick_texture_button_pressed"))

@rpc("any_peer")
func client_start_timer(_time: float) -> void:
	$Timer.wait_time = _time
	$Timer.start()
	pass

func _process(_delta: float) -> void:
	# Only update the label if the timer is running
	# TODO: Remove this; we will be going to the next phase once the time expires.
	if not timer_finished:
		$TimeRemaining.text = "%d" % $Timer.time_left

func _on_quick_texture_button_pressed() -> void:
	var user_text = line_edit.text
	print_debug("User entered: ", user_text)
	# Add your custom handling here (e.g., pass the text to another part of your game)
	# TODO: Submit prompt

@rpc("any_peer")
func submit_prompt() -> void:
	rpc_id(1, "set_user_prompt", MultiplayerManager.get_self_id(), $LineEdit.text)
	pass

func _on_timer_timeout() -> void:
	# Set the flag to indicate the timer has finished
	timer_finished = true

# TODO: next_phase
