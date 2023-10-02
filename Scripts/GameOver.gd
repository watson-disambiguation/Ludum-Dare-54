extends Control

@onready var button = $Restart
@onready var enemies_killed: int = 0
@onready var enemies_defeated = $"Enemies Defeated"

func game_over():
	visible = true
	button.disabled = false
	enemies_defeated.text = "Enemies Defeated: %d" % enemies_killed

func restart():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
