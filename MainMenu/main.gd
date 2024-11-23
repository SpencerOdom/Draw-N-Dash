extends Node
# TODO: Maybe, have the connect to server here.

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_quick_texture_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://Lobby/lobby_menu.tscn")
	MultiplayerManager.to_lobby()
	pass # Replace with function body.

#@rpc("any_peer")
#func force_lobby() -> void:
#	print("Forcing Lobby.\n", get_stack())
#	_on_quick_texture_button_pressed()
#	pass
