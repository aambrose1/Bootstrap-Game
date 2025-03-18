extends CharacterBody2D

var parent_name = "Pirate"
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_screen_notifier = $PlayerOnScreen
@onready var first_on_screen = false
@export var health = 12
enum FORM {DEFAULT, PIRATE, COWBOY, SOLDIER, TOMMY, JET, BOOM}
const damage = 1
var attacking: bool = false
var is_unlocked: bool = false
@onready var health_ui: Control = $"Camera2D/Health Interface"
@onready var hitbox1: Area2D = $Hitbox1
@onready var hitbox2: Area2D = $Hitbox2


func _physics_process(delta: float) -> void:
	# Once the player has been on screen at least once, we start tracking
	if player_screen_notifier.is_on_screen():
		first_on_screen = true

	# Only quit if the player has been seen and then goes off-screen
	if first_on_screen and not player_screen_notifier.is_on_screen():
		get_tree().change_scene_to_file("res://Scenes/Hub World/hub_city.tscn")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	# Handle jump.
	if Input.is_action_just_pressed("jump_L") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left_L", "right_O")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# Flip the sprites
	update_animations()
	if sign(direction) == 1:
		animated_sprite.flip_h = false
		
		
	if sign(direction) == -1:
		animated_sprite.flip_h = true
		
	if Input.is_action_just_pressed("attack"):
		attack()
		
		
	move_and_slide()

func take_damage():
	health -= 1
	if health == 0:
		get_tree().change_scene_to_file("res://Scenes/Hub World/hub_city.tscn")
	update_health()
	
func restore_health():
	health += 1
	
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
		if animated_sprite.flip_h == false:
			hitbox1.monitoring = true
			hitbox2.monitoring = false
		if animated_sprite.flip_h == true:
			hitbox1.monitoring = false
			hitbox2.monitoring = true
	else:
		hitbox1.monitoring = false
		hitbox2.monitoring = false

func update_health():
	health_ui.update_health(health)
 
func _on_animated_sprite_2d_animation_finished() -> void:
	attacking = false



func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtboxes"):
		area.get_parent().take_damage()
