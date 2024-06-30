extends CharacterBody2D
class_name Player

enum State { 
	IDLE, 
	WALK_LEFT, 
	WALK_RIGHT, 
	JUMP, 
	TONGUE, 
	TAKE_DAMAGE, 
	DEATH,
	DANGER
}

var state := State.IDLE

@export var speed := 250
@export var Jump_speed := 400
@export var jump_force := 1200
@export var gravity := 3000
@export var length_damage_fall := 2500


var vel = Vector2(0, 0)
var camera_player_position = Vector2(0, -40)
var dustPatricle = load("res://Sprites/Player/Dust.png")
var ind = 1
var idleInd = 1
var ind_jump = 1
var ind_jump_on_water = 0
var ind_fall_damage := false 
var ind_not_fall_damage := false 
var ind_death = 0
var ind_in_puzzle = 0 # 0 - когда не в головоломке или не в синематике, 1 когда вышел из головоломки

@onready var frog_player = %FrogPlayer
@onready var side_frog_player = $SideFrogPlayer
@onready var camera_player = %CameraPlayer
@onready var animation_on_water_oil = %Animation_on_water_oil
@onready var timer_water_quicksand = %Timer_water_quicksand
@onready var timer_danger = %Timer_danger
@onready var timer_emotion_off = %Timer_emotion_off
@onready var emotion = %Emotion
@onready var animation_emotion = %Animation_emotion
@onready var collision_player = %Collision_player




func _ready():
	camera_default()
	max_HP()
	$TongueAr/CollisionShape2D.disabled = true

func _process(delta):
	#$test_label.text = "FPS: " + str(Engine.get_frames_per_second())
	if $".".visible == true:
		items_rigid()
		jump()
		move()
		animate()
		fall_damage_state()
		emit_player()
		shadow()
		soundIdle()
		soundWalk()
		if vel.y >= length_damage_fall and ind_not_fall_damage == false: #урон от падения
			ind_fall_damage = true
		vel.y += gravity * delta


func change_state(new_state: State): #функция изменения состояний
	state = new_state

func camera_default(): # камера и цвет для игрока по умолчанию
	$".".modulate = "ffffff" #удаление тени игрока
	camera_player.position_smoothing_enabled = true
	camera_player.position_smoothing_speed = 3
	camera_player.limit_bottom = 540
	camera_player.limit_top = -1050
	camera_player.limit_left = -2444
	camera_player.limit_right = 29450
	camera_player.zoom.x = 1.7
	camera_player.zoom.y = 1.7
 

func default_characteristics():
	speed = 250
	Jump_speed = 400
	jump_force = 1200

func items_rigid():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * speed / 5)


func move(): #движение
	if Globals.actual_hp_player > 0 and state != State.DANGER and ind_in_puzzle == 0:
		
		if Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and Globals.actual_hp_player > 0.0:  # движение влево
			change_state(State.WALK_LEFT)
			vel.x = -speed
			if Input.is_action_just_pressed("player_take") and not is_on_floor():
				change_state(State.TONGUE)
			if not is_on_floor() and state == State.JUMP:
				vel.x = -Jump_speed 
	
		elif Input.is_action_pressed("player_right") and not Input.is_action_pressed("player_left")  and Globals.actual_hp_player > 0.0:  # движение вправо
			change_state(State.WALK_RIGHT)
			vel.x = speed
			if Input.is_action_just_pressed("player_take") and not is_on_floor():
				change_state(State.TONGUE)
			if not is_on_floor() and state == State.JUMP:
				vel.x = Jump_speed 
	
		elif Input.is_action_just_pressed("player_take") and ind == 1: #Язык
			change_state(State.TONGUE)
	
		elif state == State.TAKE_DAMAGE: #получение урона
			await get_tree().create_timer(0.5).timeout
			change_state(State.IDLE) 
		
		elif is_on_floor() and state != State.TAKE_DAMAGE and state == State.TONGUE \
		and not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right"): # спокойное
			vel.x = 0
		
		elif is_on_floor() and state != State.TAKE_DAMAGE and state != State.TONGUE \
		and not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right"): # спокойное
			vel.x = 0
			#vel.x = lerp(vel.x, 0.0, 0.2) Интерполяция
			change_state(State.IDLE)
	elif Globals.actual_hp_player == 0:
		vel.x = 0 #смерть

