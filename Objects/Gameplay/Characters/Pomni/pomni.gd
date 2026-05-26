extends "res://Objects/Gameplay/Characters/animatronic.gd"

var button

var alive = true

func _ready() -> void:
	super()
	
	button = $Button
	
	$Button.reparent(get_tree().get_first_node_in_group("CamDisplay"))
	
	button.pressed.connect(_reset)
	
	progress = 300
	
	if EnemyAI.ultraMode:
		progress = 1

func _process(delta: float) -> void:
	if alive:
		button.value = progress

func _move():
	progress -= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.POMNI] * 2
	
	if progress <= 0 && alive:
		$Sprite3D.texture = load("res://Objects/Gameplay/Characters/Pomni/POMNIISFUCKINGDEAD.png")
		
		$Sprite3D.pixel_size = 0.02
		
		button.queue_free()
		
		alive = false
		
		if EnemyAI.killerPomni:
			_jumpscare()
	else:
		super()

func _reset():
	progress = 300
	
	button.songID += 1
	
	if button.songID > 2:
		button.songID = 0
	
	button._change_song()
