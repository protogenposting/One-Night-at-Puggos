extends "res://Objects/Gameplay/Characters/visual_animatronic.gd"

var health = 4

func _ready() -> void:
	super()
	if EnemyAI.wackyCharacters:
		timer.wait_time += randf_range(0,10)
	
	get_tree().get_first_node_in_group("Player").shotSlingshot.connect(_slingshot_shot)

func _move():
	var roll = randi_range(1,20)
	
	if roll <= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.BROWNPHIL]:
		_flash()
		
		match(progress):
			0:
				$SpriteParent/BrownPhil/sfx.play()
				
				progress = randi_range(1,3)
				
				health = 4
				
				killTimer.start(killTime)
	
	super()

func _slingshot_shot(slingshotTier : int, hallwayID : int):
	print(currentHallway)
	
	if hallwayID == currentHallway && progress > 0:
		health -= slingshotTier
		
		$SpriteParent/BrownPhil/Warp.play("RESET")
		
		_change()
		
		if EnemyAI.ultraMode && randi_range(0,2) == 2 && health >= 0:
			get_tree().create_timer(0.2).timeout.connect(_change)
		
		if health <= 0:
			_reset()

func _change():
	progress = randi_range(1,3)
	
	$SpriteParent/BrownPhil/Warp.play("Warp")

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = area.hallwayID

func _reset():
	killTimer.stop()
	
	progress = 0
	
	currentHallway = -1
	
	timer.stop()
	
	timer.start(23)
