extends Node

@onready var multiplayer_peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()

signal intstring_1(_i: int, _s: String)
signal submit_string
signal submit_node2d
signal shot_prompt_signal(txt: String)
signal shot_drawing_signal(img: Node2D)

const ADDRESS = "130.157.167.146"
#const ADDRESS = "130.157.167.94"
const PORT: int = 80
#const ADDRESS = "130.157.170.101"
#const PORT: int = 8101


# Change these?
@export var prompt_time: float = 30.0
@export var drawing_time: float = 60.0


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

# More logic needed for our own timers.

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
# Prompt Phase
# ************************************


func send_prompt(txt: String):
	rpc_id(1, "set_user_prompt",  multiplayer_peer.get_unique_id(), txt)
	pass


@rpc("any_peer")
func submit_prompt() -> void:
	emit_signal('submit_string')
	pass

# TODO: Update
@rpc("any_peer")
func client_draw_phase() -> void:
	print("Chaning to drawing scene.\n", get_stack())
	get_tree().change_scene_to_file("res://Gamemodes/Normal/drawing_canvas_old.tscn")
	# Emit to send prompt
	pass



# Server

@rpc("any_peer")
func set_user_prompt(_id: int, _prompt: int) -> void:
	pass




# ************************************
# Drawing Phase
# ************************************


func send_drawing(image: Node2D) -> void:
	rpc_id(1, "set_user_drawing", multiplayer_peer.get_unique_id(), image)
	pass


@rpc("any_peer")
func submit_drawing() -> void:
	emit_signal('submit_drawing')
	pass

@rpc("any_peer")
func client_prompt_phase() -> void:
	print("Chaing to prompt phase.\n", get_stack())
	get_tree().change_scene_to_file("res://Gamemodes/Normal/guessing_Scene.tscn")
	pass


# Server

@rpc("any_peer")
func set_user_drawing(_id: int, _img: Node2D) -> void:
	pass




# ************************************
# End Phase
# ************************************

# TODO:

func get_next_prompt() -> void:
	shot_prompt()
	pass


func get_next_drawing() -> void:
	shot_drawing()
	pass


func shot_prompt() -> void:
	emit_signal('shot_prompt_signal', "wiebfousbefobefo")
	pass


func shot_drawing() -> void:
	var img: Node2D = $Canvas/Line2D
	emit_signal('shot_drawing_signal', img)
	pass




# hi
# **
