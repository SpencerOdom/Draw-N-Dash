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
	
	pass







@rpc("any_peer")
func client_start_timer(_time: float) -> void:
	$Timer.wait_time = _time
	$Timer.start()
	pass





 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Only update the label if the timer is running
	# TODO: Remove this; we will be changing scenes when
	if not timer_finished:
		$TimeRemaining.text = "%d" % $Timer.time_left








@rpc("any_peer")
func submit_prompt() -> void:
	rpc_id(1, "set_users_prompt", MultiplayerManager.get_self_id(), $UserPrompt.text)
	pass

func _on_timer_timeout() -> void:
	# Set the flag to indicate the timer has finished
	timer_finished = true

@rpc("any_peer")
func set_users_prompt(_id: int, _prompt: String) -> void:
	pass

func _on_submit_button_pressed() -> void:
	print_debug("User entered: ", $UserPrompt.text)
	rpc_id(1, "set_users_prompt", MultiplayerManager.get_self_id(), $UserPrompt.text)

@rpc("any_peer")
func client_draw_phase() -> void:
	get_tree().change_scene_to_file("res://Gamemodes/Normal/drawing_canvas_old.tscn")
	pass
