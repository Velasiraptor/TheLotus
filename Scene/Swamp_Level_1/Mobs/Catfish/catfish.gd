extends Area2D

@onready var animation_catfish = %Animation_Catfish


func _on_body_entered(body):
	body.hurt()

func catfish_right_idle():
	animation_catfish.play("spawn_side_R")

func catfish_left_idle():
	animation_catfish.play("spawn_side_L")


func _on_animation_catfish_animation_finished(anim_name):
	if anim_name == "spawn_side_R":
		animation_catfish.play("jump_R")
	elif anim_name == "spawn_side_L":
		animation_catfish.play("jump_L")
	elif anim_name == "jump_R":
		get_tree().call_group("Level1", "chek_jump_catfish_index")
	elif anim_name == "jump_L":
		get_tree().call_group("Level1", "chek_jump_catfish_index")
