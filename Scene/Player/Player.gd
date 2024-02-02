extends CharacterBody2D
class_name Player

enum State { IDLE, WALK_LEFT, WALK_RIGHT, JUMP, TONGUE, TAKE_DAMAGE, DEATH }

var state := State.IDLE

@export var speed := 250
@export var Jump_speed := 400
@export var jump_force := 1000
@export var gravity := 2200

var vel = Vector2(0, 0)
var dustPatricle = load("res://Sprites/Player/Dust.png")
var ind = 1
var idleInd = 1


@onready var frog_player = %FrogPlayer
@onready var side_frog_player = $SideFrogPlayer
@onready var camera_player = %CameraPlayer


func _ready():
	camera_default()
	max_HP()
	$TongueAr/CollisionShape2D.disabled = true

func _physics_process(delta):
	if $".".visible == true:
		move()
		jump()
		animate()
		emit_player()
		shadow()
		soundIdle()
		soundWalk()
		vel.y += gravity * delta


func change_state(new_state: State): #функция изменения состояний
	state = new_state

func camera_default(): # камера для игрока по умолчанию
	camera_player.limit_bottom = 540
	camera_player.limit_top = -1050
	camera_player.limit_left = -4000
	camera_player.zoom.x = 1.7
	camera_player.zoom.y = 1.7

func move(): #движение
	if Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and Globals.actual_hp_player > 0.0:  # движение влево
		change_state(State.WALK_LEFT)
		vel.x = -speed
		if not is_on_floor() and state == State.JUMP:
			vel.x = -Jump_speed 
	
	elif Input.is_action_pressed("player_right") and not Input.is_action_pressed("player_left")  and Globals.actual_hp_player > 0.0:  # движение вправо
		change_state(State.WALK_RIGHT)
		vel.x = speed
		if not is_on_floor() and state == State.JUMP:
			vel.x = Jump_speed 
	
	elif Input.is_action_just_pressed("player_take") and is_on_floor() and ind == 1: #Язык
		change_state(State.TONGUE)
		vel.x = 0
	
	elif state == State.TAKE_DAMAGE: #получение урона
		await get_tree().create_timer(0.5).timeout
		change_state(State.IDLE) 
	
	elif is_on_floor() and state != State.TAKE_DAMAGE and state != State.TONGUE \
	and not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right"): # спокойное
		vel.x = 0
		#vel.x = lerp(vel.x, 0.0, 0.2) Интерполяция
		change_state(State.IDLE)

func jump(): #прыжок
	if Input.is_action_just_pressed("player_jump") and is_on_floor() and Globals.actual_hp_player > 0:
		if vel.y > 0: #прыжок
			change_state(State.JUMP)
			idleInd = 0
			vel.y -= jump_force
			frog_player.visible = false
			side_frog_player.visible = true
			side_frog_player.frame = 0
			side_frog_player.play("jump")
			get_tree().call_group("GUI", "jumpIcon")
			$jumpSound.play()
	set_velocity(vel)
	set_up_direction(Vector2.UP)
	move_and_slide()
	vel = velocity


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
				get_tree().call_group("GUI", "idleIcon")
				$ParticlesPlayer.position.x = -50
				$ParticlesPlayer.process_material.gravity.x = -5
				$ParticlesPlayer.explosiveness = 0.4
				$ParticlesPlayer.process_material.gravity.y = 0
			elif vel.y > 0 and not $RayCastFall.is_colliding():#падение
				frog_player.visible = false
				side_frog_player.visible = true
				side_frog_player.play("Fall") 
				get_tree().call_group("GUI", "idleIcon")
		elif state == State.WALK_LEFT:
			frog_player.visible = false
			side_frog_player.visible = true
			side_frog_player.flip_h = true
			frog_player.flip_h = false
			if is_on_floor() and not Input.is_action_just_pressed("player_jump"):
				side_frog_player.play("run")
				get_tree().call_group("GUI", "idleIcon")
				$ParticlesPlayer.position.x = 50
				$ParticlesPlayer.process_material.gravity.x = 5
				$ParticlesPlayer.process_material.gravity.y = 0
				$ParticlesPlayer.explosiveness = 0.4
			elif vel.y > 0 and not $RayCastFall.is_colliding():
				frog_player.visible = false
				side_frog_player.visible = true
				side_frog_player.play("Fall") #падение
				get_tree().call_group("GUI", "idleIcon")
		elif state == State.TONGUE and Input.is_action_just_pressed("player_take") and is_on_floor() and ind == 1:
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
			get_tree().call_group("GUI", "idleIcon")
			side_frog_player.visible = false
			frog_player.visible = true
			frog_player.play("idle")
	else:
		change_state(State.DEATH)
		side_frog_player.play("Death")
		get_tree().call_group("GUI", "DeathIcon")