func jump(): #прыжок
	if ind_jump == 1 and ind_in_puzzle == 0:
		if Input.is_action_just_pressed("player_jump") and is_on_floor() and Globals.actual_hp_player > 0 or Input.is_action_just_pressed("player_jump") and ind_jump_on_water == 1 and Globals.actual_hp_player > 0 and state != State.DANGER:
			ind_fall_damage = false
			change_state(State.JUMP)
			idleInd = 0
			vel.y -= jump_force
			frog_player.visible = false
			side_frog_player.visible = true
			side_frog_player.frame = 0
			side_frog_player.play("jump")
			get_tree().call_group("GUI", "jumpIcon")
			$jumpSound.play()
			#if side_frog_player.flip_h == false and frog_player.flip_h == true: # Если добавить, то не сможет прыгать тупо вверх
				#vel.x = speed
			#else:
				#vel.x = -speed
	elif Input.is_action_just_pressed("player_jump") and ind_jump == 0:
		emotion.play("Danger")
		get_tree().call_group("GUI", "NoNoIcon")
		timer_emotion_off.stop()
		animation_emotion.play("emotion")
		timer_emotion_off.start()
	set_velocity(vel)
	set_up_direction(Vector2.UP)	
	move_and_slide()
	vel = velocity

func jump_off(): #Отключение прыжка
	ind_jump = 0
func jump_on(): #Включение прыжка
	ind_jump = 1



func drop(): #чтобы при нажатии вниз, игрок падал с конкретных платформ
	if Globals.actual_hp_player > 0:
		position.y += 1

func soundIdle(): #звук при стоячей анимации
	if frog_player.visible == true and frog_player.frame == 32:
		$idleSound.play()

func soundWalk(): #звук ходьбы
	if side_frog_player.visible == true and (side_frog_player.frame == 1 or side_frog_player.frame == 10):
		$walkSound.play()

func animate(): #анимация
	if Globals.actual_hp_player > 0:
		if state == State.WALK_RIGHT:
			frog_player.visible = false
			side_frog_player.visible = true
			side_frog_player.flip_h = false
			frog_player.flip_h = true
			if is_on_floor() and not Input.is_action_just_pressed("player_jump"):
				side_frog_player.play("run")
				if ind_jump == 1:
					get_tree().call_group("GUI", "idleIcon")
				$ParticlesPlayer.position.x = -50
				$ParticlesPlayer.process_material.gravity.x = -5
				$ParticlesPlayer.explosiveness = 0.4
				$ParticlesPlayer.process_material.gravity.y = 0
		elif state == State.WALK_LEFT:
			frog_player.visible = false
			side_frog_player.visible = true
			side_frog_player.flip_h = true
			frog_player.flip_h = false
			if is_on_floor() and not Input.is_action_just_pressed("player_jump"):
				side_frog_player.play("run")
				if ind_jump == 1:
					get_tree().call_group("GUI", "idleIcon")
				$ParticlesPlayer.position.x = 50
				$ParticlesPlayer.process_material.gravity.x = 5
				$ParticlesPlayer.process_material.gravity.y = 0
				$ParticlesPlayer.explosiveness = 0.4
		elif state == State.TONGUE and Input.is_action_just_pressed("player_take") and ind == 1:
			side_frog_player.visible = true
			frog_player.visible = false
			side_frog_player.frame = 0
			side_frog_player.play("Tongue")
			if side_frog_player.flip_h == false:
				$TongueAr/TongueAnim.play("Tongue_right")
			elif side_frog_player.flip_h == true:
				$TongueAr/TongueAnim.play("Tongue_left")
			$TimerIdleTongue.start()
		elif state == State.IDLE:
			if ind_jump == 1:
				get_tree().call_group("GUI", "idleIcon")
			side_frog_player.visible = false
			frog_player.visible = true
			frog_player.play("idle")

