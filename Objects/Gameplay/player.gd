extends Node3D

var sensitivity = 0.2

@export var camsAreUp : bool = false

@export var slingshot : AnimatedSprite2D

var slingshotCharge = 0

var canShoot : bool = true

signal shotSlingshot(slingshotTier : int, hallwayID : int)

func _input(event: InputEvent) -> void:
	$Cams.push_input(event)
	
	if event is InputEventMouseMotion && !camsAreUp:
		var mouseEvent : InputEventMouseMotion = event
		
		rotate_y(deg_to_rad(-mouseEvent.relative.x * sensitivity))
		
		$Camera3D.rotate_x(deg_to_rad(-mouseEvent.relative.y * sensitivity))
		
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x,deg_to_rad(-70),deg_to_rad(70))

func _ready() -> void:
	slingshot.play("default")

func _process(delta: float) -> void:
	if camsAreUp:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("Cameras"):
		camsAreUp = !camsAreUp
		
		$Cams/CurrentCamDisplay.camsAreUp = camsAreUp
		
		print(camsAreUp)
	
	if Input.is_action_pressed("Click") && canShoot:
		slingshotCharge += delta
		
		if slingshotCharge >= 1:
			slingshot.play("charge3")
		elif slingshotCharge >= 0.5:
			slingshot.play("charge2")
		else:
			slingshot.play("charge1")
	elif slingshotCharge > 0 && Input.is_action_just_released("Click"):
		slingshot.play("shoot")
		
		shotSlingshot.emit()
		
		canShoot = false
		
		slingshotCharge = 0
		
		get_tree().create_timer(0.2).timeout.connect(_reset_slingshot)
	
	if Input.is_action_just_pressed("Fullscreen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)

func _reset_slingshot():
	canShoot = true
	
	slingshot.play("default")


func _on_area_3d_area_entered(area: Area3D) -> void:
	pass # Replace with function body.


func _on_area_3d_area_exited(area: Area3D) -> void:
	pass # Replace with function body.
