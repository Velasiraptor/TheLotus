extends Node2D

@onready var ray_1p_cave_animation = %Ray_1p_Cave_animation


func God_ray_Cave1_visible():#отключение и включение видимости луча
	ray_1p_cave_animation.play("ray")
func God_ray_Cave1_not_visible():
	if ray_1p_cave_animation.is_playing():
		ray_1p_cave_animation.play("ray", 0, -1.0)
	else:
		ray_1p_cave_animation.play_backwards("ray")

func _on_camera_left_exit_body_entered(body): #вход в пещеру 7p-8p
	if body.has_method("hurt"):
		get_tree().call_group("Player", "change_camera_7p_8p_cave")
		await get_tree().create_timer(0.3).timeout
		body.global_position = $"7_8p_Cave7-8/Camera_Left_Exit/MarkerLeft".global_position
		get_tree().call_group("Player", "change_camera_7p_8p_in_cave")

func _on_camera_right_exit_body_entered(body):
	if body.has_method("hurt"):
		get_tree().call_group("Player", "change_camera_7p_8p_cave")
		await get_tree().create_timer(0.3).timeout
		body.global_position = $"7_8p_Cave7-8/Camera_Right_Exit/MarkerRight".global_position
		get_tree().call_group("Player", "change_camera_7p_8p_in_cave")
