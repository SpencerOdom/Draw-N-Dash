extends Node

@onready var multiplayer_peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()

const ADDRESS = "130.157.167.146"
const PORT: int = 80


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		print("MultiplayerMangager _ready func called.\n", get_stack())
		if multiplayer_peer.get_connection_status() == 0:
				print("Creating a connection.\n", get_stack())
				multiplayer_peer.create_client(ADDRESS, PORT)
				multiplayer.multiplayer_peer = multiplayer_peer
		pass # Replace with function body.


func get_multiplayer_peer() -> ENetMultiplayerPeer:
		return multiplayer_peer


func _on_scene_changed():
		print("MultiplayerManager scene changed func called.\n", get_stack())

		#var peer = MultiplayerManager.get_multiplayer_peer()
		#if !peer.is_connected():
		if multiplayer_peer.get_ocnnection_status() == 0:
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
