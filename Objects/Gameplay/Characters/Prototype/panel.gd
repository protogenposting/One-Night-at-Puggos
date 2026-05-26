extends Panel

var camID : int = -3

var gameplay : Node

var player : Node

var basePosition : Vector2

var time = 0

var timeLeft = 0

func _ready():
	gameplay = get_tree().get_first_node_in_group("Gameplay")
	
	player = get_tree().get_first_node_in_group("Player")
	
	basePosition = position

func _process(delta: float) -> void:
	var center = Vector2(0,0)
	
	timeLeft -= delta
	
	$timer.text = str(round(int(timeLeft)))
	
	$timer.global_position = center + Vector2(randf_range(-5,5),randf_range(-5,5))
	
	time += delta
	
	if gameplay.camID == camID && player.camsAreUp:
		visible = true
	else:
		visible = false
	
	if EnemyAI.ultraMode:
		global_position = center + Vector2(sin(time * 5) * 300,cos(time * 5) * 300)
