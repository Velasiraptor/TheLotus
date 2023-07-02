extends CharacterBody2D

var ind = 0

func _physics_process(delta):
	if $Spr_Dwarf.flip_h == false:
		$AreaFlipH_true.monitoring == false
		$AreaFlipH_false.monitoring == true
	if $Spr_Dwarf.flip_h == true:
		$AreaFlipH_false.monitoring == false
		$AreaFlipH_true.monitoring == true
	
	if Input.is_action_just_pressed("player_take") and ind == 1 and $Press_E.visible == true: #Нажатие на Е
		$Press_E.visible = false
		$Spr_Dwarf.play("talk")
		$AudioFampinio.play()
		$TimerIdle.start()

func _on_area_flip_h_true_body_entered(body):
	$Spr_Dwarf.flip_h = false
	$Talks/CollisionShape2D.position.x = -265

func _on_area_flip_h_false_body_entered(body):
	$Spr_Dwarf.flip_h = true
	$Talks/CollisionShape2D.position.x = 265


func _on_talks_body_entered(body):
	ind = 1
	get_tree().call_group("Player", "indFalse")
	$Press_E.visible = true
func _on_talks_body_exited(body):
	ind = 0
	get_tree().call_group("Player", "indTrue")
	$Press_E.visible = false

func _on_timer_idle_timeout():
	$Spr_Dwarf.play("Idle")
