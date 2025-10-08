extends Node3D

var sensitivity = 0.2

@export var camsAreUp : bool = false

@export var slingshot : AnimatedSprite2D

var slingshotCharge = 0

var canShoot : bool = true

var currentHallway : int = -1

var battery = 100

var flashlightHoldTime : float = 0

var flashlightIsOn : bool = false

var flashLightShouldShake : bool = false

signal flash

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
	
	flash.connect(_on_flash)

func _process(delta: float) -> void:
	if camsAreUp:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("Cameras"):
		camsAreUp = !camsAreUp
		
		$Cams/CurrentCamDisplay.camsAreUp = camsAreUp
		
		print(camsAreUp)
	
	if !camsAreUp:
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
			
			var chargeLevel = 0
			
			if slingshotCharge >= 1:
				chargeLevel = 3
			elif slingshotCharge >= 0.5:
				chargeLevel = 2
			else:
				chargeLevel = 1
			
			canShoot = false
			
			slingshotCharge = 0
			
			get_tree().create_timer(0.2).timeout.connect(_reset_slingshot)
			
			if currentHallway != -1:
				shotSlingshot.emit(chargeLevel, currentHallway)
	
	if Input.is_action_pressed("Flashlight"):
		flashlightHoldTime += delta
		
		if flashLightShouldShake:
			$Light.play("shake")
			if flashlightHoldTime > 1:
				flashLightShouldShake = false
				
				flashlightHoldTime = -2
	elif Input.is_action_just_released("Flashlight"):
		if !flashLightShouldShake:
			print(flashlightHoldTime)
			
			if flashlightHoldTime > 0.75:
				flash.emit()
				
				flashlightIsOn = false
			else:
				flashlightIsOn = !flashlightIsOn
				
				if flashlightIsOn:
					$Light.play("on")
				else:
					$Light.play("off")
		
		flashlightHoldTime = 0
	
	if flashlightIsOn:
		$Camera3D/SpotLight3D.visible = true
	else:
		$Camera3D/SpotLight3D.visible = false
	
	if Input.is_action_just_pressed("Fullscreen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)

func _reset_slingshot():
	canShoot = true
	
	slingshot.play("default")

func _on_flash():
	$Flash/AnimationPlayer.play("flash")
	
	flashLightShouldShake = true

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = area.hallwayID
		
		print(currentHallway)

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = -1
