extends Area2D


func _on_body_entered(body):
	$AnimationShake.play("shake")
	$CPUParticles2D.emitting = true
