@tool
class_name RandomTimer
extends Timer


@export var min_time: float = 1.0: set = set_min_time
@export var max_time: float = 2.0: set = set_max_time

var rng := RandomNumberGenerator.new()


func _init() -> void:
	one_shot = true

func _ready() -> void:
	rng.randomize()
	
	if autostart and not Engine.is_editor_hint():
		start_random()


func start_random() -> void:
	start(rng.randf_range(min_time, max_time))


func set_min_time(value: float) -> void:
	if value < 0:
		min_time = 0
	else:
		min_time = value

func set_max_time(value: float) -> void:
	if value < 0:
		max_time = 0
	else:
		max_time = value
