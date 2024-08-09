extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

@export var bounce_height = 0

func _on_body_entered(body):
	var from_above = 0
	if body is Player:
		body.jump(bounce_height, from_above)
