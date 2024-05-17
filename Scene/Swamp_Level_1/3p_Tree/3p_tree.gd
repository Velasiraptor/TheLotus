extends StaticBody2D

@onready var jump_player_off = %Jump_player_off

var ind_magpie = 0

func _on_camera_player_body_entered(body): #вход на дерево
	if body.has_method("hurt"):
		get_tree().call_group("Player", "change_camera_3p_tree")

func _on_camera_player_body_exited(body): # выход с дерева
	if body.has_method("hurt"):
		get_tree().call_group("Player", "camera_default")


func Jump_player_activated():
	jump_player_off.monitoring = true

func _on_jump_player_off_body_entered(body): #дизактивация прыжка
	if ind_magpie == 0:
		get_tree().call_group("Level1", "magpie_move_on_tree")
		ind_magpie = 1
	if body.has_method("hurt"):
		get_tree().call_group("Player", "jump_off")
func _on_jump_player_off_body_exited(body): #активация обратно
	if body.has_method("hurt"):
		get_tree().call_group("Player", "jump_on")
