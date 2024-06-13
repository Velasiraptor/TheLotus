extends Sprite2D

@onready var animation_water_lily = %Animation_water_lily
@onready var animation_player_on_water_lily = %Animation_player_on_water_lily
@onready var animation_water_drops = %Animation_water_drops
@onready var animation_wave = %Animation_wave


func _on_area_player_body_entered(body):
	if body.has_method("hurt"):
		animation_player_on_water_lily.stop()
		animation_player_on_water_lily.play("Animation_player_on_water_lily")
		animation_water_drops.play("water_drops")
		animation_water_lily.stop()
		animation_wave.play("Wave")
		get_tree().call_group("Level1", "spawner_catfish")
		$Timer.stop()
		$Timer.start()

func _on_timer_timeout():
	animation_water_lily.play("Water_lily")

