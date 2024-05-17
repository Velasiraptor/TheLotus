extends Area2D

var new_texture_in_slot = preload("res://Sprites/SwampLevel1/Inventory_items/Medallion/Inventory_medallion.png")
@onready var take_item_emotion = %TakeItemEmotion
@onready var animation_emotion = %AnimationEmotion



func _on_body_entered(body):
	get_tree().call_group("GUI", "check_inventory_null_slots", new_texture_in_slot)
	$".".queue_free()
	


func _on_take_emotion_body_entered(body):
	animation_emotion.play("emotion")
	
func _on_take_emotion_body_exited(body):
	animation_emotion.play_backwards("emotion")
