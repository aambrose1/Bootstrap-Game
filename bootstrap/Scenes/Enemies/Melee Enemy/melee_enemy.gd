extends CharacterBody2D

@export var SPEED = .05
@export var JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = get_node("../Player")
@onready var enemy_screen_notifier = $EnemyOnScreen

func _physics_process(delta: float) -> void:
	if not enemy_screen_notifier.is_on_screen():
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Flip sprite to face player, but stay upright
	if player.global_position.x < global_position.x:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
	# Move towards the player
	global_position = lerp(global_position, player.global_position, SPEED)
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		var body = collision.get_collider()
		if body.name == "Player":
			get_tree().quit()
	
	move_and_slide()
