extends Control

@export var enemyName : String

@export var enemyID : EnemyAI.ENEMIES

@onready var slider = $CharacterAiSlider/HSlider

func _ready() -> void:
	$CharacterAiSlider/Label.text = enemyName

func _process(delta: float) -> void:
	var settings : LabelSettings = $CharacterAiSlider/Label.label_settings
	
	settings.shadow_offset = Vector2(randf_range(-3,3), randf_range(-3,3))
	
	$CharacterAiSlider/AILabel.text = "%.0f" % slider.value
	
	EnemyAI.enemyAiValues[enemyID] = slider.value
