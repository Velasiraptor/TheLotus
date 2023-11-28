extends Node2D

@onready var grass_animation := %GrassAnimation
var random_animation_slow := str("random_animation")
var random_animation_shake := str("random_animation_shake")

var animations_slow := ["Area_grass_animation_slow_0", "Area_grass_animation_slow_1", "Area_grass_animation_slow_2"]
var animations_shake := ["Area_grass_animation_shake_0", "Area_grass_animation_shake_1"]

func _ready():
	random_animation_slow = animations_slow[randi() % 3]
	random_animation_shake = animations_shake[randi() % 2]
	grass_animation.play(str(random_animation_slow))

func _on_area_player_body_entered(body):
	grass_animation.play(random_animation_shake)
	await get_tree().create_timer(randf_range(0.3, 0.6)).timeout
	slow_grass()


func slow_grass():
	random_animation_shake = animations_shake[randi() % 2]
	grass_animation.play(str(random_animation_slow))
