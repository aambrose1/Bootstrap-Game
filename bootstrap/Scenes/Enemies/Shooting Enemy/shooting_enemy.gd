extends CharacterBody2D

@export var JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = get_node("../Player")
@onready var enemy_screen_notifier = $EnemyOnScreen
const bullet = preload("res://Scenes/Projectiles/Enemy Projectile/enemy_projectile.tscn")

func _physics_process(delta: float) -> void:
	if not enemy_screen_notifier.is_on_screen():
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Flip sprite to face player, but stay upright
	if player.global_position.x < global_position.x:
		animated_sprite.flip_h = true
		$Marker2D.position.x  = -1
	else:
		animated_sprite.flip_h = false
		$Marker2D.position.x  = 1
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		var body = collision.get_collider()
		if body.name == "Player":
			get_tree().quit()
	
	move_and_slide()

func _on_timer_timeout() -> void:
	var temp_proj = bullet.instantiate()
	if sign($Marker2D.position.x) == 1:
		temp_proj.set_direction(1)
	else:
		temp_proj.set_direction(-1)
	get_parent().add_child(temp_proj)
	temp_proj.position = $Marker2D.global_position
