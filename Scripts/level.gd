extends Node2D

@export var next_level: PackedScene = null
@export var level_time = 5
@export var is_final_level: bool = false

@onready var start_position = $Start
@onready var exit_level = $ExitArea
@onready var death_zone = $DeathZone
@onready var hud = $UILayer/HUD
@onready var ui_layer = $UILayer


var player = null
var timer_node = null
var time_left
var win = false

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	if player != null:
		player.global_position = start_position.get_spawn_pos()
	
	var traps = get_tree().get_nodes_in_group("traps")
	
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)
		
	exit_level.body_entered.connect(_on_exit_body_entered)
	death_zone.body_entered.connect(_on_death_zone_body_entered)
	
	time_left = level_time
	hud.set_time_label(time_left)
	
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	
	timer_node.start()
	
func _process(delta):
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("game_reset"):
		get_tree().reload_current_scene()

func _on_death_zone_body_entered(body):
	AudioPlayer.play_sound("hurt")
	reset_player()

func _on_trap_touched_player():
	AudioPlayer.play_sound("hurt")
	reset_player()

func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = start_position.get_spawn_pos()

func _on_exit_body_entered(body):
	if body is Player:
		if is_final_level || (next_level != null):
			win = true
			exit_level.animate()
			player.active = false
			await get_tree().create_timer(1.5).timeout
			
			if is_final_level:
				ui_layer.show_win_screen(true)
			else:
				get_tree().change_scene_to_packed(next_level)

func _on_level_timer_timeout():
	if win != true:
		time_left -= 1
		hud.set_time_label(time_left)
	
	if time_left < 0:
		AudioPlayer.play_sound("hurt")
		reset_player()
		time_left = level_time
		hud.set_time_label(time_left)
