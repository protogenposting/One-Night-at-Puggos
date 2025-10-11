extends Node

enum ENEMIES{
	SLEEPY,
	PROTOTYPE,
	POMNI,
	PUGGO,
	PURSUER,
	MABEL,
	C00LKIDD
}

var playerKilled : bool = false

var enemyAiValues : Array = []

var nightScaling : bool = false

var time : float = 0

func _ready() -> void:
	enemyAiValues.resize(ENEMIES.size())
	
	enemyAiValues.fill(0)

func _process(delta: float) -> void:
	time += delta
	
	if nightScaling:
		if time > 60 * 5:
			enemyAiValues[ENEMIES.PUGGO] = 20
			
			enemyAiValues[ENEMIES.SLEEPY] = 12
		elif time > 60 * 4:
			enemyAiValues[ENEMIES.PROTOTYPE] = 20
		elif time > 60 * 3:
			enemyAiValues[ENEMIES.C00LKIDD] = 10
		elif time > 60 * 2:
			enemyAiValues[ENEMIES.PUGGO] = 10
			
			enemyAiValues[ENEMIES.POMNI] = 10
			
			enemyAiValues[ENEMIES.PURSUER] = 15
		elif time > 60:
			enemyAiValues[ENEMIES.SLEEPY] = 6
			
			enemyAiValues[ENEMIES.PROTOTYPE] = 10
		else:
			enemyAiValues.fill(0)
			
			enemyAiValues[ENEMIES.PURSUER] = 20
			
			enemyAiValues[ENEMIES.MABEL] = 10

func _get_all_positions(character : ENEMIES) -> Array:
	var returnArray : Array = []
	
	for pos in get_tree().get_nodes_in_group("CharacterPosition"):
		if pos.character == character:
			returnArray.push_back(pos)
	
	returnArray.sort_custom(func(a, b): return a.id < b.id)
	
	return returnArray

func _start():
	time = 0
	
	get_tree().change_scene_to_file("res://Rooms/Gameplay.tscn")
