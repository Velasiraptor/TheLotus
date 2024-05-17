extends Area2D

var item_texture = preload("res://Sprites/SwampLevel1/Inventory_items/Medallion/Medallion_on_tree.png")
@onready var medallion_on_tree_sprite = $MedallionOnTree_sprite
@onready var medallion_on_tree = $"."
@onready var animation_medallion = $Animation_medallion
@onready var animation_shine = $Animation_shine

var anim_name = "medallion_on_tree"

func _on_body_entered(body):
	var check_item = preload("res://Sprites/SwampLevel1/Inventory_items/Medallion/Inventory_medallion.png")
	get_tree().call_group("GUI", "check_inventory_item", check_item)


func item_on():
	medallion_on_tree_sprite.texture = item_texture
	medallion_on_tree_sprite.visible = true
	animation_medallion.play("medallion_on_tree")
	disconnect("body_entered", _on_body_entered)


func _on_animation_medallion_animation_finished(anim_name):
	animation_shine.play("shine")
