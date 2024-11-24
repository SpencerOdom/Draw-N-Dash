extends Node

@onready var line_edit = $UserPrompt  # Adjust path if LineEdit is not directly under Control
@onready var button = get_node("SubmitButtonStartPhrase")

# Flag to track if the timer has finished
var timer_finished: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !$Timer.is_connected("timeout", Callable(self, "_on_timer_timeout")):
		# Reconnect the signal
		$Timer.connect("timeout", Callable(self, "_on_timer_timeout"))
		
	if !$SubmitButtonStartPhrase.is_connected("pressed", Callable(self, "_on_submit_button_pressed")):
		button.connect("pressed", Callable(self, "_on_submit_button_pressed"))
	
	$Timer.wait_time = MultiplayerManager.prompt_time
	$Timer.one_shot = true
	$Timer.start()
	
	pass



func _on_tree_entered() -> void:
	MultiplayerManager.submit_string.connect(staring_prompt_shot_prompt)
	pass # Replace with function body.

func _on_tree_exiting() -> void:
	MultiplayerManager.submit_string.disconnect(staring_prompt_shot_prompt)
	pass # Replace with function body.


func staring_prompt_shot_prompt() -> void:
	MultiplayerManager.send_prompt($UserPrompt.text)
	pass



 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Only update the label if the timer is running
	# TODO: Remove this; we will be changing scenes when
	if not timer_finished:
		$TimeRemaining.text = "%d" % $Timer.time_left



func _on_timer_timeout() -> void:
	# Set the flag to indicate the timer has finished
	timer_finished = true



func _on_submit_button_pressed() -> void:
	print_debug("User entered: ", $UserPrompt.text)
	MultiplayerManager.send_prompt($UserPrompt.text)
