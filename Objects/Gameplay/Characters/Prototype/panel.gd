extends Panel

var camID : int = -3

var gameplay : Node

var player : Node

var basePosition : Vector2

var time = 0

func _ready():
	gameplay = get_tree().get_first_node_in_group("Gameplay")
	
	player = get_tree().get_first_node_in_group("Player")
	
	basePosition = position

func _process(delta: float) -> void:
	time += delta
	
	if gameplay.camID == camID && player.camsAreUp:
		visible = true
	else:
		visible = false
	
	if EnemyAI.ultraMode:
		position = basePosition + Vector2(sin(time * 2) * 500,cos(time) * 500)
