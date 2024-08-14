extends Node

var hurt = preload("res://Assets/audio/hurt.wav")
var jump = preload("res://Assets/audio/jump.wav")

func _on_music_player_finished():
	$MusicPlayer.play()

func play_sound(sound_name: String):
	var stream = null
	if sound_name == "hurt":
		stream = hurt
	elif sound_name == "jump":
		stream = jump
	else:
		print("Invalid sound name")
		return

	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SoundEffect"
	add_child(asp)
	
	asp.play()
	
	await asp.finished
	asp.queue_free()
