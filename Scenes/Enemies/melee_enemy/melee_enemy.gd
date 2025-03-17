extends CharacterBody2D

@export var SPEED = .05
@export var JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = get_tree().get_nodes_in_group("player").front()
@onready var player_screen_notifier = $PlayerOnScreen
@export var health = 1
const damage = 1
var attacking: bool = false
@onready var hitbox: Area2D = $Hitbox


func _physics_process(delta: float) -> void:
	# Once the player has been on screen at least once, we start tracking
	if not player_screen_notifier.is_on_screen():
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
	
	attack()
	
	move_and_slide()

func take_damage():
	health -= 1
	if health == 0:
		queue_free()
	
func update_animations():
	if !attacking:
		if velocity.x != 0:
			animated_sprite.play("move")
		else:
			animated_sprite.play("idle")
		
		if velocity.y < 0:
			animated_sprite.play("jump")
		if velocity.y > 0:
			animated_sprite.play("fall")

func attack():
	attacking = true
	animated_sprite.play("attack")
	if (animated_sprite.frame == 3 or animated_sprite.frame == 4) and animated_sprite.animation == "attack":
		hitbox.monitoring = true
	else:
		hitbox.monitoring = false

func _on_animated_sprite_2d_animation_finished() -> void:
	attacking = false

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtboxes"):
		area.get_parent().take_damage()
