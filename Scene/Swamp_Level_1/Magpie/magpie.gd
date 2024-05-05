extends Area2D

func _on_body_entered(body):
	if body.has_method("hurt"):
		get_tree().call_group("Player", "walk_away_from_danger_right")