func _on_timer_idle_tongue_timeout(): #Возвращает в idle после языка
	if side_frog_player.animation == "Tongue":
		change_state(State.IDLE)

func fall_damage_state(): #урон после падения
	if ind_fall_damage == true and is_on_floor() and ind_not_fall_damage == false:
		hurt()
		ind_fall_damage = false
		return

func not_fall_damage_state(): #функция предотвращающая урон от падения
	ind_not_fall_damage = true
	ind_fall_damage = false
	await get_tree().create_timer(3.0).timeout
	if is_on_floor():
		ind_not_fall_damage = false
	else:
		return


func walk_away_from_danger_right(): # отходит от опасных объектов вправо
	change_state(State.DANGER)
	get_tree().call_group("GUI", "NoNoIcon")
	emotion.flip_h = false
	emotion.position.x = 180
	vel.x = speed
	side_frog_player.flip_h = false
	frog_player.flip_h = true
	side_frog_player.play("run")
	timer_danger.start()
func walk_away_from_danger_left(): # отходит от опасных объектов влево
	change_state(State.DANGER)
	get_tree().call_group("GUI", "NoNoIcon")
	emotion.flip_h = true
	emotion.position.x = -180
	vel.x = -speed
	side_frog_player.flip_h = true
	frog_player.flip_h = false
	side_frog_player.play("run")
	timer_danger.start()
func _on_timer_danger_timeout():
	change_state(State.IDLE)
	emotion.play("Danger")
	timer_emotion_off.stop()
	animation_emotion.play("emotion")
	vel.x = 0
	timer_emotion_off.start()

func _on_timer_emotion_off_timeout():
	animation_emotion.play_backwards("emotion")

func indTrue():
	ind = 1
func indFalse():
	ind = 0

func shadow():
	if frog_player.visible == true || side_frog_player.animation == "run" || side_frog_player.animation == "Tongue" || side_frog_player.animation == "IdleSide":
		$Shadow.visible = true
	else:
		$Shadow.visible = false

func emit_player():
	if state == State.IDLE || state == State.DEATH || state == State.TONGUE || vel.y != 0:
		$ParticlesPlayer.emitting = false
	else:
		$ParticlesPlayer.emitting = true

func end_game():
	$"../GameOver/GameOver".visible = true
	get_tree().call_group("GameOver", "end")

func max_HP(): #в начале уровня высчитывает, сколько всего здоровья
	Globals.actual_hp_player = Globals.count_max_hp_player
	get_tree().call_group("GUI", "max_icon_hp", Globals.count_max_hp_player)

func hurt(): #снятие здоровья
	if Globals.actual_hp_player != 0.0 and Globals.actual_hp_player > 0.0:
		Globals.actual_hp_player -= 1.0
		change_state(State.TAKE_DAMAGE)
		frog_player.visible = false
		side_frog_player.visible = true
		side_frog_player.play("TakeDamage")
		$SideFrogPlayer/EffectsAnim.play("Damage")
		get_tree().call_group("GUI", "DMGIcon")
		$TakeDamage.play()
		vel.y = -600
		get_tree().call_group("GUI", "remove_update_lives")
		get_tree().call_group("GUI", "BackgroundsDamage")
	if Globals.actual_hp_player == 0.0 and ind_death == 0: #Убит
		change_state(State.DEATH)
		vel.y = -400
		side_frog_player.visible = true
		frog_player.visible = false
		side_frog_player.play("Death")
		get_tree().call_group("GUI", "DeathIcon")
		$TimerDeath.start()
		get_tree().call_group("GUI", "remove_update_lives", Globals.actual_hp_player)
		ind_death = 1


func fullHurt(): #мгновенная смерть
	change_state(State.DEATH)
	Globals.actual_hp_player = 0
	vel.x = 0
	side_frog_player.visible = true
	frog_player.visible = false
	side_frog_player.play("Death")
	$FrogPlayer/EffectsAnim.play("Damage")
	get_tree().call_group("GUI", "DeathIcon")
	get_tree().call_group("GUI", "remove_always_hp")
	$TimerDeath.start()

