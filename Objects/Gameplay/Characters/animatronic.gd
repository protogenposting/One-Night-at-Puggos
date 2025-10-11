extends Node3D

var progress : int = 0

var positions : Array = []

@export var jumpscare : AnimationPlayer

@export var movementRate = 5

@export var killTime = 10

@export var enemy : EnemyAI.ENEMIES

var visualNodes : Array[Node3D]

var currentHallway : int = -1

@export var visuals : Node3D

@onready var timer : Timer = $Timer

var killTimer : Timer

func _ready() -> void:
	killTimer = Timer.new()
	
	add_child(killTimer)
	
	killTimer.timeout.connect(_jumpscare)
	
	if jumpscare != null:
		for i in jumpscare.get_children():
			if i.get("visible") != null:
				i.visible = false
		
		jumpscare.reparent.call_deferred(get_tree().get_first_node_in_group("Gameplay"))
	
	timer.start(movementRate)
	
	timer.timeout.connect(_move)

func _move():
	timer.start(movementRate)

func _start_kill():
	if killTimer.is_stopped():
		killTimer.start(killTime / (EnemyAI.enemyAiValues[enemy] / 10)

func _jumpscare():
	if EnemyAI.playerKilled:
		return
	
	timer.stop()
	
	for i in jumpscare.get_children():
		if i.get("visible") != null:
			i.visible = true
	
	print("KILLED BY " + str(enemy))
	
	jumpscare.play("default")
	
	jumpscare.animation_finished.connect(_return)
	
	EnemyAI.playerKilled = true

func _return(animation):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	get_tree().change_scene_to_file("res://Rooms/MainMenu.tscn")

func _flash():
	var display = get_tree().get_first_node_in_group("CamDisplay")
	
	display.animator.play("move")
