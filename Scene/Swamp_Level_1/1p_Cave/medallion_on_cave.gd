extends Area2D

var new_texture_in_slot = preload("res://Sprites/SwampLevel1/Inventory_items/Medallion/Inventory_medallion.png")

func _on_body_entered(body):
	get_tree().call_group("GUI", "check_inventory_null_slots", new_texture_in_slot)
	$".".queue_free()
	
