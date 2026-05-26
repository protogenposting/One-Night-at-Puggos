extends Node

enum ENEMIES{
	SLEEPY,
	PROTOTYPE,
	POMNI,
	PUGGO,
	PURSUER,
	MABEL,
	C00LKIDD,
	BROWNPHIL
}

var playerKilled : bool = false

var enemyAiValues : Array = []

var nightScaling : bool = false

var ultraMode : bool = false

var hellMode : bool = false

var time : float = 0

var isInMenu : bool = true

## makes pomni kill
var killerPomni : bool = false

## adds 2 more prototypes with a random offset
var tripleTrouble : bool = false

## flashlight drains 5x faster
var fasterDrain : bool = false

## puggo has a 0 second kill time
var grinchVideo : bool = false

## pursuer and phil both have a 0-10 second offset
var wackyCharacters : bool = false

## pursuer can move like phil
var pursuing : bool = false

## c00lkidd bounces
var bounceKidd : bool = false

func _ready() -> void:
	enemyAiValues.resize(ENEMIES.size())
	
	enemyAiValues.fill(0)

func _process(delta: float) -> void:
	if !isInMenu:
		time += delta
	else:
		time = 0
	
	if nightScaling:
		killerPomni = false
		tripleTrouble = false
		fasterDrain = false
		grinchVideo = false
		wackyCharacters = false
		pursuing = false
		bounceKidd = false
		
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
	
	if time >= 60 * 6 || hellMode && time >= 60:
		enemyAiValues.fill(0)
		
		get_tree().change_scene_to_file("res://Rooms/Win.tscn")
	
	if Input.is_action_just_pressed("Fullscreen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)

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
