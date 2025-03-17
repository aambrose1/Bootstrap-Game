extends Area2D

@export var damage: int = 1
var parent_name = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	get_parent_name()
	get_parent().take_damage()
	
	
func get_parent_name():
	parent_name = get_parent()
	print(parent_name)
