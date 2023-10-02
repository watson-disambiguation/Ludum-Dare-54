extends Control

class_name Status

@onready var energy_display = $ColorRect/Energy
@onready var health_display = $ColorRect/Health

func display_health(health: float, max_health: float):
	if health_display != null:
		health_display.text = "%.1f/%.1f" % [health,max_health] 
	
func display_energy(energy: float, max_energy: float):
	if health_display != null:
		energy_display.text = "%.1f/%.1f" % [energy,max_energy] 


