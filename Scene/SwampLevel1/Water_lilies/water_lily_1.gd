extends AnimatableBody2D

func _on_area_player_body_entered(body):
	if body.has_method("hurt"):
		$Area_player/Animation_player_on_water_lily.stop()
		$Area_player/Animation_player_on_water_lily.play("Animation_player_on_water_lily")
		$Water_drops/Animation_water_drops.play("water_drops")
		$Animation_water_lily.stop()
		$Timer.stop()
		$Timer.start()

func _on_timer_timeout():
	$Animation_water_lily.play("Water_lily")
