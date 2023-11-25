extends CharacterBody2D

const Speed = 200
const JumpForce = 700
const Gravity = 1200
const Floor = Vector2(0,-1)


var vel = Vector2()
var direction = -1
var ind = 0

func _ready():
	$AnimRacoon.play("walk")

func _physics_process(delta):
	EnemyMove()
	WallRay()
	FloorRay()
	AttackMeh()
	vel.y += Gravity * delta
	set_velocity(vel)
	set_up_direction(Floor)
	move_and_slide()
	vel = velocity

func WallRay(): #обнаружение стен
	if $RayCastWall.is_colliding():
		direction *=-1
		$RayCastWall.position.x *= -1;
		$RayCastFloor.position.x *= -1;
		$DetectPlayer/CollisDP.position.x *= -1;
		$Attack/CollisAT.position.x *= -1;
		$AttackBehind/CollisTail.position.x *= -1;
		$RayCastFloor.rotation_degrees *= -1;
		$RayCastWall.rotation_degrees *= -1;
		$Shadow.position.x *= -1;
		$AnimRacoon.flip_h = bool(1 + direction)


func FloorRay(): #обнаружение пола
	if not $RayCastFloor.is_colliding():
		direction *=-1
		$RayCastFloor.position.x *= -1;
		$RayCastWall.position.x *= -1;
		$DetectPlayer/CollisDP.position.x *= -1;
		$Attack/CollisAT.position.x *= -1;
		$AttackBehind/CollisTail.position.x *= -1;
		$RayCastFloor.rotation_degrees *= -1;
		$RayCastWall.rotation_degrees *= -1;
		$Shadow.position.x *= -1;
		$AnimRacoon.flip_h = bool(1 + direction)


func EnemyMove():
	if $AnimRacoon.animation == "walk":
		vel.x = direction * Speed
	if $AnimRacoon.animation == "run":
		vel.x = direction * Speed * 1.5
		$RandomTimerIdle.start_random()
	if $AnimRacoon.animation == "idle":
		vel.x = 0
	if $AnimRacoon.animation == "attack":
		vel.x = 0

func _on_DetectPlayer_body_entered(body): #механика с игроком
	if body.has_method("hurt") and $AnimRacoon.animation != "attack":
		$AnimRacoon.play("idle")
		$TimeRun.start()


func _on_DetectPlayer_body_exited(body):
	if body.has_method("hurt") and $AnimRacoon.animation != "attack" or $AnimRacoon.animation == "run":
		$AnimRacoon.play("walk")
		ind = 0


func _on_TimeRun_timeout(): #таймер после стоячей анимации бежит
	if $AnimRacoon.animation == "idle":
		$AnimRacoon.play("run")
		ind = 1


func _on_Attack_body_entered(body): #атака
	if body.has_method("hurt"):
		$AnimRacoon.play("attack")
		$RacoonRrr.play()
		body.hurt()
		body.hurt()
		if $AnimRacoon.flip_h == true:
			body.leftPush()
		else:
			body.RightPush()

func _on_AttackBehind_body_entered(body): #разворот когда наступают на хвост или спину
	if body.has_method("hurt"):
		direction *=-1
		$RayCastFloor.position.x *= -1;
		$RayCastWall.position.x *= -1;
		$DetectPlayer/CollisDP.position.x *= -1;
		$Attack/CollisAT.position.x *= -1;
		$AttackBehind/CollisTail.position.x *= -1;
		$RayCastFloor.rotation_degrees *= -1;
		$RayCastWall.rotation_degrees *= -1;
		$Shadow.position.x *= -1;
		$AnimRacoon.flip_h = bool(1 + direction)


func AttackMeh():
	if $AnimRacoon.frame == 4 and $AnimRacoon.animation == "attack":
		$AnimRacoon.play("idle")
		$Attack/CollisAT.disabled = true
		$TimeAttack.start()

func _on_TimeAttack_timeout(): #идет после атаки
	if ind == 1:
		$AnimRacoon.play("run")
		$Attack/CollisAT.disabled = false
	else:
		$AnimRacoon.play("walk")
		$Attack/CollisAT.disabled = false


func _on_random_timer_idle_timeout(): #Рандомный таймер отдыха
	$AnimRacoon.play("idle")
	$RacoonRrr.play()
	$TimerWalk.start()
func _on_timer_walk_timeout(): #таймер ходьбы после отдыха
	$AnimRacoon.play("walk")
	$RandomTimerIdle.start_random()
