extends Resource

class_name RobotPart 


@export var name: String
@export var description: String
@export var sprite: CompressedTexture2D
@export var layout: Array = [[0]]:
	set(new_value):
		layout = new_value
		layout2d = Array2D.fromArray(layout)
	get:
		return layout
@export var shape: Shape2D
@export var effect: Resource


var layout2d: Array2D

func _init():
	layout2d = Array2D.fromArray(layout)
	
func do_effect(robot: Robot):
	if effect != null and effect.has_method("do_effect"):
		effect.do_effect(robot)


	
