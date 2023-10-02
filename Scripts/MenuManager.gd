extends Node2D

class_name MenuManager

var is_current: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_current(value: bool):
	visible = value
	is_current = value
