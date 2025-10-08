extends Node3D

var progress : int = 0

var positions : Array = []

@export var movementRate = 5

var visualNodes : Array[Node3D]

var currentHallway : int = -1

@export var visuals : Node3D

@onready var timer = $Timer

func _ready() -> void:
	visualNodes.resize(2)
	
	visualNodes[0] = visuals
	
	visualNodes[1] = visuals.duplicate()
	
	get_tree().get_first_node_in_group("Cameras").add_child(visualNodes[1])
	
	positions = EnemyAI._get_all_positions(EnemyAI.ENEMIES.SLEEPY)
	
	print(positions)
	
	timer.start(movementRate)
	
	timer.timeout.connect(_move)

func _move():
	timer.start(movementRate)

func _jumpscare():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	get_tree().change_scene_to_file("res://Rooms/MainMenu.tscn")
