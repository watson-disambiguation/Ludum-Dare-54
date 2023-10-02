extends Node2D



class_name PartNode
@export var part: RobotPart
var placed = false

var value: int

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d = $Area2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var input_manager = $"../InputManager"


# Called when the node enters the scene tree for the first time.
func _ready():
	initialize()

func initialize():
	sprite_2d = $Sprite2D
	area_2d = $Area2D
	collision_shape_2d = $Area2D/CollisionShape2D
	if part != null: 
		sprite_2d.texture = ImageTexture.create_from_image(part.sprite.get_image())
		collision_shape_2d.shape = part.shape

func _on_area_2d_mouse_entered():
	input_manager.hover_part = self


func _on_area_2d_mouse_exited():
	if input_manager.hover_part == self:
		input_manager.hover_part = null