func _on_timer_idle_tongue_timeout(): #Возвращает в idle после языка
	if side_frog_player.animation == "Tongue":
		change_state(State.IDLE)

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
	if state == State.IDLE || state == State.DEATH || state == State.TONGUE:
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
	Globals.actual_hp_player -= 0.5
	if Globals.actual_hp_player > 0.0 and Globals.actual_hp_player != 0.0:
		change_state(State.TAKE_DAMAGE)
		frog_player.visible = false
		side_frog_player.visible = true
		side_frog_player.play("TakeDamage")
		$SideFrogPlayer/EffectsAnim.play("Damage")
		get_tree().call_group("GUI", "DMGIcon")
		$TakeDamage.play()
		vel.y = -600
		get_tree().call_group("GUI", "remove_update_lives", Globals.actual_hp_player)
		get_tree().call_group("GUI", "BackgroundsDamage")
	if Globals.actual_hp_player == 0.0: #Убит
		change_state(State.DEATH)
		vel.y = -400
		side_frog_player.visible = true
		frog_player.visible = false
		side_frog_player.play("Death")
		get_tree().call_group("GUI", "DeathIcon")
		$TimerDeath.start()
		get_tree().call_group("GUI", "remove_update_lives", Globals.actual_hp_player)

func fullHurt(): #мгновенная смерть
	Globals.actual_hp_player = 0
	side_frog_player.visible = true
	frog_player.visible = false
	side_frog_player.play("Death")
	$FrogPlayer/EffectsAnim.play("Damage")
	get_tree().call_group("GUI", "DeathIcon")
	get_tree().call_group("GUI", "remove_always_hp")
	$TimerDeath.start()

func leftPush(): #толчок от удара справа
	vel.x = 500

func RightPush(): #толчок от удара слева
	vel.x = -500


func heal(): #лечение здоровья
	if Globals.actual_hp_player > 0 and Globals.actual_hp_player != Globals.count_max_hp_player:
		Globals.actual_hp_player += 0.5
		$SideFrogPlayer/EffectsAnim.play("Heal")
		get_tree().call_group("GUI", "add_update_lives", Globals.actual_hp_player)
		get_tree().call_group("GUI", "BackgroundsHeal")
	else:
		return

func _on_TimerDeath_timeout(): #время появления меню геймовер
	end_game()



#КОД ДЛЯ ВЗАИМОДЕЙСТВИЙ С 1 УРОВНЕМ

func change_camera_1p_cave(): # изменение камеры для игрока при входе в 1р пещеру
	$CameraPlayer/Animation_camera.play("1p_cave", 0, 1.0)
	$".".modulate = "737373" #добавление тени игроку

func change_camera_default_1p_cave(): # изменение камеры для игрока при выходе из 1р пещеры
	$".".modulate = "ffffff" #удаление тени игрока
	if camera_player.limit_bottom != 1000:
		$CameraPlayer/Animation_camera.play("1p_cave", 0, -1.0)
	else:
		$CameraPlayer/Animation_camera.play_backwards("1p_cave")
