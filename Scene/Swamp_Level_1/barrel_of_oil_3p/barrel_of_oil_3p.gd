extends Node2D

@onready var animation_oil = %Animation_oil
@onready var animation_player_on_barrel = %Animation_Player_on_barrel
@onready var animation_water_drops = %Animation_water_drops


func _on_area_player_body_entered(body):
	if body.has_method("hurt"):
		animation_player_on_barrel.stop()
		animation_player_on_barrel.play("Animation_Player_on_barrel")
		animation_water_drops.play("water_drops")
		animation_oil.stop()
		$Timer.stop()
		$Timer.start()

func _on_timer_timeout():
	animation_oil.play("water_animation")
