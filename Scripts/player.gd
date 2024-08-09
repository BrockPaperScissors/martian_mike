extends CharacterBody2D
class_name Player

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

@export var gravity = 400
@export var speed = 250
@export var jump_force = 175

var active = true

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
	
	var direction = 0
	
	if active == true:
		direction = Input.get_axis("move_left", "move_right")
		
		if Input.is_action_just_pressed("move_jump") && is_on_floor():
			jump(jump_force, direction)
			
		
		
	
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
		
	velocity.x = direction * speed
	
	move_and_slide()
	update_animations(direction)
	
func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y > 0:
			animated_sprite.play("fall")
		else:
			animated_sprite.play("jump")
	
func jump(force, direction):
	velocity.y = -force
	
	var initial_direction = direction
	
	if initial_direction == -1:
		animation_player.play("flip_left")
	if initial_direction == 1:
		animation_player.play("flip_right")
