extends Node3D

var currentCamera : Camera3D

var camID : int = 0

var cameras : Array[Node]

func _ready() -> void:
	cameras = $Cameras.get_children()
	
	currentCamera = cameras[camID]
	
	currentCamera.get_camera_projection()

func _process(delta: float) -> void:
	currentCamera = cameras[camID]
	
	currentCamera.current = true
