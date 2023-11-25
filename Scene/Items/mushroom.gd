extends Area2D

var ind = 0

func _physics_process(delta):
	if Input.is_action_just_pressed("player_take") and ind == 1 and $Press_E.visible == true: #Нажатие на Е
		$Press_E.visible = false
		$".".queue_free()

func _on_body_entered(body):
	$Press_E.visible = true
	ind = 1
func _on_body_exited(body):
	$Press_E.visible = false
	ind = 0
