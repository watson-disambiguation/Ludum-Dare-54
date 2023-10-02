extends Node2D

class_name PartSpawner

var part_node_scene = preload("res://Scenes/part_node.tscn")
@export  var spawnable_parts: Array[Resource]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn():
	var new_part = spawnable_parts.pick_random()
	var part_node: PartNode = part_node_scene.instantiate()
	part_node.part = new_part
	get_parent().add_child(part_node)
	part_node.position = position
	part_node.initialize()
	
	
	
	
