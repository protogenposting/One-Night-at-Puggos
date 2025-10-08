extends "res://Objects/Gameplay/Characters/animatronic.gd"

func _ready() -> void:
	super()

func _move():
	var roll = randi_range(1,20)
	
	if roll <= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.PROTOTYPE]:
		if progress == 1:
			_jumpscare()
		else:
			$Arrive.play()
			
			print("spawned")
			
			progress = 1
			
			var display = get_tree().get_first_node_in_group("CamDisplay")
			
			var newPanel : Panel = $Panel.duplicate()
			
			newPanel.camID = randi_range(0,get_tree().get_first_node_in_group("Cameras").get_child_count() - 2)
			
			print(newPanel.camID)
			
			display.add_child(newPanel)
			
			newPanel.position = Vector2(randf_range(-70,70),randf_range(-70,70))
			
			newPanel.get_node("Button").pressed.connect(_reset.bind(newPanel))
			
			newPanel.z_index = 998
			
			print(newPanel.position)
	
	super()

func _reset(button):
	button.queue_free()
	
	progress = 0
	
	timer.stop()
	
	timer.start(movementRate * 2)
