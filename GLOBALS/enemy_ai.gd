extends Node

enum ENEMIES{
	SLEEPY,
	PROTOTYPE,
	POMNI,
	PUGGO,
}

var enemyAiValues : Array = []

func _ready() -> void:
	enemyAiValues.resize(ENEMIES.size())
	
	enemyAiValues.fill(0)

func _get_all_positions(character : ENEMIES) -> Array:
	var returnArray : Array = []
	
	for pos in get_tree().get_nodes_in_group("CharacterPosition"):
		if pos.character == character:
			returnArray.push_back(pos)
	
	returnArray.sort_custom(func(a, b): return a.id < b.id)
	
	return returnArray
