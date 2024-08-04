extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

@export var bounce_height = 0

func _on_body_entered(body):
	if body is Player:
		body.jump(bounce_height)
