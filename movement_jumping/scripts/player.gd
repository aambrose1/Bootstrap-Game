extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
const bullet = preload("res://scenes/projectile.tscn")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
		# Flip the sprites
	if sign(direction) == 1:
		animated_sprite.flip_h = false
		$Marker2D.position.x = 1
		
		
	if sign(direction) == -1:
		animated_sprite.flip_h = true
		if sign($Marker2D.position.x) == 1:
			$Marker2D.position.x  = -1
		
	# Shooting projectiles
	if Input.is_action_just_pressed("projectile_attack"):
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
