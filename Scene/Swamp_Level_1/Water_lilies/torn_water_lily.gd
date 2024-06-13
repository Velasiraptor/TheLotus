extends Sprite2D

var ind = 1
@onready var animation_player_on_torn_water_lily = %Animation_player_on_torn_water_lily
@onready var animation_torn_water_lily = %Animation_torn_water_lily
@onready var animation_water_drops = %Animation_water_drops
@onready var animation_wave = %Animation_wave


func _on_area_player_body_entered(body):
	if body.has_method("hurt") and ind == 1:
		animation_player_on_torn_water_lily.play("Animation_player_on_torn_water_lily")
		animation_water_drops.play("Animation_water_drops")
		animation_wave.play("Wave")
		animation_torn_water_lily.stop()
		ind = 0
		get_tree().call_group("Level1", "spawner_catfish")

func _on_area_exit_player_body_exited(body):
	if body.has_method("hurt") and ind == 0:
		await get_tree().create_timer(5.0).timeout
		animation_player_on_torn_water_lily.play_backwards("Animation_player_on_torn_water_lily")
		await get_tree().create_timer(1.7).timeout
		animation_torn_water_lily.play("Animation_torn_water_lily")
		ind = 1
