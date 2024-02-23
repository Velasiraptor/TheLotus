extends Area2D

@onready var sprite_jumping_mushroom = %SpriteJumpingMushroom
@export var jumping := -2000

@export var active := 0 # 0 - не активный с самого начала, 1 - активный

func _ready():
	if active == 0:
		active = 0
		sprite_jumping_mushroom.frame = 2
		$CollisionShape2D.position.y = 15
	else:
		active = 1
		sprite_jumping_mushroom.frame = 0
		$CollisionShape2D.position.y = -13

func _physics_process(delta):
	if sprite_jumping_mushroom.frame == 2:
		$DustParticlesMushroom_L.emitting = true
		$DustParticlesMushroom_R.emitting = true

func _on_body_entered(body): # отскок от гриба
	$Timer_recovery.stop()
	if body.has_method("hurt") and sprite_jumping_mushroom.frame == 0 and active == 1:
		$RandomTimer_dust.stop()
		body.vel.y = jumping
		sprite_jumping_mushroom.play("jumping", 1.0)
		active = 0
		$Animation_mushroom.play_backwards("animation_mushroom_jump")
		get_tree().call_group("Player", "not_fall_damage_state")
func _on_body_exited(body):
	if body.has_method("hurt") and sprite_jumping_mushroom.frame == 2:
		$Timer_recovery.start()


func _on_timer_recovery_timeout(): #переключение на состояние активен
	$Animation_mushroom.play("animation_mushroom_jump")
	active = 1
	sprite_jumping_mushroom.play("jumping", -1.0)
	$RandomTimer_dust.start_random()
	
func _on_random_timer_dust_timeout(): #рандомный выброс пыли при активном состоянии
	$Animation_Dust.play("animation_dust")
	$RandomTimer_dust.start_random()
