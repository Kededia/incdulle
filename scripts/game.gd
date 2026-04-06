extends Node2D

@onready var ground: TileMapLayer = $Ground
@onready var rocks: TileMapLayer = $Rocks
@onready var score_label: Label = $UI/Score

var cell_positions : Array[Vector2i]
var rock_cell : Dictionary[Vector2i, Rock]

var score := {
	0: 0,
	1: 0,
}

func _ready() -> void:
	cell_positions = ground.get_used_cells()
	for i in 40:
		spawn_rock()

	score_label.text = "Rock: " + str(score[0]) + "\nDirt: " + str(score[1])

func on_rock_mined(rock: Rock) -> void:
	var tw = create_tween()
	tw.tween_property(rock, "global_position", Vector2.ZERO, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	await tw.finished
	match rock.type:
		1: score[0] += 1
		2: score[1] += 1
	score_label.text = "Rock: " + str(score[0]) + "\nDirt: " + str(score[1])
	rock_cell.erase(rock.grid_position)
	rocks.erase_cell(rock.grid_position)
	spawn_rock()

func spawn_rock() -> void:
	var free_cells = cell_positions.filter(func(v): return not rock_cell.has(v))
	var cell = free_cells.pick_random()
	var type = [1,2].pick_random()
	rocks.set_cell(cell, 0, Vector2i.ZERO, type)
	rocks.update_internals()
	rock_cell[cell] = rocks.get_child(rocks.get_child_count()-1)
	rock_cell[cell].mined.connect(on_rock_mined)
	rock_cell[cell].grid_position = cell
	rock_cell[cell].type = type
