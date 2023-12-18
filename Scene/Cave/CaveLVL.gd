extends Node2D

var last_mouse_motion = OS.get_static_memory_peak_usage() # время последнего движения мыши

func _ready():
	Globals.actual_resume_load_scene = "res://Scene/Cave/CaveLVL.tscn" #делаем актуальной сценой для кнопки "продолжить" в главном меню
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event is InputEventMouseMotion and $GameOver/GameOver.visible == true:
		last_mouse_motion = OS.get_static_memory_peak_usage()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion:
		last_mouse_motion != OS.get_static_memory_peak_usage()
		$TimerCursor.start()
	if event.is_action_pressed("ui_cancel") and $GameOver/GameOver.visible == false and $Inventory/inventory.visible == false:
		get_tree().call_group("Menu", "pause")
	if event.is_action_pressed("open_inventory") and $GameOver/GameOver.visible == false and $Escape/ESCAPE.visible == false:
		get_tree().call_group("inventory", "wind2")
		if $Inventory/inventory.visible == false:
			$Inventory/inventory.visible = true
		elif $Inventory/inventory.visible == true:
			$Inventory/inventory.visible = false
	if $GameOver/GameOver.visible == true:
		$Escape/ESCAPE.visible = false
		$Inventory/inventory.visible = false

func _on_timer_cursor_timeout():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_timer_music_timeout(): #МУЗЫКА ЛОКАЦИИ
	$BackgroundSound.play()

