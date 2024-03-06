extends AnimatableBody2D


func _on_area_player_body_entered(body):
	if body.has_method("hurt"):
		$Area_player/Animation_Player_on_barrel.stop()
		$Area_player/Animation_Player_on_barrel.play("Animation_Player_on_barrel")
		$Water_drops/Animation_water_drops.play("water_drops")
		$Animation_oil.stop()
		$Timer.stop()
		$Timer.start()

func _on_timer_timeout():
	$Animation_oil.play("water_animation")
