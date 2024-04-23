extends Sprite2D

var player_ind := 0
var anim_name = "fall_water_lily"
@onready var animation_tail_water_lily = %Animation_tail_water_lily

func _on_area_player_body_entered(body):
	if body.has_method("hurt"):
		player_ind = 1
		$Timer.stop()
		animation_tail_water_lily.play("fall_water_lily")


func _on_area_player_body_exited(body):
	if body.has_method("hurt"):
		player_ind = 0
		animation_tail_water_lily.pause()
		$Timer.start()

func _on_timer_timeout():
	if animation_tail_water_lily.is_playing():
		animation_tail_water_lily.play("fall_water_lily", 0, -1.0)
	else:
		animation_tail_water_lily.play_backwards("fall_water_lily")
