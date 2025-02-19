extends Control


@onready var animation_menu = %AnimationMenu
@onready var new_game_button = %NewGameButton
@onready var resume_button = %ResumeButton
@onready var options_button = %OptionsButton
@onready var exit_button = %ExitButton

var last_mouse_motion = OS.get_static_memory_peak_usage() # время последнего движения мыши

func _ready():
	animation_menu.play("MainMenu")
	resume_button.grab_focus() 
	$HoverSound.playing = false
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

#ДЕЙСТВИЯ КНОПОК
func _on_NewGame_pressed():  #НОВАЯ ИГРА
	Globals.new_load_scene = "res://Scene/Swamp_Level_1/swamp_level_1.tscn"
	Globals.actual_resume_load_scene = "res://Scene/Swamp_Level_1/swamp_level_1.tscn"
	var loadingScreen = load("res://Scene/Loads/LoadScene.tscn")
	get_tree().change_scene_to_packed(loadingScreen)
func _on_Resume_pressed(): #ПРОДОЛЖИТЬ
	Globals.new_load_scene = Globals.actual_resume_load_scene
	var loadingScreen = load("res://Scene/Loads/LoadScene.tscn")
	get_tree().change_scene_to_packed(loadingScreen)
func _on_Options_pressed(): #НАСТРОЙКИ
	pass
func _on_Exit_pressed(): #ВЫХОД
	get_tree().quit() 


func _on_NewGame_mouse_entered(): #ФОКУС НА КНОПКАХ
	new_game_button.grab_focus()
func _on_Resume_mouse_entered():
	resume_button.grab_focus()
func _on_Options_mouse_entered():
	options_button.grab_focus()
func _on_Exit_mouse_entered():
	exit_button.grab_focus()


func _input(event):
	if event is InputEventMouseMotion:
		last_mouse_motion = OS.get_static_memory_peak_usage()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion:
		last_mouse_motion != OS.get_static_memory_peak_usage()
		$TimerCursor.start()

func _on_timer_cursor_timeout():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_new_game_focus_entered(): #ЗВУКИ КНОПОК
	$HoverSound.play()
func _on_resume_focus_entered():
	$HoverSound.play()
func _on_options_focus_entered():
	$HoverSound.play()
func _on_exit_focus_entered():
	$HoverSound.play()


func _on_exit_options_pressed(): #выход из настроек
	$Options_window.visible = false
func _on_exit_options_focus_entered():
	$HoverSound.play()
func _on_exit_options_mouse_entered():
	$Options_window/Node2D/HBoxContainer/ExitOptions.grab_focus()
func _on_good_options_pressed(): #Изменить настройки
	pass # Replace with function body.
func _on_good_options_focus_entered():
	$HoverSound.play()
func _on_good_options_mouse_entered():
	$Options_window/Node2D/HBoxContainer/GoodOptions.grab_focus()
