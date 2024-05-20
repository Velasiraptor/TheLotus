extends Area2D

## Задержка перед стартом, 1 или 2 секунды по умолчанию
@export var drop_time := 1.0


@onready var timer_drop = %Timer_drop
@onready var animation_drop_acid = %Animation_drop_acid

func _ready():
	timer_drop.wait_time = drop_time
	timer_drop.start()


func _on_timer_drop_timeout():
	animation_drop_acid.play("drop")


func _on_body_entered(body):
	body.hurt()
