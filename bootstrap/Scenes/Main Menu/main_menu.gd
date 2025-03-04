extends Control

@onready var anim = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Logo")
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Hub World/hub_city.tscn")
