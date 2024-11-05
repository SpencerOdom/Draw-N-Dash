extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_host_button_pressed() -> void:
	#var current_scene_file = get_tree().current_scene.select_file_path
	var gamemodedropdown = $CanvasLayer/MainMenu/VBoxContainer/VBoxContainer/HostGameField/GamemodeDropDown
	print("Gamemode index ", gamemodedropdown.selected, " selected")
	
	match gamemodedropdown.selected:
		0:
			print("Starting gamemode Normal.")
			get_tree().change_scene_to_file("res://Gamemodes/Normal/starting_word_prompt.tscn")
			return # Will this cause issues?
		1:
			# More game modes will follow.
			print("Case 1")
	print_stack()
	
	pass # Replace with function body.
