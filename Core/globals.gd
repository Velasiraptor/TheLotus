extends Node

var count_max_hp_player := 6.0 # максимальное хп гг
var actual_hp_player = count_max_hp_player

enum State_screen { WINDOW_MODE, EXCLUSIVE_FULLSCREEN }
var state_mode_screen := State_screen.WINDOW_MODE

var new_load_scene = "res://Scene/Swamp_Level_1/swamp_level_1.tscn"
var actual_resume_load_scene = "res://Scene/Swamp_Level_1/swamp_level_1.tscn"

func _ready():
	Engine.max_fps = 75
	State_screen.WINDOW_MODE

func change_state(new_state): #функция изменения состояний
	state_mode_screen = new_state

func _input(event):
	if event.is_action_pressed("Screen_mode"):
		match state_mode_screen:
			State_screen.WINDOW_MODE:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
				change_state(State_screen.EXCLUSIVE_FULLSCREEN)
			State_screen.EXCLUSIVE_FULLSCREEN:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				change_state(State_screen.WINDOW_MODE)
