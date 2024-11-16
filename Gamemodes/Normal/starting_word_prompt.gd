extends Node

@onready var line_edit = $UserPrompt  # Adjust path if LineEdit is not directly under Control
@onready var button = get_node("/root/StartingWordPrompt/SubmitButtonStartPhrase")

# Flag to track if the timer has finished
var timer_finished: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	# Disconnect the signal if it's already connected
	if $Timer.is_connected("timeout", Callable(self, "_on_timer_timeout")):
		$Timer.disconnect("timeout", Callable(self, "_on_timer_timeout"))
	
	# Reconnect the signal
	$Timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	button.connect("pressed", Callable(self, "_on_quick_texture_button_pressed"))


 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Only update the label if the timer is running
	if not timer_finished:
		$TimeRemaining.text = "%d" % $Timer.time_left


func _on_timer_timeout() -> void:
	# Set the flag to indicate the timer has finished
	timer_finished = true


func _on_submit_button_pressed() -> void:
	var user_text = line_edit.text
	print_debug("User entered: ", user_text)
# Add your custom handling here (e.g., pass the text to another part of your game)
