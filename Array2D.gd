extends Object

class_name Array2D

var _width: int
var _height: int
var _array = []

func _init(width: int, height: int):
	_width = width
	_height = height
	_array = []
	for i in range(0,width):
		var innerArray = []
		innerArray.resize(width)
		_array.append(innerArray)
		
func getWidth():
	return _width
	
func getHeight():
	return _height

func getItem(x: int, y: int):
	return _array[x][y]
	
func setItem(item, x: int, y: int):
	_array[x][y] = item
	
func fill(item):
	for x in range(0,_width):
		for y in range(0,_height):
			_array[x][y] = item

# iterator
var _iter_x: int = 0
var _iter_y: int = 0

func _can_continue():
	return _iter_x < _width and _iter_y < _height

func _iter_init(arg):
	_iter_x = 0
	_iter_y = 0
	return _can_continue()
	
func _iter_next(arg):
	_iter_x += 1
	if _iter_x >= _width:
		_iter_x = 0
		_iter_y += 1
	return _can_continue()

func _iter_get(arg):
	return _array[_iter_x][_iter_y]
