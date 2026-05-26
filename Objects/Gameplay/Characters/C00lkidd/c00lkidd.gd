extends "res://Objects/Gameplay/Characters/animatronic.gd"

var player : Node3D

var animation = "attack"

func _ready() -> void:
	super()
	
	if EnemyAI.bounceKidd:
		animation = "attack_bounce"
	
	player = get_tree().get_first_node_in_group("Player")

func _move():
	var roll = randi_range(1,20)
	
	if roll <= EnemyAI.enemyAiValues[EnemyAI.ENEMIES.C00LKIDD]:
		if !EnemyAI.ultraMode:
			$AnimationPlayer.play(animation)
			
			super()
		else:
			$AnimationPlayer.play_section(animation,10.3)
			
			timer.start(15)
	else:
		super()

func _kill_check(reset : bool = true):
	if !player.maskUp:
		_jumpscare()
		
		$C00KiddKillhit.play()
	else:
		if reset:
			$AnimationPlayer.play("idle")
		
		$C00KiddKillFail.play()
