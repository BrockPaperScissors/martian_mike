extends Node2D

@onready var start_position = $StartPosition

@onready  var player = $Player

func _ready():
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)
		
	
func _process(delta):
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("game_reset"):
		get_tree().reload_current_scene()

func _on_death_zone_body_entered(body):
	reset_player()

func _on_trap_touched_player():
	reset_player()

func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = start_position.global_position
