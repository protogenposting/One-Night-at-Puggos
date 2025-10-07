extends Node2D

var isOpen = false

@export var targetColor : Color

@onready var colorRect : TextureRect = $TextureRect

var camsAreUp : bool

var sensitivity : float

var gameplay : Node3D

var viewport : SubViewport

func _ready() -> void:
	gameplay = get_tree().get_first_node_in_group("Gameplay")
	
	viewport = gameplay.get_node("Cameras")
	
	$Sprite2D.texture.viewport_path = viewport.get_path()

func _process(delta: float) -> void:
	colorRect.texture.noise.seed += 1
	
	colorRect.modulate = targetColor

func _change_cam(id):
	gameplay.camID = id
