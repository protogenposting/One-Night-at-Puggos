extends "res://Objects/Gameplay/Characters/visual_animatronic.gd"

func _ready() -> void:
	super()
	
	get_tree().get_first_node_in_group("Player").shotSlingshot.connect(_slingshot_shot)

func _move():
	var roll = randi_range(1,20)
	
	if roll <= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.PURSUER]:
		_flash()
		
		match(progress):
			0:
				progress = 1
			1:
				progress = 2
			2:
				progress = [3,4].pick_random()
			3:
				progress = 6
				$SpriteParent/Pursuer/sfx.play()
			4:
				progress = 5
				$SpriteParent/Pursuer/sfx.play()
			_:
				_jumpscare()
	
	super()

func _slingshot_shot(slingshotTier : int, hallwayID : int):
	print(currentHallway)
	
	if hallwayID == currentHallway:
		if slingshotTier >= 2:
			_reset()

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = area.hallwayID

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = -1

func _reset():
	progress = 0
	
	timer.stop()
	
	timer.start(1)
