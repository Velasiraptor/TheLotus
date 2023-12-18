extends Control

func _process(delta):
	if $".".visible == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif $".".visible == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func grabButton():
	$CenterContainer/TextureRect/HBoxContainer/ButtonReset.grab_focus()
	$HoverSound.playing = false

func _on_ButtonReset_pressed(): #РАБОТА КНОПОК
	$".".visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
func _on_ButtonExit_pressed():
	$".".visible = false
	get_tree().paused = false
	Globals.new_load_scene = "res://Scene/MainMenu/MainMenu.tscn"
	var loadingScreen = load("res://Scene/Loads/LoadScene.tscn")
	get_tree().change_scene_to_packed(loadingScreen)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func pause():
	$Animation.play("PAUSE")
	$HoverSound.playing = false
	get_tree().paused = true
	grabButton()

func _on_ButtonReset_mouse_entered(): #ФОКУС КНОПОК
	$CenterContainer/TextureRect/HBoxContainer/ButtonReset.grab_focus()
func _on_ButtonExit_mouse_entered():
	$CenterContainer/TextureRect/HBoxContainer2/ButtonExit.grab_focus()


func _on_button_reset_focus_entered(): #ЗВУКИ КНОПОК
	$HoverSound.play()
func _on_button_exit_focus_entered():
	$HoverSound.play()
