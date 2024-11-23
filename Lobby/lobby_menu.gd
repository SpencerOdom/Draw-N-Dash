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
	
	# Load the font resource
	var custom_font = FontFile.new()
	custom_font.font_data = load("res://Fonts/Godot-Fontpack-master/fonts/linux-libertine/LinLibertine_5.3.0_2012_07_02/LinLibertineOTF_5.3.0_2012_07_02/LinLibertine_RZI.otf")
	
	#This is for the First Line Edit With Player Username
	var layout_name = Vector2(170,60) #Variable with Set Values
	var olayer_name = LineEdit.new()
	olayer_name.text = olayername
	olayer_name.alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	#Layout Changes
	olayer_name.set_custom_minimum_size(layout_name)
	
	#Theme Overrides
	olayer_name.add_theme_font_override("font", custom_font)
	olayer_name.add_theme_font_size_override("font_size", 20)
	#olayer_name.add_theme_color_override("theme_override_colors/font_color", Color(0, 1, 1, 1))
	
	olayer_name.set_editable(false)
	identity.add_child(olayer_name)
	
	
	#This is for the Second Line Edit with Player ID
	var layout_id = Vector2(0,60)
	var olayer_id = LineEdit.new()
	olayer_id.text = str(olayerID)
	olayer_id.alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	#Layout Changes
	olayer_id.set_custom_minimum_size(layout_id)
	
	#Theme Overrides
	olayer_id.add_theme_font_override("font", custom_font)
	olayer_id.add_theme_font_size_override("font_size", 20)
	#olayer_id.add_theme_color_override("theme_override_colors/font_color", Color(0, 1, 1, 1))

	
	olayer_id.set_editable(false)
	identity.add_child(olayer_id)
	
	$HBoxContainer/PlayersInLobby/PlayerList.add_child(olayer)
	
	pass


func _on_start_button_pressed() -> void:
	MultiplayerManager.call_server_to_start_game()
	pass # Replace with function body.
