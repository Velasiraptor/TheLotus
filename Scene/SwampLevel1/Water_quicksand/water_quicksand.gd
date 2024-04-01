extends AnimatableBody2D

var ind_death = 1
@onready var animation_water_move = %Animation_water_move

var anim_name := "animation_quicksand"

func _on_area_player_body_entered(body):
	if body.has_method("hurt"):
		ind_death = 0
		animation_water_move.play("animation_quicksand")
		get_tree().call_group("Player", "Player_on_water_quicksand")

func _on_area_player_body_exited(body):
	if body.has_method("hurt"):
		ind_death = 1
		animation_water_move.play("animation_quicksand", 0.0, -1.0)
		get_tree().call_group("Player", "Player_not_on_water_quicksand")
		
func _on_animation_water_move_animation_finished(anim_name):
	if ind_death == 0:
		get_tree().call_group("Player", "fullHurt")