func leftPush(): #толчок от удара справа
	state = State.TAKE_DAMAGE
	vel.x = 500


func RightPush(): #толчок от удара слева
	state = State.TAKE_DAMAGE
	vel.x = -500



func heal(): #лечение здоровья
	if Globals.actual_hp_player > 0 and Globals.actual_hp_player != Globals.count_max_hp_player:
		Globals.actual_hp_player += 1.0
		$SideFrogPlayer/EffectsAnim.play("Heal")
		get_tree().call_group("GUI", "add_update_lives")
		get_tree().call_group("GUI", "BackgroundsHeal")
	else:
		return

func _on_TimerDeath_timeout(): #время появления меню геймовер
	end_game()

func in_puzzle(): # в мини игре или в головоломке
	ind_in_puzzle = 1
	state = State.IDLE
	vel.x = 0
func exit_puzzle():
	ind_in_puzzle = 0


#КОД ДЛЯ ВЗАИМОДЕЙСТВИЙ С 1 УРОВНЕМ/ level 1

#ПЕЩЕРА 1p
func change_camera_1p_cave(): # изменение камеры для игрока при входе в 1р пещеру
	$CameraPlayer/Animation_camera.play("1p_cave", 0, 1.0)

func change_camera_default_1p_cave(): # изменение камеры для игрока при выходе из 1р пещеры
	$".".modulate = "ffffff" #удаление тени игрока
	if camera_player.limit_bottom != 1000:
		$CameraPlayer/Animation_camera.play("1p_cave", 0, -1.0)
	else:
		$CameraPlayer/Animation_camera.play_backwards("1p_cave")

#ПЕЩЕРА 1p_2p
func change_camera_1p_2p_cave():
	$".".modulate = "737373" #добавление тени игроку
	camera_player.limit_bottom = 1359
	not_fall_damage_state()

#ЛОТОС
func emotion_lotus_no_force():
	timer_emotion_off.stop()
	animation_emotion.play("emotion")
	emotion.play("No_force")
	timer_emotion_off.start()

#ДЕРЕВО 3p
func change_camera_3p_tree():
	camera_player.limit_left = 4150
	camera_player.limit_right = 6200
	camera_player.limit_top = -2000

#ПЕЩЕРА 7p_8p
func change_camera_7p_8p_in_cave(): #изменения камеры для пещеры 7р_8р    
	camera_player.limit_bottom = 3200
	$".".modulate = "737373" #добавление тени игроку
	not_fall_damage_state()
	await get_tree().create_timer(0.3).timeout
	camera_player.position_smoothing_enabled = false
	await get_tree().create_timer(0.1).timeout
	camera_player.position_smoothing_enabled = true
	camera_player.position_smoothing_speed = 3
func camera_after_cave_7_8p(): #изменения камеры для выхода из пещеры 7р_8р
	$".".modulate = "ffffff" #удаление тени игрока
	not_fall_damage_state()
	camera_player.position_smoothing_enabled = false
	await  get_tree().create_timer(0.1).timeout
	camera_player.position_smoothing_enabled = true
	camera_player.position_smoothing_speed = 3
	camera_player.limit_bottom = 540

# ЗЫБУЧАЯ ВОДА
func Player_on_water_quicksand():  
	$Timer_water_quicksand.stop()
	if ind_jump_on_water == 0:
		ind_jump_on_water = 1
		speed = 200
		Jump_speed = 300
		jump_force = 650
		animation_on_water_oil.play("player_on_oil")
	else:
		jump_force = 0
func Player_not_on_water_quicksand():
	ind_jump_on_water += 2 #счетчик чтобы не работал прыжок
	timer_water_quicksand.start()
	animation_on_water_oil.play("player_exit_oil")
func _on_timer_water_quicksand_timeout(): # таймер возвращения прыжка по умолчанию
	default_characteristics()
	ind_jump_on_water = 0
