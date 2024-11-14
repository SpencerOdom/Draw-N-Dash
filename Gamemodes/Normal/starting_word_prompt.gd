extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$VBoxContainer/GameStuff/Timer.text = "%s" % roundf($Timer.time_left)
	# The "%s" indecates a string. The % after the string is to replace the LHS (string) with the RHS value(s).
	#if $Timer.time_left == 0: *submit signal*
	pass


func _on_submit_button_pressed() -> void:
	#var user_prompt = $VBoxContainer/HBoxContainer/UserPrompt
	#if user_prompt.text == "":
	#	print("No text provided for the prompt.")
	#elif user_prompt.text == "$ForceTimerOut":
	#	print("Emit a signal to cause a premature timeout.") # TODO: Read and complete the print statement.
	#else:
		#print(user_prompt.text)
	#print(user_prompt.text)
	pass # Replace with function body.
