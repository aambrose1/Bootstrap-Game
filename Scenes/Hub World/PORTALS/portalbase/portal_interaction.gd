extends Area2D

@onready var anim = $portal_anim
@onready var portalName = $portalName
var interact = false
var items = false # Determines if final portal appears or not

func _ready() -> void:
	anim.play()
	portalName.visible = false
	final()

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:  # Only detect CharacterBody2D
		print("you entered the body: ", body.name)
		interact = true
		portalName.visible = true
		_message()

func _on_body_exited(body) -> void:
	if body is CharacterBody2D:  # Only detect CharacterBody2D
		print("you exited the body: ", body.name)
		interact = false
		portalName.visible = false
		
func _message():
	if interact == true:
		if anim.animation == "blue": # Pirate
			portalName.text = ("Interact to enter the portal\nTravel back to Pirated Seas")
		elif anim.animation == "final": # Explanatory
			portalName.text = ("Interact to enter the portal\nTravel to your fate")
		elif anim.animation == "green": # Medievil
			portalName.text = ("Interact to enter the portal\nTravel back to Castles and Kings")
		elif anim.animation == "orange": # Western
			portalName.text = ("Interact to enter the portal\nTravel back to the Old West")
		elif anim.animation == "purple": # Prohibition
			portalName.text = ("Interact to enter the portal\nTravel back to the Roaring 20s")
		elif anim.animation == "white": # Futuristic
			portalName.text = ("Interact to enter the portal\nFast forward into the Future")
		elif anim.animation == "yellow": # Caveman
			portalName.text = ("Interact to enter the portal\nTravel back to Caves and Cavemen")

		
func _input(event):
	if event.is_action_pressed("interact_O") && interact == true:
		if anim.animation == "blue":
			get_tree().change_scene_to_file("res://Scenes/Levels/pirate_level/pirate_level.tscn")
		elif anim.animation == "final":
			get_tree().change_scene_to_file("res://Scenes/Levels/boss_level2/boss_level2.tscn")
		elif anim.animation == "green":
			get_tree().change_scene_to_file("res://Scenes/Levels/medieval_level/medieval_level.tscn")
		elif anim.animation == "orange":
			get_tree().change_scene_to_file("res://Scenes/Levels/western_level/western_level.tscn")
		elif anim.animation == "purple":
			get_tree().change_scene_to_file("res://Scenes/Levels/mobster_level/mobster_level.tscn")
		elif anim.animation == "white":
			get_tree().change_scene_to_file("res://Scenes/Levels/boss_level1/boss_level1.tscn")
		elif anim.animation == "yellow":
			get_tree().change_scene_to_file("res://Scenes/Levels/prehistoric_level/prehistoric_level.tscn")
			
func final():
	if anim.animation == "final" && items == true: # Add an && statement here to check if all items have been aquired
		anim.visible = true
		$CollisionShape2D.disabled = false
		$StaticBody2D/CollisionShape2D.disabled = false
	elif anim.animation == "final": 
		anim.visible = false
		$CollisionShape2D.disabled = true
		$StaticBody2D/CollisionShape2D.disabled = true
