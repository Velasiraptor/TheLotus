extends AnimatableBody2D

func _on_area_player_body_entered(body):
	if body.has_method("hurt"):
		$Area_player/Animation_Player_on_barrel.play("Animation_Player_on_barrel")
		$Animation_oil.stop()
		await get_tree().create_timer(2.1).timeout
		$Animation_oil.play("water_animation")
