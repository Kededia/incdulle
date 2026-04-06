extends Node2D

const PICKAXE = preload("uid://duogi22xtno17")

@onready var collision_shape: CircleShape2D = $Area2D/CollisionShape2D.shape

@export var radius : float = 32 :
	set(value):
		radius = value
		(func(): collision_shape.radius = radius).call_deferred()


func _ready() -> void:
	position = get_local_mouse_position()
	var area : Area2D = get_node("Area2D")
	area.area_entered.connect(func(area: Area2D): rock_entered(area.get_parent()))
	area.area_exited.connect(func(area: Area2D): rock_exited(area.get_parent()))

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		position = event.position

func _draw() -> void:
	draw_arc(Vector2.ZERO, radius, 0, 2*PI, 64, Color.WHITE, .5, true)


func rock_entered(rock: Rock):
	rock.is_mined = true
	var pickaxe : Pickaxe = PICKAXE.instantiate()
	get_parent().add_child(pickaxe)
	pickaxe.init(rock)

	pickaxe.hit.connect(on_rock_hit)

func rock_exited(rock: Rock):
	rock.is_mined = false
	rock.pickaxe.queue_free()

func on_rock_hit(rock):
	#Globals._create_floating(rock.global_position, "Hit!")
	rock.mine()
