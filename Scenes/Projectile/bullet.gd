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

# Projectiles get destroyed after 3 seconds
func _on_timer_timeout() -> void:
	queue_free()
	

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtboxes"):
		if area.get_parent().is_in_group("player"):
			area.get_parent().take_damage()
			queue_free()
