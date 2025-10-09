extends Node3D

var sensitivity = 0.2

@export var camsAreUp : bool = false

@export var slingshot : AnimatedSprite2D

var slingshotCharge = 0

var canShoot : bool = true

var currentHallway : int = -1

var ammo = 5

var ammoBoxSelected : bool = false

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
	$Light.play("off")
	
	slingshot.play("default")
	
	flash.connect(_on_flash)

func _process(delta: float) -> void:
	if camsAreUp:
		flashlightIsOn = false
		
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
		$Crosshair.visible = false
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
		$Crosshair.visible = true
	
	if Input.is_action_just_pressed("Cameras"):
		camsAreUp = !camsAreUp
		
		if camsAreUp:
			$Cams/CurrentCamDisplay._open()
		
		$Cams/CurrentCamDisplay.camsAreUp = camsAreUp
		
		print(camsAreUp)
	
	if ammoBoxSelected && Input.is_action_pressed("Click"):
		ammo = 5
		
		canShoot = false
		
		get_tree().create_timer(0.2).timeout.connect(_reset_slingshot)
	
	var index = 0
	
	for i in $Slingshot/GridContainer.get_children():
		if index >= ammo:
			i.visible = false
		else:
			i.visible = true
		
		index += 1
	
	if !camsAreUp:
		if ammo > 0 && !ammoBoxSelected:
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
				
				ammo -= 1
				
				get_tree().create_timer(0.2).timeout.connect(_reset_slingshot)
				
				if currentHallway != -1:
					shotSlingshot.emit(chargeLevel, currentHallway)
		
		if Input.is_action_pressed("Flashlight"):
			flashlightHoldTime += delta
			
			if flashLightShouldShake:
				$Light.play("shake")
				
				$Light/AnimationPlayer.play("Shake")
				
				if flashlightHoldTime > 0.75:
					flashLightShouldShake = false
					
					flashlightHoldTime = -2
					
					$Light/AnimationPlayer.play("Idle")
					
					$Light.play("off")
					
					flashlightIsOn = false
			elif flashlightHoldTime > 0:
				var multiplier = min(flashlightHoldTime / 0.75, 1) * 10
				
				$Light.offset = Vector2(randf_range(-multiplier,multiplier),randf_range(-multiplier,multiplier))
				
				if flashlightHoldTime >= 0.75 && !$FlashlightCharged.playing:
					$FlashlightCharged.play()

		elif Input.is_action_just_released("Flashlight"):
			$Light/AnimationPlayer.play("Idle")
			
			$Light.offset = Vector2.ZERO
			
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
	
	$Light.play("shake")
	
	flashLightShouldShake = true

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = area.hallwayID
		
		print(currentHallway)
	
	if area.is_in_group("AmmoBox"):
		ammoBoxSelected = true

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("Hallway"):
		currentHallway = -1
	
	if area.is_in_group("AmmoBox"):
		ammoBoxSelected = false
