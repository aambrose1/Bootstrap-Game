extends CharacterBody2D

@export var SPEED = .01
@export var JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = get_node("../Player")
@onready var screen_notifier = $VisibleOnScreenNotifier2D
const bullet = preload("res://Scenes/Projectile/projectile.tscn")

func _physics_process(delta: float) -> void:
	if not screen_notifier.is_on_screen():
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Flip sprite to face player, but stay upright
	if player.position.x < position.x:
		animated_sprite.flip_h = true  # Face left
	else:
		animated_sprite.flip_h = false  # Face right

	self.position = lerp(self.position,player.position,SPEED)
	

	move_and_slide()
