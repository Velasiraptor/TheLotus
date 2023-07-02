extends Control

var scene = preload("res://Scene/Forest/ForestLVL.tscn")

func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_timer_lvl_1_timeout():
	get_tree().change_scene_to_packed(scene)
