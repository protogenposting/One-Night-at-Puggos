extends Button


func _process(delta: float) -> void:
	if visible && get_global_rect().has_point(get_global_mouse_position()) && Input.is_action_just_pressed("Click"):
		button_down.emit()
