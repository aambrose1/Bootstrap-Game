extends Control

@export_file("*.json") var d_file

var dialogue = []
var current_dialogue_id = 0
var d_active = false
var end

func _ready():
	$NinePatchRect.visible = false
	
func start(npc):
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue(npc)
	current_dialogue_id = -1
	next_script()

func load_dialogue(npc):
	if npc == 1:
		var file = FileAccess.open("res://Scenes/Hub World/NPCs/dialog/jsons/bro.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		return content
	elif npc == 2:
		var file = FileAccess.open("res://Scenes/Hub World/NPCs/dialog/jsons/busWom.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		return content
	elif npc == 3:
		var file = FileAccess.open("res://Scenes/Hub World/NPCs/dialog/jsons/caveman.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		return content
	elif npc == 4:
		var file = FileAccess.open("res://Scenes/Hub World/NPCs/dialog/jsons/conWork.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		return content
	elif npc == 5:
		var file = FileAccess.open("res://Scenes/Hub World/NPCs/dialog/jsons/cowPoke.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		return content
	elif npc == 6:
		var file = FileAccess.open("res://Scenes/Hub World/NPCs/dialog/jsons/dude.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		return content
	elif npc == 7:
		var file = FileAccess.open("res://Scenes/Hub World/NPCs/dialog/jsons/punk.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		return content
	elif npc == 8:
		var file = FileAccess.open("res://Scenes/Hub World/NPCs/dialog/jsons/wiseWizard.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		return content
	
func _input(event):
	if !d_active:
		return
	if event.is_action_pressed('interact_O'):
		next_script()
	
func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		d_active = false
		$NinePatchRect.visible = false
		return
		
	$NinePatchRect/text.text = dialogue[current_dialogue_id]['text']

func reset_dialogue():
	d_active = false  # Stop the dialogue
	current_dialogue_id = -1 
	$NinePatchRect.visible = false  
	$NinePatchRect/text.text = ""  # Clear the text
