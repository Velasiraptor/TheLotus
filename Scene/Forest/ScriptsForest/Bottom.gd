extends Area2D

func _ready():
	pass

func _on_Bottom_body_entered(body):
	$BottomAnimate.frame = 0
	$BottomAnimate.play("damping")


func _on_Bottom_body_exited(body):
	$BottomAnimate.frame = 0
	$BottomAnimate.play("damping2")
