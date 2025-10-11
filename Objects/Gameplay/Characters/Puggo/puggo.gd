extends "res://Objects/Gameplay/Characters/visual_animatronic.gd"

var damageTaken = 0

func _ready() -> void:
	super()
	
	get_tree().get_first_node_in_group("Player").shotSlingshot.connect(_slingshot_shot)

func _move():
	var roll = randi_range(1,20)
	
	if roll <= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.PUGGO]:
		_flash()
		
		$SpriteParent/Puggo/AudioStreamPlayer3D.play()
		
		match(progress):
			0:
				progress = 1
			1:
				progress = 2
			2:
				progress = 3
			3:
				progress = 4
			4:
				progress = 5
			5:
				_start_kill()
		
		print("moved to " + str(progress))
	
	super()

var nextDamageIncrement = 3

func _slingshot_shot(slingshotTier : int, hallwayID : int):
	if hallwayID == currentHallway:
		damageTaken += slingshotTier
		
		if damageTaken >= nextDamageIncrement:
			progress -= 1
			
			killTimer.stop()
			
			nextDamageIncrement += 3
		
		if damageTaken >= 30:
			_reset()
	
	print(damageTaken)

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = area.hallwayID

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = -1

func _reset():
	killTimer.stop()
	
	nextDamageIncrement = 3
	
	progress = 0
	
	damageTaken = 0
	
	timer.stop()
	
	timer.start(30)
