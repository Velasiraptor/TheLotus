extends Node2D

var last_mouse_motion = OS.get_static_memory_peak_usage() # время последнего движения мышив

func _ready():
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event is InputEventMouseMotion and $GameOver/GameOver.visible == true:
		last_mouse_motion = OS.get_static_memory_peak_usage()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		$TimerCursor.start()
	if event is InputEventMouseMotion:
		last_mouse_motion != OS.get_static_memory_peak_usage()
		$TimerCursor.start()

func _on_timer_cursor_timeout():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_timer_music_timeout(): #МУЗЫКА ЛОКАЦИИ
	$BackgroundSound.play()
