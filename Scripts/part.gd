extends Resource

class_name RobotPart 

@export var shape: Shape2D

@export var layout: Array = [[0]]:
	set(new_value):
		layout = new_value
		layout2d = Array2D.fromArray(layout)
	get:
		return layout

@export var sprite: CompressedTexture2D

var layout2d: Array2D

func _init():
	layout2d = Array2D.fromArray(layout)


	
