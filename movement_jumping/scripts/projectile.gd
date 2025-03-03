extends Area2D

@export var speed = 1000
@export var damage = 1
var velocity = Vector2()

var direction: int = 1

func set_direction(bullet_direction):
	direction = bullet_direction
	if bullet_direction == -1:
		$Sprite2D.flip_h = true
		
	else:
		$Sprite2D.flip_h = false

func _physics_process(delta: float) -> void:
	velocity.x = speed * delta * direction
	translate(velocity)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.get_damage(damage)
		queue_free()


# Projectiles get destroyed after 3 seconds
func _on_timer_timeout() -> void:
	queue_free()
	
