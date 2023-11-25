extends Control

func end():
	$CenterContainer/TextureRect/HBoxContainer/ButtonReset.grab_focus()
	$HoverSound.playing = false

func _on_ButtonReset_pressed(): #РАБОТА КНОПОК
	get_tree().change_scene_to_file("res://Scene/Loads/LoadForest.tscn")
func _on_ButtonExit_pressed():
	get_tree().change_scene_to_file("res://Scene/Loads/LoadExit.tscn")

func _on_ButtonReset_mouse_entered(): #ФОКУС КНОПОК
	$CenterContainer/TextureRect/HBoxContainer/ButtonReset.grab_focus()
func _on_ButtonExit_mouse_entered():
	$CenterContainer/TextureRect/HBoxContainer2/ButtonExit.grab_focus()


func _on_button_reset_focus_entered(): #ЗВУКИ КНОПОК
	$HoverSound.play()
func _on_button_exit_focus_entered():
	$HoverSound.play()
