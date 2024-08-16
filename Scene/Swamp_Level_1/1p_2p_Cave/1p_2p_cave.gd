extends StaticBody2D

var ind = 0



func _on_camera_player_body_entered(body): #вход в пещеру
	if body.has_method("hurt") and ind == 0:
		ind = 1
		get_tree().call_group("Player", "change_camera_1p_2p_cave")
	elif body.has_method("hurt") and ind == 1:
		ind = 0
		get_tree().call_group("Player", "camera_default")
