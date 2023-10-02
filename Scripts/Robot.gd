extends Node2D

class_name Robot
@onready var robot_treads = $RobotTreads
@onready var robot_body = $RobotBody
@onready var battle: BattleManager = $".."
@onready var bullet_scene = preload("res://Scenes/player_bullet.tscn")
@onready var status: Status = $"../Status"
@onready var game_over = $"../Game Over"

@export var base_speed: float = 10
@export var base_max_health: float = 10
@export var base_max_energy: float = 10
@export var base_health_regen: float = 0
@export var base_energy_regen: float = 0
@export var base_damage: float = 5
@export var base_energy_consumption: float = 5
@export var base_bullet_speed: float = 200


var speed: float
var max_health: float
var max_energy: float
var energy_consumption: float
var energy_regen: float
var health_regen: float
var damage: float
var bullet_speed: float

var health: float: 
	set(value):
		health = value
		if health > max_health:
			health = max_health
		status.display_health(health,max_health)
	get: 
		return health
var energy: float:
	set(value):
		energy = value
		if energy > max_energy:
			energy = max_energy
		status.display_energy(energy,max_energy)
	get: 
		return energy

var is_dead: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	is_dead = false
	_reset()
	health = max_health
	energy = max_energy

func _input(event):
	if (not battle.is_current) or (is_dead):
		return
	if event.is_action_pressed("main_click"):
		if energy > energy_consumption:
			shoot((event.position - position).normalized())
			energy -= energy_consumption
			if energy <= 0:
				energy = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (not battle.is_current) or (is_dead):
		return
	_move(delta)
	_regen(delta)
	
func _regen(delta):
	health += health_regen * delta
	if health > max_health:
		health = max_health
	energy += energy_regen * delta
	if energy > max_energy:
		energy = max_energy
func _move(delta):
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
	bullet_speed = base_bullet_speed
	damage = base_damage
	
func apply_parts(part_list: Array): 
	_reset()
	for part in part_list:
		if(part != null):
			part.do_effect(self)
			
func shoot(direction: Vector2):
	var bullet: PlayerBullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.velocity = bullet_speed * direction
	bullet.position = position
	bullet.damage = damage
	
func take_damage(damage_taken: float):
	health -= damage_taken
	if health <= 0:
		health = 0
		if not is_dead:
			die()

func die():
	is_dead = true
	game_over.game_over()
	
