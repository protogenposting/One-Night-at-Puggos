extends Button

func _on_pressed() -> void:
	EnemyAI.enemyAiValues.fill(0)
	
	EnemyAI.enemyAiValues[EnemyAI.ENEMIES.PROTOTYPE] = 19
	
	EnemyAI.enemyAiValues[EnemyAI.ENEMIES.PUGGO] = 10
	
	EnemyAI.enemyAiValues[EnemyAI.ENEMIES.C00LKIDD] = 20
	
	get_tree().change_scene_to_file("res://Rooms/SpecialNights/CordialNight.tscn")
