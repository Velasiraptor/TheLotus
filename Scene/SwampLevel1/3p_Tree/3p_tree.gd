extends StaticBody2D

func _on_camera_player_body_entered(body): #вход на дерево
	if body.has_method("hurt"):
		get_tree().call_group("Player", "change_camera_3p_tree")

func _on_camera_player_body_exited(body): # выход с дерева
	if body.has_method("hurt"):
		get_tree().call_group("Player", "camera_default")
