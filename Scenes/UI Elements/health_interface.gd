extends Control

@onready var clock_state: AnimatedSprite2D = $Panel/AnimatedSprite2D
var player_health


func update_health(health):
	clock_state.frame = health
