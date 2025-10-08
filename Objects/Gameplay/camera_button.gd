extends Button

@export var cameraID : String

@export var onIcon : Texture2D

@export var offIcon : Texture2D

func _ready() -> void:
	var viewport = get_tree().get_first_node_in_group("Cameras")
	
	var iterator = 0
	
	pressed.connect(_on_press)
	
	for camera in viewport.get_children():
		if camera.name == cameraID:
			pressed.connect(get_parent()._change_cam.bind(iterator))
			
			break
		
		iterator += 1

func _on_press():
	for i in get_tree().get_nodes_in_group("CameraButton"):
		i.icon = i.offIcon
	
	icon = onIcon
