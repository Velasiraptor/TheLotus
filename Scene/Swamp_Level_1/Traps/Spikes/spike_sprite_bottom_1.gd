extends Sprite2D

@onready var spike_sprite_bottom_1 = $"."
@onready var sprite_area = %Sprite_Area


var damage_jump := -400


func _on_sprite_area_body_entered(body):
	if body.has_method("hurt") and Globals.actual_hp_player != 0.0:
		body.hurt()
		body.vel.y = damage_jump



