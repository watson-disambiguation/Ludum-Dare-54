extends Node2D

class_name Robot
@onready var robot_treads = $RobotTreads
@onready var robot_body = $RobotBody

@export var base_speed: float = 10
@export var base_max_health: float = 10
@export var base_max_energy: float = 10
@export var base_health_regen: float = 0
@export var base_energy_regen: float = 0
@export var base_damage: float = 10
@export var base_energy_consumption: float

var speed: float
var max_health: float
var health: float
var max_energy: float
var energy: float
var energy_consumption: float
var energy_regen: float
var health_regen: float
var damage: float

# Called when the node enters the scene tree for the first time.
func _ready():
	_reset()
	health = max_health
	energy = max_energy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = Vector2(Input.get_axis("ui_left","ui_right"),Input.get_axis("ui_up","ui_down")).normalized()
	var velocity = dir * speed * delta
	position += velocity
	robot_treads.look_at(position + velocity)
	robot_body.look_at(get_global_mouse_position())

func _reset():
	speed = base_speed
	max_health = base_max_health
	if(health > max_health):
		health = max_health
	max_energy = base_max_energy
	if(energy > max_energy):
		energy = max_energy
	health_regen = base_health_regen
	energy_regen = base_energy_regen
	energy_consumption = base_energy_consumption
	
func apply_parts(part_list: Array): 
	_reset()
	for part in part_list:
		if(part != null):
			part.do_effect(self)
		
	
