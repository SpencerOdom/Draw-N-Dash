extends Node

# TODO: The lobby should be loaded automatically.
# TODO: The lobby will connect to the multiplayer on the games start.

var multiplayer_peer = ENetMultiplayerPeer.new()

# TODO: Put these in the ignore file.
#const ADDRESS = ""
#const PORT: int = 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#change_phase(0)
	$".".add_child(load("res://Lobby/lobby_menu.tscn").instantiate())
	
	#if multiplayer_peer.get_connection_status() == 0:
	#	print("Creating a connection.\n", get_stack())
	#	multiplayer_peer.create_client(ADDRESS, PORT)
	#	multiplayer.multiplayer_peer = multiplayer_peer
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

#@rpc
#func client_func(data: int):
#	print(data, '\n', get_stack())

@rpc("any_peer")
func change_phase(data: int):
	print("next phase, ", data, '\n', get_stack())
	var level = $"."
	
	# Clear current level.
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	
	#Adding new level.
	match data:
		0:
			level.add_child(load("res://Lobby/lobby_menu.tscn").instantiate())
		# Normal Gamemode
		1:
			level.add_child(load("res://Gamemodes/Normal/starting_word_prompt.tscn").instantiate())
	pass
