extends Node2D

class_name Enemy

@export var pickup_spawn_prob: float = 0.1
@export var player_min_distance: float = 200
@export var player_max_distance: float = 300
@export var speed: float = 60
@export var max_health: float = 60

@onready var player = $"../Robot"
@onready var enemy_treads = $EnemyTreads
@onready var enemy_body = $EnemyRobot
@onready var pickup_scene = preload("res://Scenes/pickup.tscn")

var health = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health

var circleDir = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var moveDir = Vector2.ZERO
	var seperation: Vector2 = player.position - position
	var dist = seperation.length()
	if dist < player_min_distance:
		moveDir = -seperation.normalized()
		circleDir = randi_range(0,1)
	elif dist > player_max_distance:
		moveDir = seperation.normalized()
		circleDir = randi_range(0,1)
	else:
		moveDir = seperation.normalized().rotated(90)
		if circleDir:
			moveDir = -moveDir
	enemy_body.look_at(player.position)
	enemy_treads.look_at(position + moveDir)
	position += moveDir * delta * speed
	
func damage(damage: float):
	health -= damage
	if health <= 0:
		die()
	
func die():
	var pickup = pickup_scene.instantiate()

	queue_free()
