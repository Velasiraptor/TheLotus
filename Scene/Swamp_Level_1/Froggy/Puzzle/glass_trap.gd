extends Sprite2D


func _on_fail_game_body_entered(body):
	get_tree().call_group("Froggy_puzzle", "start_position")
