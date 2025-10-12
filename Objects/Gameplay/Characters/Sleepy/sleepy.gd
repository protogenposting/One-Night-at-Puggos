extends "res://Objects/Gameplay/Characters/visual_animatronic.gd"

var baseMovement : int

func _ready() -> void:
	super()
	
	get_tree().get_first_node_in_group("Player").flash.connect(_reset)
	
	baseMovement = movementRate
	
	visualNodes[0].modulate = Color(0,0,0,0)

func _move():
	if currentHallway != -1:
		movementRate = baseMovement
	else:
		movementRate = baseMovement * 3
	
	var roll = randi_range(1,19)
	
	if roll <= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.SLEEPY]:
		_flash()
		
		match(progress):
			0:
				progress = [1,2].pick_random()
			1:
				progress = 5
			2:
				progress = [1,3,4].pick_random()
			3:
				progress = 6
		
		if progress >= 4:
			_start_kill()
		
		print("moved to " + str(progress))
	
	print(movementRate)
	
	super()

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = area.hallwayID

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = -1

func _reset():
	killTimer.stop()
	
	progress = 0
	
	timer.stop()
	
	timer.start(8)
