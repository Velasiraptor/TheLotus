extends StaticBody2D


func _ready():
	$"1p_Cave_sprite".modulate = "ffffff00"
	$CaveHide.modulate = "ffffff"

func _on_camera_player_body_entered(body): #вход в пещеру
	if body.has_method("hurt"):
		get_tree().call_group("Player", "change_camera_1p_cave")
		$AnimationCave.play("animation_cave", 0, 1.0)
		get_tree().call_group("Level1", "God_ray_Cave1_visible")

func _on_camera_player_body_exited(body): # выход из пещеры
	if body.has_method("hurt"):
		get_tree().call_group("Player", "change_camera_default_1p_cave")
		get_tree().call_group("Level1", "God_ray_Cave1_not_visible")
		if $AnimationCave.is_playing():
			$AnimationCave.play("animation_cave", 0, -1.0)
		else:
			$AnimationCave.play_backwards("animation_cave")
