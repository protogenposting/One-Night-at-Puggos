extends Node3D

var currentCamera : Camera3D

var camID : int = 0

var cameras : Array[Node]

func _ready() -> void:
	cameras = $Cameras/Cams.get_children()
	
	currentCamera = cameras[camID]
	
	currentCamera.get_camera_projection()
	
	var all20 = true
	
	for i in EnemyAI.enemyAiValues:
		if i < 20:
			print(i)
			all20 = false
	
	if !all20:
		$NormalTheme.play()
	else:
		$All20Theme.play()

func _process(delta: float) -> void:
	currentCamera = cameras[camID]
	
	currentCamera.current = true
