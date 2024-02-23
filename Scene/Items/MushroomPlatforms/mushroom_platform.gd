extends StaticBody2D

var ind = false

func _process(delta):
	drop_player()

func drop_player(): #чтобы при нажатии вниз, игрок падал с конкретных платформ
	if Input.is_action_pressed("player_down") and ind == true:
		get_tree().call_group("Player", "drop")

func _on_area_2d_body_entered(body):
	ind = true
func _on_area_2d_body_exited(body):
	ind = false
