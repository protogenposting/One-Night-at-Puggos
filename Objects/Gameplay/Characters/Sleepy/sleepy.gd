extends "res://Objects/Gameplay/Characters/animatronic.gd"

func _process(delta: float) -> void:
	for i in visualNodes:
		i.position = positions[progress].position

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
		
		print("moved to " + str(progress))
	
	super()

func _slingshot_shot(slingshotTier : int, hallwayID : int):
	if hallwayID == currentHallway:
		_jumpscare()

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = area.hallwayID

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = -1
