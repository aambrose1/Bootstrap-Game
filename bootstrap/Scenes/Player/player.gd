extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_screen_notifier = $PlayerOnScreen
@onready var first_on_screen = false
const bullet = preload("res://Scenes/Projectile/projectile.tscn")

func _physics_process(delta: float) -> void:
	# Once the player has been on screen at least once, we start tracking
	if player_screen_notifier.is_on_screen():
		first_on_screen = true

	# Only quit if the player has been seen and then goes off-screen
	if first_on_screen and not player_screen_notifier.is_on_screen():
		get_tree().quit()
	
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
		
	# Shooting projectiles
	if Input.is_action_just_pressed("attack"):
		var temp_proj = bullet.instantiate()
		if sign($Marker2D.position.x) == 1:
			temp_proj.set_direction(1)
		else:
			temp_proj.set_direction(-1)
		get_parent().add_child(temp_proj)
		temp_proj.position = $Marker2D.global_position
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
