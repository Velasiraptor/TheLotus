extends Node2D

@onready var player = %Player


@onready var ray_1p_cave_animation = %Ray_1p_Cave_animation
@onready var magpie = %Magpie
@onready var magpie_marker_tree = %Magpie_Marker_tree

@onready var catfish_spawner = %Catfish_Spawner
@onready var catfish = %Catfish


var last_mouse_motion = OS.get_static_memory_peak_usage() # время последнего движения мышив
var log_in_hole_ind := true

var chek_jump_catfish = false

func _ready():
	Globals.actual_resume_load_scene = "res://Scene/SwampLevel1/swamp_level_1.tscn" #делаем актуальной сценой для кнопки "продолжить" в главном меню
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _input(event):
	if event is InputEventMouseMotion and $GameOver/GameOver.visible == true:
		last_mouse_motion = OS.get_static_memory_peak_usage()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#if event is InputEventMouseMotion: #когда не двигаем мышью, исчезает (не работает)
		#last_mouse_motion != OS.get_static_memory_peak_usage()
		#await get_tree().create_timer(2.0).timeout
		#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if event.is_action_pressed("ui_cancel") and $GameOver/GameOver.visible == false:
		get_tree().call_group("Menu", "pause")
	if $GameOver/GameOver.visible == true:
		$Escape/ESCAPE.visible = false

#func _on_timer_music_timeout(): #МУЗЫКА ЛОКАЦИИ
	#$BackgroundSound.play()

#ПЕЩЕРА 1р
func God_ray_Cave1_visible():#отключение и включение видимости луча
	ray_1p_cave_animation.play("ray")
func God_ray_Cave1_not_visible():
	if ray_1p_cave_animation.is_playing():
		ray_1p_cave_animation.play("ray", 0, -1.0)
	else:
		ray_1p_cave_animation.play_backwards("ray")

#ОТСКАКИВАНИЕ ОТ ЯМЫ 1p
func _on_log_in_hole_body_entered(body):
	if log_in_hole_ind == true:
		body.apply_central_impulse(Vector2(-750, -5500))
		log_in_hole_ind = false
	else:
		body.apply_central_impulse(Vector2(750, -5500))
		log_in_hole_ind = true

#ПЕЩЕРА 7_8р
func _on_camera_left_entered_body_entered(body): #вход в пещеру 7p-8p
	if body.has_method("hurt"):
		get_tree().call_group("Player", "change_camera_7p_8p_in_cave")
		$"7_8p_Cave7-8/Camera_Left_Exit".monitoring = false
		await get_tree().create_timer(0.3).timeout
		body.global_position = $"7_8p_Cave7-8/Camera_Left_Entered/MarkerLeft_Entered".global_position
		$"7_8p_Cave7-8/Camera_Left_Entered".monitoring = false
		await get_tree().create_timer(0.3).timeout
		$"7_8p_Cave7-8/Camera_Left_Exit".monitoring = true
func _on_camera_right_entered_body_entered(body):
	if body.has_method("hurt"):
		get_tree().call_group("Player", "change_camera_7p_8p_in_cave")
		$"7_8p_Cave7-8/Camera_Right_Exit".monitoring = false
		await get_tree().create_timer(0.3).timeout
		body.global_position = $"7_8p_Cave7-8/Camera_Right_Entered/MarkerRight_Entered".global_position
		$"7_8p_Cave7-8/Camera_Right_Entered".monitoring = false
		await get_tree().create_timer(0.3).timeout
		$"7_8p_Cave7-8/Camera_Right_Exit".monitoring = true

func _on_camera_left_exit_body_entered(body): #выход в пещеру 7p-8p
	if body.has_method("hurt"):
		body.global_position = $"7_8p_Cave7-8/Camera_Left_Exit/MarkerLeft_Exit".global_position
		get_tree().call_group("Player", "camera_after_cave_7_8p")
		await get_tree().create_timer(1.0).timeout
		$"7_8p_Cave7-8/Camera_Left_Entered".monitoring = true
func _on_camera_right_exit_body_entered(body):
	if body.has_method("hurt"):
		body.global_position = $"7_8p_Cave7-8/Camera_Right_Exit/MarkerRight_Exit".global_position
		get_tree().call_group("Player", "camera_after_cave_7_8p")
		await get_tree().create_timer(1.0).timeout
		$"7_8p_Cave7-8/Camera_Right_Entered".monitoring = true

func magpie_move_on_tree(): #передвижение сороки к дереву 3р
	magpie.global_position = magpie_marker_tree.global_position
	magpie.rotation = magpie_marker_tree.rotation
	get_tree().call_group("Magpie", "magpie_on_tree")

func spawner_catfish(): # спаунер Сома
	if chek_jump_catfish == false:
		for i in catfish_spawner.get_children():
			if i.position.distance_to(player.position) < 400 and i.position.distance_to(player.position) > 200:
				if player.position.x < i.position.x:
					chek_jump_catfish = true
					catfish.position = i.position
					get_tree().call_group("Catfish", "catfish_left_idle")
				else:
					chek_jump_catfish = true
					catfish.position = i.position
					get_tree().call_group("Catfish", "catfish_right_idle")
func chek_jump_catfish_index():
	await get_tree().create_timer(1.0).timeout
	chek_jump_catfish = false






