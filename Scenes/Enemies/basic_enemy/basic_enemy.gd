extends Area2D

@export var speed = 300
@export var health = 1
const damage = 1
var velocity = Vector2()
const direction: int = -1
@onready var player_screen_notifier = $PlayerOnScreen

func _physics_process(delta: float) -> void:
	# Once the player has been on screen at least once, we start tracking
	if not player_screen_notifier.is_on_screen():
		return
	
	velocity.x = speed * delta * direction
	translate(velocity)

func take_damage():
	health -= 1
	if health == 0:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage()
		queue_free()
