extends Node

# TODO: Make the dissconnected players dissapear

#signal connect
#signal dissconnect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

# The player ID may be a string and not an int.
func add_player_to_list(olayername: String, olayerID: int) -> void:
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
