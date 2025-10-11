extends "res://Objects/Gameplay/Characters/animatronic.gd"

var player : Node3D

func _ready() -> void:
	super()
	
	player = get_tree().get_first_node_in_group("Player")

func _move():
	var roll = randi_range(1,20)
	
	if roll <= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.C00LKIDD]:
		$AnimationPlayer.play("attack")
	
	super()

func _kill_check():
	if !player.maskUp:
		_jumpscare()
		
		$C00KiddKillhit.play()
	else:
		$AnimationPlayer.play("idle")
		
		$C00KiddKillFail.play()
