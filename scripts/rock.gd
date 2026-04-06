extends Node2D
class_name Rock

@onready var sprite: Sprite2D = $Sprite2D
@onready var area: CollisionPolygon2D = $Area2D/CollisionPolygon2D

signal mined(rock: Rock)

var is_mined := false
var pickaxe : Pickaxe = null
var grid_position: Vector2i

var hp := 4

var type := 0

func _ready() -> void:
	sprite.texture = sprite.texture.duplicate()

func mine():
	hp -= 1
	match hp:
		0:
			sprite.texture.region.position.x = 128
			area.disabled = true
			mined.emit(self)
		1:
			sprite.texture.region.position.x = 96
		2:
			sprite.texture.region.position.x = 64
		3:
			sprite.texture.region.position.x = 32
