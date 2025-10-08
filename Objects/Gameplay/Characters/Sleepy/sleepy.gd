extends "res://Objects/Gameplay/Characters/visual_animatronic.gd"

func _ready() -> void:
	super()
	
	get_tree().get_first_node_in_group("Player").shotSlingshot.connect(_slingshot_shot)
	
	get_tree().get_first_node_in_group("Player").flash.connect(_reset)

func _move():
	var roll = randi_range(1,20)
	
	if roll <= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.SLEEPY]:
		match(progress):
			0:
				progress = [1,2].pick_random()
			1:
				progress = 5
			2:
				progress = [1,3,4].pick_random()
			3:
				progress = 6
			_:
				_jumpscare()
		
		print("moved to " + str(progress))
	
	super()

func _slingshot_shot(slingshotTier : int, hallwayID : int):
	print(hallwayID)
	
	if hallwayID == currentHallway:
		_jumpscare()

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = area.hallwayID

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = -1

func _reset():
	progress = 0
	
	timer.stop()
	
	timer.start(8)
