extends CharacterBody2D


var parent_name = "Mobster"
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_screen_notifier = $PlayerOnScreen
@onready var first_on_screen = false
@export var health: int = 12
@onready var health_ui: Control = $"Camera2D/Health Interface"
@onready var attack_delay: Timer = $attack_delay
const bullet = preload("res://Scenes/Projectile/mobster_proj.tscn")
var can_shoot = true
var is_unlocked: bool = false

enum FORM {DEFAULT, PIRATE, COWBOY, SOLDIER, TOMMY, JET, BOOM}

func _physics_process(delta: float) -> void:
	# Once the player has been on screen at least once, we start tracking
	update_health()
	
	
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
	
		# Flip the sprites
	if sign(direction) == 1:
		animated_sprite.flip_h = false
		$Marker2D.position.x = 1
		
	if sign(direction) == -1:
		animated_sprite.flip_h = true
		if sign($Marker2D.position.x) == 1:
			$Marker2D.position.x  = -1
	update_animations()
		
	# Shooting projectiles
	while Input.is_action_pressed("attack") and can_shoot == true:
		animated_sprite.play("attack")
		attack_delay.start()
		attack()

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
func update_form(FORM):
	pass
	
func attack():
		if can_shoot:
			can_shoot = false
			var bullet_rotation = randf_range(-5, 5)
			var temp_proj = bullet.instantiate()
			temp_proj.position = $Marker2D.global_position
			if sign($Marker2D.position.x) == 1:
				temp_proj.set_direction(1)
			else:
				temp_proj.set_direction(-1)
			
			temp_proj.global_rotation = bullet_rotation
			temp_proj.set_bullet_rotation(bullet_rotation)
			get_parent().add_child(temp_proj)
			
func update_health():
	health_ui.update_health(health)

func update_animations():
	if can_shoot == false:
		if velocity.x != 0:
			animated_sprite.play("move")
		else:
			animated_sprite.play("idle")
		
		if velocity.y < 0:
			animated_sprite.play("jump")
		if velocity.y > 0:
			animated_sprite.play("fall")


func _on_attack_delay_timeout() -> void:
	can_shoot = true

func take_damage():
	health -= 1
	if health == 0:
		get_tree().change_scene_to_file("res://Scenes/Hub World/hub_city.tscn")
	update_health()
	
func restore_health():
	health += 1
