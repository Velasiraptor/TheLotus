extends Node2D

@onready var ray_1p_cave_animation = %Ray_1p_Cave_animation

#ПЕЩЕРА 1р
func God_ray_Cave1_visible():#отключение и включение видимости луча
	ray_1p_cave_animation.play("ray")
func God_ray_Cave1_not_visible():
	if ray_1p_cave_animation.is_playing():
		ray_1p_cave_animation.play("ray", 0, -1.0)
	else:
		ray_1p_cave_animation.play_backwards("ray")


#ПЕЩЕРА 7_8р
func _on_camera_left_entered_body_entered(body): #вход в пещеру 7p-8p
	if body.has_method("hurt"):
		get_tree().call_group("Player", "change_camera_7p_8p_cave")
		$"7_8p_Cave7-8/Camera_Left_Exit".monitoring = false
		await get_tree().create_timer(0.3).timeout
		body.global_position = $"7_8p_Cave7-8/Camera_Left_Entered/MarkerLeft_Entered".global_position
		get_tree().call_group("Player", "not_fall_damage_state")
		get_tree().call_group("Player", "change_camera_7p_8p_in_cave")
		$"7_8p_Cave7-8/Camera_Left_Entered".monitoring = false
		await get_tree().create_timer(0.3).timeout
		$"7_8p_Cave7-8/Camera_Left_Exit".monitoring = true
func _on_camera_right_entered_body_entered(body):
	if body.has_method("hurt"):
		get_tree().call_group("Player", "change_camera_7p_8p_cave")
		$"7_8p_Cave7-8/Camera_Right_Exit".monitoring = false
		await get_tree().create_timer(0.3).timeout
		body.global_position = $"7_8p_Cave7-8/Camera_Right_Entered/MarkerRight_Entered".global_position
		get_tree().call_group("Player", "not_fall_damage_state")
		get_tree().call_group("Player", "change_camera_7p_8p_in_cave")
		$"7_8p_Cave7-8/Camera_Right_Entered".monitoring = false
		await get_tree().create_timer(0.3).timeout
		$"7_8p_Cave7-8/Camera_Right_Exit".monitoring = true

func _on_camera_left_exit_body_entered(body): #выход в пещеру 7p-8p
	if body.has_method("hurt"):
		body.global_position = $"7_8p_Cave7-8/Camera_Left_Exit/MarkerLeft_Exit".global_position
		get_tree().call_group("Player", "camera_default_after_cave_7_8p")
		get_tree().call_group("Player", "remove_camera_7p_8p_in_cave")
		await get_tree().create_timer(1.0).timeout
		$"7_8p_Cave7-8/Camera_Left_Entered".monitoring = true
func _on_camera_right_exit_body_entered(body):
	if body.has_method("hurt"):
		body.global_position = $"7_8p_Cave7-8/Camera_Right_Exit/MarkerRight_Exit".global_position
		get_tree().call_group("Player", "camera_default_after_cave_7_8p")
		get_tree().call_group("Player", "remove_camera_7p_8p_in_cave")
		await get_tree().create_timer(1.0).timeout
		$"7_8p_Cave7-8/Camera_Right_Entered".monitoring = true

func _on_area_jump_player_body_entered(body): #прыжок из пещеры 7р_8р
	if body.has_method("hurt"):
		body.vel.y = -2400
		get_tree().call_group("Player", "not_fall_damage_state")
