extends Area2D

var scene = preload("res://Scene/Loads/loadlvl_cave.tscn")

func _ready():
	pass


func _process(delta):
	pass

func _on_body_entered(body):
	$"../../../Player".visible = false
	$WhFrog.visible = true
	$WhFrog.play("default")
	$TimerWhirl.start()


func _on_timer_whirl_timeout():
	get_tree().change_scene_to_file("res://Scene/Loads/loadlvl_cave.tscn")
