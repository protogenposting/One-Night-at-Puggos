extends Sprite3D

var progress : int = 0

var positions : Array = []

@export var movementRate = 5

func _ready() -> void:
	positions = EnemyAI._get_all_positions(EnemyAI.ENEMIES.SLEEPY)
	
	print(positions)
	
	get_tree().create_timer(movementRate).timeout.connect(_move)

func _process(delta: float) -> void:
	position = positions[progress].position

func _move():
	var roll = randi_range(1,20)
	
	print("rolled " + str(roll))
	
	if roll <= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.SLEEPY]:
		match(progress):
			0:
				progress = [1,2].pick_random()
			1:
				progress = 5
			2:
				progress = [1,3,4].pick_random()
			3:
				progress = 6
		
		print("moved to " + str(progress))
	
	get_tree().create_timer(movementRate).timeout.connect(_move)
