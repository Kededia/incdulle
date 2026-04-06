extends Node2D
class_name Pickaxe

@onready var timer: Timer = $Timer

var speed = 0.4

signal hit(rock: Rock)

func init(rock: Rock) -> void:
	rock.pickaxe = self
	global_position = rock.global_position

	timer.wait_time = speed
	timer.start()
	timer.timeout.connect(func(): hit.emit(rock))

	var tw = create_tween().set_loops()
	tw.tween_property(self, "rotation", PI/2, speed-0.05)
	tw.tween_property(self, "rotation", 0, 0.05)
