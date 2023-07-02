extends CanvasLayer


func _ready():
	pass

func update_lives(lives_count):
	if lives_count == 6:
		$"Control/6hp".visible = true
		$"Control/5hp".visible = false
		$"Control/4hp".visible = false
		$"Control/3hp".visible = false
		$"Control/2hp".visible = false
		$"Control/1hp".visible = false
		$"Control/0hp".visible = false
	elif lives_count == 5:
		$"Control/6hp".visible = false
		$"Control/5hp".visible = true
		$"Control/4hp".visible = false
		$"Control/3hp".visible = false
		$"Control/2hp".visible = false
		$"Control/1hp".visible = false
		$"Control/0hp".visible = false
	elif lives_count == 4:
		$"Control/6hp".visible = false
		$"Control/5hp".visible = false
		$"Control/4hp".visible = true
		$"Control/3hp".visible = false
		$"Control/2hp".visible = false
		$"Control/1hp".visible = false
		$"Control/0hp".visible = false
	elif lives_count == 3:
		$"Control/6hp".visible = false
		$"Control/5hp".visible = false
		$"Control/4hp".visible = false
		$"Control/3hp".visible = true
		$"Control/2hp".visible = false
		$"Control/1hp".visible = false
		$"Control/0hp".visible = false
	elif lives_count == 2:
		$"Control/6hp".visible = false
		$"Control/5hp".visible = false
		$"Control/4hp".visible = false
		$"Control/3hp".visible = false
		$"Control/2hp".visible = true
		$"Control/1hp".visible = false
		$"Control/0hp".visible = false
	elif lives_count == 1:
		$"Control/6hp".visible = false
		$"Control/5hp".visible = false
		$"Control/4hp".visible = false
		$"Control/3hp".visible = false
		$"Control/2hp".visible = false
		$"Control/1hp".visible = true
		$"Control/0hp".visible = false
	elif lives_count == 0:
		$"Control/6hp".visible = false
		$"Control/5hp".visible = false
		$"Control/4hp".visible = false
		$"Control/3hp".visible = false
		$"Control/2hp".visible = false
		$"Control/1hp".visible = false
		$"Control/0hp".visible = true

func BackgroundsDamage():
	$BackDamage.visible = true
	$BackDamage.frame = 0
	$BackDamage.play("damage")
	$TimerDamage.start()

func BackgroundsHeal():
	$BackHeal.visible = true
	$BackHeal.frame = 0
	$BackHeal.play("heal")
	$TimerHeal.start()

func _on_TimerDamage_timeout():
	$BackDamage.visible = false


func _on_TimerHeal_timeout():
	$BackHeal.visible = false

func idleIcon():
	$Control/IconPlayer/Icon.play("Idle")
func jumpIcon():
	$Control/IconPlayer/Icon.play("jump")
func DMGIcon():
	$Control/IconPlayer/Icon.play("TakeDamage")
func DeathIcon():
	$Control/IconPlayer/Icon.play("Death")
