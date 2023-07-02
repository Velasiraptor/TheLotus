extends CharacterBody2D

const SPEED = 200
const jumpForce = 800
const gravity = 2000
const jumpSPEED = 300

var vel = Vector2(0, 0)
var lives = 6
var dustPatricle = load("res://Sprites/Player/Dust.png")
var grassParticle = load("res://Sprites/Player/GrassParticle.png")
var ind = 1

func _physics_process(delta):
	if $".".visible == true:
		move()
		jump()
		animate()
		shadow()
		soundIdle()
		soundWalk()
		vel.y += gravity * delta

func move():
	if Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and lives > 0 and $"Лягуха".animation != "TakeDamage":
		vel.x = -SPEED
		if vel.y < 0:
			vel.x = -jumpSPEED
	elif Input.is_action_pressed("player_right") and not Input.is_action_pressed("player_left") and lives > 0 and $"Лягуха".animation != "TakeDamage":
		vel.x = SPEED
		if vel.y < 0:
			vel.x = jumpSPEED
	elif is_on_floor() and $"Лягуха".visible == false:
		vel.x = 0

func jump():
	if Input.is_action_pressed("player_jump") and is_on_floor() and lives > 0:
		if vel.y > 0: #прыжок
			vel.y -= jumpForce
			$"Лягуха2".visible = false
			$"Лягуха".visible = true
			$"Лягуха".frame = 0
			$"Лягуха".play("jump")
			get_tree().call_group("GUI", "jumpIcon")
			$jumpSound.play()
			if $"Лягуха".flip_h == false:
				vel.x = jumpSPEED
			else:
				vel.x = -jumpSPEED
	set_velocity(vel)
	set_up_direction(Vector2.UP)
	move_and_slide()
	vel = velocity

func soundIdle(): #звук при стоячей анимации
	if $"Лягуха2".visible == true and $"Лягуха2".frame == 32:
		$idleSound.play()

func soundWalk(): #звук ходьбы
	if $"Лягуха".visible == true and ($"Лягуха".frame == 1 or $"Лягуха".frame == 10):
		$walkSound.play()

#РАЗЛИЧНЫЕ СПРАЙТЫ ЧАСТИЦ
func DustParticle(): #частицы в виде грязи
	#$ParticlesPlayer.texture = dustPatricle
	pass
func waterParticle(): #частицы в виде капель
	pass


func animate():
	if Input.is_action_pressed("player_right") and not Input.is_action_pressed("player_left") and lives > 0:
		$"Лягуха2".visible = false
		$"Лягуха".visible = true
		$"Лягуха".flip_h = false
		$"Лягуха2".flip_h = true
		if is_on_floor() and not Input.is_action_just_pressed("player_jump"):
			$"Лягуха".play("run")
			get_tree().call_group("GUI", "idleIcon")
			$ParticlesPlayer.emitting = true #вкл частицы
			$ParticlesPlayer.position.x = -50
			$ParticlesPlayer.process_material.gravity.x = -5
			$ParticlesPlayer.explosiveness = 0.4
			$ParticlesPlayer.process_material.gravity.y = 0
		elif vel.y > 0 and not $RayCastFall.is_colliding():#падение
			$"Лягуха2".visible = false
			$"Лягуха".visible = true
			$"Лягуха".play("Fall") 
			get_tree().call_group("GUI", "idleIcon")
			$ParticlesPlayer.emitting = false #выкл частицы
	elif Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and lives > 0:
		$"Лягуха2".visible = false
		$"Лягуха".visible = true
		$"Лягуха".flip_h = true
		$"Лягуха2".flip_h = false
		if is_on_floor() and not Input.is_action_just_pressed("player_jump"):
			$"Лягуха".play("run")
			get_tree().call_group("GUI", "idleIcon")
			$ParticlesPlayer.emitting = true #вкл частицы
			$ParticlesPlayer.position.x = 50
			$ParticlesPlayer.process_material.gravity.x = 5
			$ParticlesPlayer.process_material.gravity.y = 0
			$ParticlesPlayer.explosiveness = 0.4
		elif vel.y > 0 and not $RayCastFall.is_colliding():
			$"Лягуха2".visible = false
			$"Лягуха".visible = true
			$"Лягуха".play("Fall") #падение
			get_tree().call_group("GUI", "idleIcon")
			$ParticlesPlayer.emitting = false #выкл частицы
	elif Input.is_action_just_pressed("player_take") and is_on_floor() and ind == 1: #Язык
		$"Лягуха".visible = true
		$"Лягуха2".visible = false
		$"Лягуха".frame = 0
		$"Лягуха".play("Tongue")
		$TimerIdle.start()
	else:
		if is_on_floor() and lives > 0 and $"Лягуха".animation != "Tongue":
			$"Лягуха".visible = false
			$"Лягуха2".visible = true
			$"Лягуха2".play("idle")
			get_tree().call_group("GUI", "idleIcon")
			$ParticlesPlayer.emitting = false #выкл частицы

func indTrue():
	ind = 1
func indFalse():
	ind = 0


func shadow():
	if $"Лягуха2".visible == true || $"Лягуха".animation == "run" || $"Лягуха".animation == "Tongue":
		$Shadow.visible = true
	else:
		$Shadow.visible = false

func end_game():
	$"../GameOver/GameOver".visible = true
	get_tree().call_group("GameOver", "end")


func hurt(): #снятие здоровья
	lives -= 1
	if lives > 0 and lives != 0:
		$"Лягуха2".visible = false
		$"Лягуха".visible = true
		$"Лягуха".play("TakeDamage")
		get_tree().call_group("GUI", "DMGIcon")
		$TakeDamage.play()
		vel.y = -600
		get_tree().call_group("GUI", "update_lives", lives)
		get_tree().call_group("GUI", "BackgroundsDamage")
	if lives == 0: #Убит
		vel.y = -400
		$"Лягуха".visible = false
		$"Лягуха2".visible = true
		$"Лягуха2".play("Death")
		get_tree().call_group("GUI", "DeathIcon")
		$TimerDeath.start()
		get_tree().call_group("GUI", "update_lives", lives)

func fullHurt(): #мгновенная смерть
	lives -= 6
	$"Лягуха".visible = false
	$"Лягуха2".visible = true
	$"Лягуха2".play("Death")
	get_tree().call_group("GUI", "DeathIcon")
	$TimerDeath.start()
	get_tree().call_group("GUI", "update_lives", lives)

func leftPush(): #толчок от удара справа
	vel.x = 500

func RightPush(): #толчок от удара слева
	vel.x = -500


func heal(): #лечение здоровья
	if lives != 0 and lives != 6:
		lives += 1
		get_tree().call_group("GUI", "update_lives", lives)
		get_tree().call_group("GUI", "BackgroundsHeal")


func _on_timer_idle_timeout(): #Возвращает в idle
	$"Лягуха".visible = false
	$"Лягуха2".visible = true
	$"Лягуха2".play("idle")

func _on_TimerDeath_timeout(): #время появления меню геймовер
	end_game()


func  WaterSound(): #Вода на уровнях
	pass




