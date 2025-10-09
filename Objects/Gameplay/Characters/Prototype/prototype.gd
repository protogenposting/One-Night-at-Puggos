extends "res://Objects/Gameplay/Characters/animatronic.gd"

func _ready() -> void:
	super()

func _move():
	var roll = randi_range(1,20)
	
	if roll <= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.PROTOTYPE]:
		print("progress: " + str(progress))
		
		if progress == 1:
			print("PROTOTYPE KILL")
			
			_jumpscare()
		else:
			$Arrive.play()
			
			print("spawned")
			
			progress = 1
			
			var display = get_tree().get_first_node_in_group("CamDisplay")
			
			var gameplay = get_tree().get_first_node_in_group("Gameplay")
			
			var newPanel : Panel = $Panel.duplicate()
			
			newPanel.camID = randi_range(0,6)
			
			display.add_child(newPanel)
			
			newPanel.position = Vector2(randf_range(-70,70),randf_range(-70,70))
			
			newPanel.z_index = 998
			
			var newIndicator : Sprite2D = $Indicator.duplicate()
			
			newIndicator.isInPlayer = false
			
			gameplay.add_child(newIndicator)
			
			newIndicator.z_index = 998
			
			newPanel.get_node("Button").pressed.connect(_reset.bind(newPanel,newIndicator))
	
	super()

func _reset(button,indicator):
	button.queue_free()
	
	indicator.queue_free()
	
	progress = 0
	
	timer.stop()
	
	timer.start(movementRate * 2)
