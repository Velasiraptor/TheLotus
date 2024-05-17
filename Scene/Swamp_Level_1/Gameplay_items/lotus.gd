extends StaticBody2D


func _on_player_emotion_body_entered(body):
	get_tree().call_group("Player", "emotion_lotus_no_force")
