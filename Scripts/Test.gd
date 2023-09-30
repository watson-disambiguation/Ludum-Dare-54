extends Node

var width = 3
var height = 3
var value = 2
var array2d: Array2D
# Called when the node enters the scene tree for the first time.
func _ready():
	array2d = Array2D.new(width,height)
	array2d.fill(0)
	array2d.setItem(value,0,0)
	for i in array2d:
		print_debug(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
