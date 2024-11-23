extends Node

# TODO: Make the dissconnected players dissapear


func _on_tree_entered() -> void:
	MultiplayerManager.intstring_1.connect(add_player_to_list)
	pass # Replace with function body.

func _on_tree_exiting() -> void:
	MultiplayerManager.intstring_1.disconnect(add_player_to_list)
	pass # Replace with function body.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Lobby _ready.\n", get_stack())
	
	# Get player list.
	MultiplayerManager.get_player_list()
	
	#print("Port is ", MultiplayerManager.PORT, "\n", get_stack()) # Works :D
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


# The player ID may be a string and not an int.
func add_player_to_list(olayerID: int, olayername: String) -> void:
	print("Adding a player to list.\n", get_stack())
	
	var olayer = HBoxContainer.new()
	
	var icon = TextureRect.new()
	icon.texture = load("res://icon.svg")
	olayer.add_child(icon)
	
	var identity = VBoxContainer.new()
	olayer.add_child(identity)
	
	var olayer_name = LineEdit.new()
	olayer_name.text = olayername
	olayer_name.set_editable(false)
	identity.add_child(olayer_name)
	
	var olayer_id = LineEdit.new()
	olayer_id.text = str(olayerID)
	olayer_id.set_editable(false)
	identity.add_child(olayer_id)
	
	$HBoxContainer/PlayersInLobby/PlayerList.add_child(olayer)
	
	pass


func _on_start_button_pressed() -> void:
	MultiplayerManager.call_server_to_start_game()
	pass # Replace with function body.




# DONE: Change the order of operations.

"""


@rpc("any_peer")
func client_start_game() -> void:
	print("Client Start Game.\n", get_stack())
	get_tree().change_scene_to_file("res://Gamemodes/Normal/starting_word_prompt.tscn")
	pass


@rpc("any_peer")
func server_start_game() -> void:
	pass

# Start Game.
func _on_start_game_button_pressed() -> void:
	#rpc_id(1, "lobby_server_code")
	#print("Starting Game.\n", get_stack())
	
	rpc_id(1, "server_start_game")
	
	#get_tree().change_scene_to_file("res://Gamemodes/Normal/starting_word_prompt.tscn")
	pass # Replace with function body.
"""











# Ignore

"""
# These do not work. The servers active scene need to be the same with their peers.

@rpc("any_peer")
func lobby_server_code():
	pass
	
@rpc("any_peer")
func lobby_client_code():
	print("lobby client code called.\n", get_stack())
	pass
"""
