extends Panel

var camID : int = -3

var gameplay : Node

var player : Node

func _ready():
	gameplay = get_tree().get_first_node_in_group("Gameplay")
	
	player = get_tree().get_first_node_in_group("Player")

func _process(delta: float) -> void:
	if gameplay.camID == camID && player.camsAreUp:
		visible = true
	else:
		visible = false
