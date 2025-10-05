extends Node

enum ENEMIES{
	SLEEPY,
	PEBBLE
}

var enemyAiValues : Array = []

func _ready() -> void:
	enemyAiValues.resize(ENEMIES.size())
	
	enemyAiValues.fill(0)
