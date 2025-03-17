extends Control

func _ready():
	hide()

func resume():
	get_tree().paused = false
	hide()
	
func pause():
	$PanelContainer/VBoxContainer/Resume.grab_focus()
	get_tree().paused = true
	show()

func test_pause():
	if Input.is_action_just_pressed("pause_L") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause_L") and get_tree().paused == true:
		resume()

func _on_resume_pressed():
	resume()
	
func _on_overworld_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Hub World/hub_city.tscn")

func _on_controls_pressed():
	pass

func _on_quit_pressed()  -> void :
	get_tree().quit()
	
func _process(float):
	test_pause()
