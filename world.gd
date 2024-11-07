extends Node

# TODO: The lobby should be loaded automatically.
# TODO: The lobby will connect to the multiplayer on the games start.

var multiplayer_peer = ENetMultiplayerPeer.new()

# TODO: Put these in the ignore file.
const ADDRESS = "130.157.167.146"
const PORT: int = 80

#signal connect
#signal dissconnect

signal another_peer_connected
#signal another_peer_dissconnected

enum {WORLD, MAIN_MENU, LOBBY_MENU}

var current_lv: int = WORLD






# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_phase(1)
	# Change to main menu
	#$".".add_child(load("res://MainMenu/main.tscn").instantiate())
	#current_lv = MAIN_MENU
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
func change_phase(_data: int):
	print("next phase, ", _data, '\n', get_stack())
	var level = $"."
	
	# Clear current level.
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	
	#Adding new level.
	match _data:
		0:
			print("Changing level to MAIN MENU.\n", get_stack())
			current_lv = MAIN_MENU
			level.add_child(load("res://MainMenu/main.tscn").instantiate())
			#current_lv = MAIN_MENU
		1:
			print("Changing level to LOBBY.\n", get_stack())
			current_lv = LOBBY_MENU
			level.add_child(load("res://Lobby/lobby_menu.tscn").instantiate())
			#current_lv = LOBBY_MENU
			if multiplayer_peer.get_connection_status() == 0:
				print("Creating a connection.\n", get_stack())
				multiplayer_peer.create_client(ADDRESS, PORT)
				multiplayer.multiplayer_peer = multiplayer_peer
		2: # Normal Gamemode
			level.add_child(load("res://Gamemodes/Normal/starting_word_prompt.tscn").instantiate())
	pass

# Why don't we just connect the signals in the change level function?
# We may not know what to dissconnect. But we can probably find out.
func _on_child_entered_tree(node: Node) -> void:
	match current_lv:
		MAIN_MENU:
			print(get_stack())
		LOBBY_MENU:
			print("Connecting Lobby signals.\n", get_stack())
			another_peer_connected.connect(node.add_player_to_list)	
	pass # Replace with function body.

func _on_child_exiting_tree(node: Node) -> void:
	match current_lv:
		LOBBY_MENU:
			print("Dissconnecting Lobby signals.\n", get_stack())
			another_peer_connected.disconnect(node.add_player_to_list)
	pass # Replace with function body.


@rpc("any_peer")
func another_connection(_new_peer_id: int):
	print("another connection called.\n", get_stack())
	another_peer_connected.emit("user", _new_peer_id)
	pass
