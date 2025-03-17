extends Area2D

@onready var anim = $NPC_SPRITE
var interact = false
var npc

func _ready() -> void:
	anim.play()
	
func _on_body_entered(body) -> void:
	if body is CharacterBody2D:  # Only detect CharacterBody2D
		print("you entered the body: ", body.name)
		interact = true
		
func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:  # Only detect CharacterBody2D
		print("you exited the body: ", body.name)
		interact = false
		$ChatBox.reset_dialogue()  # Call a function to reset the dialogue
		
func _input(event):
	if event.is_action_pressed("interact_O") && interact == true:
		if anim.animation == "Bro":
			npc = 1
		elif anim.animation == "BusWom":
			npc = 2
		elif anim.animation == "Caveman":
			npc = 3
		elif anim.animation == "ConWork":
			npc = 4
		elif anim.animation == "Cowpoke":
			npc = 5
		elif anim.animation == "Dude":
			npc = 6
		elif anim.animation == "Punk":
			npc = 7
		elif anim.animation == "WiseWizard":
			npc = 8
		$ChatBox.start(npc)
