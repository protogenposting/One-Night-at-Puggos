extends Node3D

var sensitivity = 0.2

@export var camsAreUp : bool = false

func _input(event: InputEvent) -> void:
	$Cams.push_input(event)
	
	if event is InputEventMouseMotion && !camsAreUp:
		var mouseEvent : InputEventMouseMotion = event
		
		rotate_y(deg_to_rad(-mouseEvent.relative.x * sensitivity))
		
		$Camera3D.rotate_x(deg_to_rad(-mouseEvent.relative.y * sensitivity))
		
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x,deg_to_rad(-70),deg_to_rad(70))


func _process(delta: float) -> void:
	if camsAreUp:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("Cameras"):
		camsAreUp = !camsAreUp
		
		$Cams/CurrentCamDisplay.camsAreUp = camsAreUp
		
		print(camsAreUp)
	
	if Input.is_action_just_pressed("Fullscreen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)
