class_name Player_Overworld extends CharacterBody2D

@export var speed : float = 100
@export var accel : float = 10
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var direction : Vector2

func _physics_process(_delta: float) -> void:
	direction.x = Input.get_axis("left_O", "right_O")
	direction.y = Input.get_axis("down_O", "up_O")
	direction = direction.normalized()
	
	if direction.x:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	
	if direction.y:
		velocity.y = direction.y * speed
	else:
		velocity.y = move_toward(velocity.y, speed * direction.y, accel)
		
	if direction.x > 0:
		animated_sprite.play("Right")
	elif direction.x < 0:
		animated_sprite.play("Left")
	elif direction.y > 0:
		animated_sprite.play("Down")
	elif direction.y < 0:
		animated_sprite.play("Up")
	else:
		animated_sprite.pause()
		
	move_and_slide()
