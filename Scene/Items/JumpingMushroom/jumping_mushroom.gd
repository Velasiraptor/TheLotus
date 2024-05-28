extends Area2D

@onready var animation_activation = %Animation_activation
@onready var sprite_jumping_mushroom = %SpriteJumpingMushroom
@onready var animation_emotion = %AnimationEmotion
@onready var take_emotion_area = %TakeEmotion_area

@export var jumping := -2000 ## Высота гипер прыжка

@export var active := 0 ## 0 - не активный с самого начала, 1 - активный

func _ready():
	if active == 0:
		active = 0
		sprite_jumping_mushroom.frame = 2
		$CollisionShape2D.position.y = 15
	else:
		active = 1
		sprite_jumping_mushroom.frame = 0
		$CollisionShape2D.position.y = -13


func _on_body_entered(body): # отскок от гриба
	if body.has_method("hurt") and sprite_jumping_mushroom.frame == 0 and active == 1:
		$RandomTimer_dust.stop()
		sprite_jumping_mushroom.play("jumping")
		body.vel.y = jumping
		$Animation_mushroom.play_backwards("animation_mushroom_jump")
		get_tree().call_group("Player", "not_fall_damage_state")
		await get_tree().create_timer(1.0).timeout
		take_emotion_area.monitoring == true
		active = 0
	if body.collision_layer == 16 and sprite_jumping_mushroom.frame == 2: # переключение на состояние активен, проверяется язык ли это
		animation_activation.play("activation")
		$Animation_mushroom.play("animation_mushroom_jump")
		active = 1
		sprite_jumping_mushroom.play_backwards("jumping")
		$RandomTimer_dust.start_random()
		take_emotion_area.monitoring == false
		animation_emotion.play_backwards("emotion")
	elif body.collision_layer == 16:
		animation_activation.stop()
		sprite_jumping_mushroom.play_backwards("jumping")
		animation_activation.play("activation")
	
func _on_random_timer_dust_timeout(): #рандомный выброс пыли при активном состоянии
	$Animation_Dust.play("animation_dust")
	$RandomTimer_dust.start_random()


func _on_take_emotion_body_entered(body):
	if active == 0:
		animation_emotion.play("emotion")
func _on_take_emotion_body_exited(body):
	if active == 0:
		animation_emotion.play_backwards("emotion")
