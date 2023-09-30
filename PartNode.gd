extends Node2D



class_name PartNode
@export var part: RobotPart
@export var placed = false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d = $Area2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var input_manager = $"../InputManager"


# Called when the node enters the scene tree for the first time.
func _ready():
	var i = part.sprite.get_image()
	sprite_2d.texture = ImageTexture.create_from_image(i)
	collision_shape_2d.shape = part.shape
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_mouse_entered():
	input_manager.hover_part = self


func _on_area_2d_mouse_exited():
	if input_manager.hover_part == self:
		input_manager.hover_part = null
