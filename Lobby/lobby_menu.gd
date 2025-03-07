extends Node

# TODO: Make the dissconnected players dissapear
var playerIcons = [
	"res://Player_Icons/AngryCactus.png", 	# 0
	"res://Player_Icons/CoolBro.png",		# 1
	"res://Player_Icons/CoolGirl.png",		# 2
	"res://Player_Icons/CowboyCactus.png",	# 3
	"res://Player_Icons/FancyPizza.png",		# 4
	"res://Player_Icons/Lady.png",			# 5
	"res://Player_Icons/Man.png",			# 6
	"res://Player_Icons/MrBeach.png",		# 7
	"res://Player_Icons/Pizza.png",			# 8
	"res://Player_Icons/SaltBae.png"			# 9
	]

func _on_tree_entered() -> void:
	MultiplayerManager.intintstring_1.connect(add_player_to_list)
	pass # Replace with function body.

func _on_tree_exiting() -> void:
	MultiplayerManager.intintstring_1.disconnect(add_player_to_list)
	pass # Replace with function body.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioPlayingStream.play_music_level()
	print("Lobby _ready.\n", get_stack())
	
	# Get player list.
	MultiplayerManager.get_player_list()
	
	#print("Port is ", MultiplayerManager.PORT, "\n", get_stack()) # Works :D
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


# The player ID may be a string and not an int.
func add_player_to_list(olayerID: int, olayerICON: int, olayername: String) -> void:
	print("Adding a player to list.\n", get_stack())
	
	var olayer = HBoxContainer.new()
	
	var icon = TextureRect.new()
	icon.texture = load(playerIcons[olayerICON])
	olayer.add_child(icon)
	
	var identity = VBoxContainer.new()
	olayer.add_child(identity)
	
	# Load the font resource
	var custom_font = FontFile.new()
	custom_font.font_data = load("res://Fonts/Godot-Fontpack-master/fonts/linux-libertine/LinLibertine_5.3.0_2012_07_02/LinLibertineOTF_5.3.0_2012_07_02/LinLibertine_RB.otf")
	
	# Ensure you create an instance of StyleBoxEmpty
	var empty_stylebox = StyleBoxEmpty.new()
	
	#This is for the First Line Edit With Player Username
	var layout_name = Vector2(170,60) #Variable with Set Values
	var olayer_name = LineEdit.new()
	olayer_name.text = olayername
	olayer_name.alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	#Layout Changes
	olayer_name.set_custom_minimum_size(layout_name)
	
	#Theme Overrides
	olayer_name.add_theme_constant_override("outline_size", 25)
	olayer_name.add_theme_font_override("font", custom_font)
	olayer_name.add_theme_font_size_override("font_size", 20)
	olayer_name.add_theme_stylebox_override("normal", empty_stylebox)
	olayer_name.add_theme_color_override("font_color", Color(0, 0.624, 0.941))
	
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
	olayer_id.add_theme_stylebox_override("normal", empty_stylebox)
	olayer_id.add_theme_color_override("font_color", Color(0.692, 0.864, 1))


	olayer_id.set_editable(false)
	identity.add_child(olayer_id)
	
	$HBoxContainer/PlayersInLobby/ScrollContainer/PlayerList.add_child(olayer)
	pass


func _on_start_button_pressed() -> void:
	MultiplayerManager.call_server_to_start_game()
	pass # Replace with function body.
