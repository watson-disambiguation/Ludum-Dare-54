extends Sprite2D

class_name Pickup

@onready var mode_switcher = $"../.."


func _on_area_2d_area_entered(area):
	var robot = area.get_parent()
	if robot is Robot:
		mode_switcher.open_menu()
		queue_free()
