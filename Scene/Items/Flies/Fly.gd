extends Node2D

var ind = 1

func _ready():
	$Fly/Fly/Flyanim.play("idleFly")

func _on_Fly_body_entered(body):
	if Globals.actual_hp_player > 0 and Globals.actual_hp_player != Globals.count_max_hp_player:
		if ind == 1:
			$AudioFlyLong.playing = false
			$Press_E.visible = false
			$AudioFly.play()
			ind = 0
			$Fly/Fly.visible = false
			$Fly/CollisionShape2D.disabled = true
			get_tree().call_group("Player", "heal")
			get_tree().call_group("Player", "heal")
			$Timer.start()


func _on_Timer_timeout():
	queue_free()

func _on_area_e_body_entered(body):
	$Press_E.visible = true
func _on_area_e_body_exited(body):
	$Press_E.visible = false
