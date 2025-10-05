extends Node2D

func _ready() -> void:
	var viewport : SubViewport = get_tree().get_first_node_in_group("Gameplay").get_node("Cameras")
	
	$Sprite2D.texture.viewport_path = viewport.get_path()

func _process(delta: float) -> void:
	print(get_viewport().get_mouse_position())
