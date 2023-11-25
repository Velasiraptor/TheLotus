extends Area2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	$WaterEntered.play()


func _on_Area2D_body_exited(body):
	$WaterExit.play()
