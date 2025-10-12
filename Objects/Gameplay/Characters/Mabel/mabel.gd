extends "res://Objects/Gameplay/Characters/visual_animatronic.gd"

var damageTaken = 0

var player : Node3D

func _ready() -> void:
	super()
	
	player = get_tree().get_first_node_in_group("Player")
	
	get_tree().create_timer(1).timeout.connect(_pushback)

func _pushback():
	if player.currentHallway == currentHallway && currentHallway != -1 && player.flashlightIsOn && !player.camsAreUp:
		progress -= 1
		
		if progress < 4:
			progress = 0
	
	get_tree().create_timer(1).timeout.connect(_pushback)

func _move():
	var roll = randi_range(1,20)
	
	if roll <= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.MABEL]:
		if progress == 9:
			_jumpscare()
		else:
			progress += 1
			
			if progress < 0:
				progress = 0
			
			print("moved to " + str(progress))
	
	super()

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = area.hallwayID

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = -1
