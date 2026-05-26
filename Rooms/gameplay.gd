extends Node3D

var currentCamera : Camera3D

var camID : int = 0

var cameras : Array[Node]

func _ready() -> void:
	if EnemyAI.tripleTrouble:
		for i in range(2):
			var newPrototype = preload("res://Objects/Gameplay/Characters/Prototype/Prototype.tscn").instantiate()
			
			newPrototype.movementRate += randf_range(0,10)
			
			newPrototype.get_node("Indicator").position += Vector2(0,-(i+1) * 64)
			
			$Characters.add_child(newPrototype)
	
	cameras = $Cameras/Cams.get_children()
	
	currentCamera = cameras[camID]
	
	currentCamera.get_camera_projection()
	
	var all20 = true
	
	if !EnemyAI.nightScaling:
		for i in EnemyAI.enemyAiValues:
			if i < 20:
				all20 = false
		
		if !all20:
			$NormalTheme.play()
		elif EnemyAI.hellMode:
			$HellTheme.play()
		else:
			$All20Theme.play()
	else:
		get_tree().create_timer(60).timeout.connect($NormalTheme.play)

func _process(delta: float) -> void:
	currentCamera = cameras[camID]
	
	currentCamera.current = true
