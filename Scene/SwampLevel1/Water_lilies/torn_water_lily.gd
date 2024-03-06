extends AnimatableBody2D

var ind = 1


func _on_area_player_body_entered(body):
	if body.has_method("hurt") and ind == 1:
		$Area_player/Animation_player_on_torn_water_lily.play("Animation_player_on_torn_water_lily")
		$Water_drops/Animation_water_drops.play("Animation_water_drops")
		$Animation_torn_water_lily.stop()
		ind = 0

func _on_area_exit_player_body_exited(body):
	if body.has_method("hurt") and ind == 0:
		await get_tree().create_timer(5.0).timeout
		$Area_player/Animation_player_on_torn_water_lily.play_backwards("Animation_player_on_torn_water_lily")
		await get_tree().create_timer(1.7).timeout
		$Animation_torn_water_lily.play("Animation_torn_water_lily")
		ind = 1
