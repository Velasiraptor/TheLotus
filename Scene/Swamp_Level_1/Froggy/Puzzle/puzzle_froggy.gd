extends Node2D

@onready var froggy_in_puzzle = %Froggy_in_puzzle
@onready var marker_start_position = %Marker_start_position
@onready var animation_froggy_start = %Animation_Froggy_start
@onready var canvas_layer = %CanvasLayer
@onready var audio_hover_button = %Audio_hover_button
@onready var animation_clue = %Animation_clue

func _ready():
	canvas_layer.visible = false

func _process(delta):
	if canvas_layer.visible == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif canvas_layer.visible == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func start_game():
	canvas_layer.visible = true

func start_position():
	get_tree().call_group("Foggy_in_puzzle", "fail_Frocky_game")
	await get_tree().create_timer(0.4).timeout
	animation_froggy_start.play("start")
	await get_tree().create_timer(0.1).timeout
	froggy_in_puzzle.position = marker_start_position.position


func _on_exit_puzzle_pressed():
	get_tree().call_group("Player", "exit_puzzle")
	canvas_layer.visible = false
	get_tree().call_group("Foggy_in_puzzle", "stop_move")
	froggy_in_puzzle.position = marker_start_position.position
	await get_tree().create_timer(0.5).timeout
	get_tree().call_group("Froggy_in_spikes", "Frocky_saddy")
func _on_exit_puzzle_mouse_entered():
	audio_hover_button.play()

func _on_clue_button_pressed():
	animation_clue.play("Clue_animation")
func _on_clue_button_mouse_entered():
	audio_hover_button.play()
