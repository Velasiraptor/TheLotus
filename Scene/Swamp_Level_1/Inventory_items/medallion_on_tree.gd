extends Area2D

@export var item_texture = preload("res://Sprites/SwampLevel1/Inventory_items/Medallion/Medallion_on_tree.png")

@export var item = "medalion"

@onready var medallion_on_tree_sprite = $MedallionOnTree_sprite
@onready var medallion_on_tree = $"."
@onready var animation_medallion = $Animation_medallion
@onready var animation_shine = $Animation_shine
@onready var animation_emotion = %AnimationEmotion
@onready var take_emotion = %Take_emotion


var anim_name = "medallion_on_tree"

func _on_body_entered(body):
	get_tree().call_group("GUI", "check_inventory_item", item)


func item_on():
	medallion_on_tree_sprite.texture = item_texture
	medallion_on_tree_sprite.visible = true
	animation_medallion.play("medallion_on_tree")
	get_tree().call_group("Tree_level_1", "Jump_player_activated")
	animation_emotion.play_backwards("emotion")
	take_emotion.queue_free()
	disconnect("body_entered", _on_body_entered)



func _on_animation_medallion_animation_finished(anim_name):
	animation_shine.play("shine")

func medallion_skew_magpie():
	animation_medallion.play("medallion_magpie")



func _on_take_emotion_body_entered(body):
	animation_emotion.play("emotion")
func _on_take_emotion_body_exited(body):
	animation_emotion.play_backwards("emotion")
