extends Sprite2D

var health = 5

func take_damage():
	health -= 1
	print(health)
	if health == 0:
		queue_free()
