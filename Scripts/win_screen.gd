extends Control

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")


func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
