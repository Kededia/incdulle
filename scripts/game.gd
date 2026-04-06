extends Node2D

@onready var ground: TileMapLayer = $Ground
@onready var rocks: TileMapLayer = $Rocks

func _ready() -> void:
	var cells: Array[Vector2i] = ground.get_used_cells()
	for cell in cells:
		if randf() > 0.5: continue
		rocks.set_cell(cell, 0, Vector2i.ZERO, [1,2].pick_random())
