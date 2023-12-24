extends Area2D

@export var jumping := -1200

func _physics_process(delta):
	if %SpriteJumpingMushroom.frame == 2:
		$DustParticlesMushroom_L.emitting = true
		$DustParticlesMushroom_R.emitting = true

func _on_body_entered(body):
	if body.has_method("hurt"):
		body.vel.y = jumping
		%SpriteJumpingMushroom.play("jumping")
