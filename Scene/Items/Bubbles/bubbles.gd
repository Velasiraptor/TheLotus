extends Node2D

var anim_name = "bubbles"

func _on_random_timer_timeout():
	$".".visible = true
	$AnimationPlayer.play("bubbles")

func _ready():
	$".".visible = false
	$RandomTimer.start()


func _on_animation_player_animation_finished(anim_name):
	$RandomTimer.start()
