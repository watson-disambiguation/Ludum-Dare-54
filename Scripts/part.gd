extends Resource

class_name RobotPart 

@export var value: int

@export var shape: Shape2D

@export var layout: Array = [[0]]:
	set(new_value):
		layout = new_value
		layout2d = Array2D.fromArray(layout)
		print("1")
		print(layout2d)
	get:
		return layout

@export var sprite: CompressedTexture2D

var layout2d: Array2D

func _init():
	print("2")
	layout2d = Array2D.fromArray(layout)
	print(layout2d)


	
