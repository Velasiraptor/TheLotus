extends Area2D

@onready var magpie_lotus = $Magpie_lotus
@onready var magpie_tree = $Magpie_tree


func _on_body_entered(body):
	if body.has_method("hurt"):
		get_tree().call_group("Player", "walk_away_from_danger_right")

func magpie_on_tree():
	magpie_lotus.queue_free()
	magpie_tree.visible = true
	magpie_tree.play("Tree")


func _on_magpie_tree_animation_finished():
	magpie_tree.play("Medalion")
	get_tree().call_group("Medallion_on_tree", "medallion_skew_magpie")
