extends Area2D
class_name InteractionArea

@onready var anim = $portal_anim
var interact

func _ready() -> void:
	anim.play()

func _on_body_entered(body) -> void:
	if body is CharacterBody2D:  # Only detect CharacterBody2D
		print("you entered the body: ", body.name)
		interact = true
		print("This Portal Is ", anim.animation)

func _on_body_exited(body) -> void:
	if body is CharacterBody2D:  # Only detect CharacterBody2D
		print("you exited the body: ", body.name)
		interact = false
		
func _input(event):
	if event.is_action_pressed("interact_O") && interact == true:
		if anim.animation == "blue":
			get_tree().change_scene_to_file("res://Scenes/Hub World/hub_city.tscn")
		elif anim.animation == "final":
			get_tree().change_scene_to_file("res://Scenes/Hub World/hub_city.tscn")
		elif anim.animation == "green":
			get_tree().change_scene_to_file("res://Scenes/Hub World/hub_city.tscn")
		elif anim.animation == "orange":
			get_tree().change_scene_to_file("res://Scenes/Hub World/hub_city.tscn")
		elif anim.animation == "purple":
			get_tree().change_scene_to_file("res://Scenes/Hub World/hub_city.tscn")
		elif anim.animation == "white":
			get_tree().change_scene_to_file("res://Scenes/Hub World/hub_city.tscn")
		elif anim.animation == "yellow":
			get_tree().change_scene_to_file("res://Scenes/Levels/Test Level/world.tscn")
