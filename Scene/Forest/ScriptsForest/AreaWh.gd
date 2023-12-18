extends Area2D

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
	Globals.new_load_scene = "res://Scene/Cave/CaveLVL.tscn"
	var loadingScreen = load("res://Scene/Loads/LoadScene.tscn")
	get_tree().change_scene_to_packed(loadingScreen)
