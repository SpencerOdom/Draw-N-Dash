extends Node

@onready var multiplayer_peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()

signal intstring_1(_i: int, _s: String)

const ADDRESS = "130.157.167.146"
#const ADDRESS = "130.157.167.94"
const PORT: int = 80
#const ADDRESS = "130.157.170.101"
#const PORT: int = 8101


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		#get_tree().change_scene_to_file("res://Lobby/lobby_menu.tscn")
		print("MultiplayerMangager _ready func called.\n", get_stack())
		if multiplayer_peer.get_connection_status() == 0:
				print("Creating a connection.\n", get_stack())
				multiplayer_peer.create_client(ADDRESS, PORT)
				multiplayer.multiplayer_peer = multiplayer_peer
		pass # Replace with function body.


func get_multiplayer_peer() -> ENetMultiplayerPeer:
		return multiplayer_peer

func get_self_id() -> int:
	return multiplayer_peer.get_unique_id()

func _on_scene_changed():
		print("MultiplayerManager scene changed func called.\n", get_stack())

		#var peer = MultiplayerManager.get_multiplayer_peer()
		#if !peer.is_connected():
		if multiplayer_peer.get_connection_status() == 0:
				# Handle reconnection or other necessary steps
				print("Handing reconnetion.\n", get_stack())
				pass


#@rpc("any_peer")
#func client_code():
#	print("Time Out.\n", get_stack())
#	pass

@rpc("any_peer")
func client_connected(_id: int):
	print(_id, " connected.\n", get_stack())
	pass





# ************************************
# Main Menu
# ************************************


func to_lobby() -> void:
	# TODO: Connection should go here.
	get_tree().change_scene_to_file("res://Lobby/lobby_menu.tscn")
	pass



# ************************************
# Lobby
# ************************************


func get_player_list() -> void:
	rpc_id(1, "send_player_list", multiplayer_peer.get_unique_id())
	pass


func call_server_to_start_game() -> void:
	rpc_id(1, "server_start_game")
	pass


@rpc("any_peer")
func append_player_to_lobby_list(_id: int, _user: String) -> void:
	emit_signal('intstring_1', _id, _user)
	pass


@rpc("any_peer")
func client_start_game() -> void:
	print("Starting Game.\n", get_stack())
	get_tree().change_scene_to_file("res://Gamemodes/Normal/starting_word_prompt.tscn")
	pass

# Server

@rpc("any_peer")
func send_player_list(_id: int) -> void:
	pass

@rpc("any_peer")
func server_start_game() -> void:
	pass




# ************************************
# Starting Guessing phase
# ************************************





# submit_prompt


















# hi
