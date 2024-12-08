extends Node

@onready var multiplayer_peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()

signal s1

signal intintstring_1(_i1: int, _i2: int, _s: String)

signal submit_string
signal submit_dictionary

# Prompt and Drawing phase signals
signal set_prompt_signal(_txt: String)
signal set_drawing_signal(_img: Dictionary)

# End Phase Signals
signal shot_cycle_signal(id:int, icon:int, username:String, txt: String)
signal shot_prompt_signal(id:int, icon:int, username:String, txt: String)
signal shot_drawing_signal(id:int, icon:int, username:String, img: Dictionary)

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
		
		#if multiplayer_peer.get_connection_status() == 0:
		#	print("Creating a connection.\n", get_stack())
		#	multiplayer_peer.create_client(ADDRESS, PORT)
		#	multiplayer.multiplayer_peer = multiplayer_peer
		
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


@rpc("any_peer")
func client_connected(_id: int):
	print(_id, " connected.\n", get_stack())
	emit_signal('s1')
	pass





# ************************************
# Main Menu
# ************************************


func establish_connection() -> void:
	
	if multiplayer_peer.get_connection_status() == 0:
		print("Creating a connection.\n", get_stack())
		multiplayer_peer.create_client(ADDRESS, PORT)
		multiplayer.multiplayer_peer = multiplayer_peer

	pass


#@rpc("any_peer")
#func send_username() -> void:
#	emit_signal('s1')
#	pass


func join_lobby(username: String) -> void:
	rpc_id(1, "set_user_name", multiplayer_peer.get_unique_id(), username)
	await get_tree().create_timer(1).timeout # Prevents duplicate names - of self - from appearing in the lobby
	get_tree().change_scene_to_file("res://Lobby/lobby_menu.tscn")
	pass


@rpc("any_peer")
func return_to_lobby() -> void:
	print("Returning to Lobby menu.\n", get_stack())
	get_tree().change_scene_to_file("res://Lobby/lobby_menu.tscn")
	pass


# Server

@rpc("any_peer")
func set_user_name(_id: int, _usr: String) -> void:
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
func append_player_to_lobby_list(_id: int, _icon: int, _user: String) -> void:
	emit_signal('intintstring_1', _id, _icon, _user)
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


@rpc("any_peer")
func client_draw_phase(_text: String) -> void:
	print("Chaning to drawing scene.\n", get_stack())
	get_tree().change_scene_to_file("res://Gamemodes/Normal/drawing_canvas_old.tscn")
	await get_tree().create_timer(1).timeout # Why
	emit_signal('set_prompt_signal', _text)
	pass



# Server

@rpc("any_peer")
func set_user_prompt(_id: int, _prompt: int) -> void:
	pass




# ************************************
# Drawing Phase
# ************************************


func send_drawing(_img: Dictionary) -> void:
	print("Send an image that is type of: ", typeof(_img))
	rpc_id(1, "set_user_drawing", multiplayer_peer.get_unique_id(), _img as Dictionary)
	pass


@rpc("any_peer")
func submit_drawing() -> void:
	emit_signal('submit_dictionary')
	pass

@rpc("any_peer")
func client_prompt_phase(_img: Dictionary) -> void:
	print("Chaing to prompt phase.\n", get_stack())
	print("Recieve an object of type: ", typeof(_img))
	
	#var packedscene_instance = _img as PackedScene
	#print("After converting, the object to a packed scene: ", typeof(packedscene_instance))
	
	get_tree().change_scene_to_file("res://Gamemodes/Normal/guessing_Scene.tscn")
	await get_tree().create_timer(1).timeout # Why
	emit_signal('set_drawing_signal', _img as Dictionary)
	pass


# End phase
@rpc("any_peer")
func client_end_phase() -> void:
	print("Changing scene to the Ending Phase.\n", get_stack())
	get_tree().change_scene_to_file("res://Final_scenes_gadot/finalscenes/final_scene.tscn")
	pass



# Server

@rpc("any_peer")
func set_user_drawing(_id: int, _img: Dictionary) -> void:
	pass




# ************************************
# End Phase
# ************************************

# TODO:

func get_next_prompt() -> void:
	rpc_id(1, "send_next_prompt")
	pass


func get_next_drawing() -> void:
	rpc_id(1, "send_next_drawing")
	pass


func get_next_submition() -> void:
	rpc_id(1, "send_next_submition")
	pass


@rpc("any_peer")
func shot_cycle(_id: int, _icon: int, _usr: String, _prompt: String) -> void:
	emit_signal('shot_cycle_signal', _id, _icon, _usr, _prompt)
	pass


@rpc("any_peer")
func shot_prompt(_id: int, _icon: int, _usr: String, _prompt: String) -> void:
	emit_signal('shot_prompt_signal', _id, _icon, _usr, _prompt)
	pass


@rpc("any_peer")
func shot_drawing(_id: int, _icon: int, _usr: String, _img: Dictionary) -> void:
	emit_signal('shot_drawing_signal', _id, _icon, _usr, _img)
	pass




# Server

@rpc("any_peer")
func send_next_submition() -> void:
	pass


@rpc("any_peer")
func send_next_prompt() -> void:
	pass


@rpc("any_peer")
func send_next_drawing() -> void:
	pass


# hi
# *****
