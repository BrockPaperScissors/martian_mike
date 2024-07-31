extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("game_reset"):
		get_tree().reload_current_scene()
