extends Node3D

var progress : int = 0

var positions : Array = []

@export var movementRate = 5

@export var enemy : EnemyAI.ENEMIES

var visualNodes : Array[Node3D]

var currentHallway : int = -1

@export var visuals : Node3D

@onready var timer : Timer = $Timer

func _ready() -> void:
	timer.start(movementRate)
	
	timer.timeout.connect(_move)

func _move():
	timer.start(movementRate)

func _jumpscare():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	print("KILLED BY " + str(enemy))
	
	get_tree().change_scene_to_file("res://Rooms/MainMenu.tscn")
