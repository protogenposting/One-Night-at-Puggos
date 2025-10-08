extends "res://Objects/Gameplay/Characters/animatronic.gd"

func _ready():
	super()
	
	visualNodes.resize(2)
	
	visualNodes[0] = visuals
	
	visualNodes[1] = visuals.duplicate()
	
	get_tree().get_first_node_in_group("Cameras").add_child(visualNodes[1])
	
	positions = EnemyAI._get_all_positions(enemy)
	
	print(positions)

func _process(delta: float) -> void:
	for i in visualNodes:
		i.position = positions[progress].position
