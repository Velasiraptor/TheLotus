extends Node2D

@onready var _1p_god_ray = %"1p_GodRay"

func God_ray_Cave1_visible():#отключение и включение видимости луча
	$"Platforms_top/1p_GodRay/Ray_1p_Cave_animation".play("ray")
func God_ray_Cave1_not_visible():
	if $"Platforms_top/1p_GodRay/Ray_1p_Cave_animation".is_playing():
		$"Platforms_top/1p_GodRay/Ray_1p_Cave_animation".play("ray", 0, -1.0)
	else:
		$"Platforms_top/1p_GodRay/Ray_1p_Cave_animation".play_backwards("ray")
