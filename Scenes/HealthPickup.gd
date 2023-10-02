extends Sprite2D

var health: float = 10
@onready var mode_switcher = $"../.."

func _on_area_2d_area_entered(area):
	var robot = area.get_parent()
	if robot is Robot:
		robot.health += health
		queue_free()
