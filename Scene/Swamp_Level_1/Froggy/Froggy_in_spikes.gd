extends Area2D

@onready var animation_emotion = %Animation_emotion
@onready var froggy_sprite = %Froggy_sprite

var damage_jump := -600

func _on_body_entered(body):
	animation_emotion.play("emotion")
func _on_body_exited(body):
	animation_emotion.play_backwards("emotion")


func _on_play_game_body_entered(body): # начало игры с языка
	get_tree().call_group("Level1", "start_puzzle_Froggy_game")

func Frocky_saddy():
	froggy_sprite.play("Saddy")
	await get_tree().create_timer(3.0).timeout
	froggy_sprite.play("Idle")

func _on_glasse_spikes_body_entered(body): # урон от шипов
	if body.has_method("hurt") and Globals.actual_hp_player != 0.0:
		body.hurt_without_direction()
		body.vel.y = damage_jump
		get_tree().call_group("Player", "leftPush")
