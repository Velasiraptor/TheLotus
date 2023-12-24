extends Control

var progress = []
var sceneName
var scene_load_status = 0

func _ready():
	%LabelPressSpace.modulate = "ffffff00"
	sceneName = Globals.new_load_scene
	ResourceLoader.load_threaded_request(sceneName) #запрос на загрузку потока

func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	scene_load_status = ResourceLoader.load_threaded_get_status(sceneName, progress)
	if floor(progress[0]*100) > float(%LabelLoadProcent.text): #ПРОЦЕНТЫ
		%LabelLoadProcent.text = str(floor(progress[0]*100)) + "%"
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		%AnimationPressSpace.play("PressSpace")
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED and Input.is_action_pressed("player_jump"):
		var newScene = ResourceLoader.load_threaded_get(sceneName) #получение загрузочной сцены
		get_tree().change_scene_to_packed(newScene)
