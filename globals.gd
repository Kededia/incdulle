extends Node


func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		get_tree().quit(0)

func _create_floating(at: Vector2, text: String) -> void:
	var label := Label.new()
	label.add_theme_font_size_override("font_size", 10)
	label.position = at
	label.text = text
	label.z_index = 100
	add_child(label)
	var tween := get_tree().create_tween()
	tween.tween_property(label, "position", Vector2(0, -100), 1).as_relative()
	tween.finished.connect(label.queue_free)
