extends Control

@onready var logo = $logo
@onready var bg = $background
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Play.grab_focus()
	logo.play()
	bg.play()
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/tutorial/tutorial.tscn")
