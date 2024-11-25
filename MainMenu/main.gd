extends Node













func _on_tree_entered() -> void:
	MultiplayerManager.s1.connect(main_menu_send_username)


func _on_tree_exiting() -> void:
	MultiplayerManager.s1.disconnect(main_menu_send_username)




func main_menu_send_username() -> void:
	MultiplayerManager.join_lobby($LineEdit.text)






func _on_quick_texture_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://Lobby/lobby_menu.tscn")
	MultiplayerManager.establish_connection()
	pass # Replace with function body.
