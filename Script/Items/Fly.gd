extends Node2D

var ind = 0

func _ready():
	$Fly/Fly/Flyanim.play("idleFly")

func _physics_process(delta):
	if Input.is_action_just_pressed("player_take") and ind == 1:
		$Fly/Fly.visible = false
		$Press_E.visible = false
		$Fly/CollisionShape2D.disabled = true
		get_tree().call_group("Player", "heal")
		get_tree().call_group("Player", "heal")
		$AudioFly.play()
		$Timer.start()

func _on_Fly_body_entered(body):
	if body.has_method("heal") and body.lives != 6:
		ind = 1
		$Press_E.visible = true
func _on_fly_body_exited(body):
	ind = 0
	$Press_E.visible = false
func _on_Timer_timeout():
	queue_free()



