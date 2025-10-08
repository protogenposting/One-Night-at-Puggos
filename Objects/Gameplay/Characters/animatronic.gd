extends Node3D

var progress : int = 0

var positions : Array = []

@export var movementRate = 5

var visualNodes : Array[Node3D]

var currentHallway : int = -1

@export var visuals : Node3D

func _ready() -> void:
	visualNodes.resize(2)
	
	visualNodes[0] = visuals
	
	visualNodes[1] = visuals.duplicate()
	
	get_tree().get_first_node_in_group("Cameras").add_child(visualNodes[1])
	
	positions = EnemyAI._get_all_positions(EnemyAI.ENEMIES.SLEEPY)
	
	print(positions)
	
	get_tree().create_timer(movementRate).timeout.connect(_move)

func _move():
	get_tree().create_timer(movementRate).timeout.connect(_move)

func _jumpscare():
	pass
