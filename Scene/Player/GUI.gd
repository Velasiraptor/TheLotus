extends CanvasLayer

@onready var animation_icon = %AnimationIcon

var HP_zero : Texture2D = preload("res://Sprites/UI/GUI/HpZero.png")
var HP_full : Texture2D = preload("res://Sprites/UI/GUI/HpFull.png")
var HP_half : Texture2D = preload("res://Sprites/UI/GUI/HpHalf.png")


func _ready():
	pass


func create_max_icon_hp_texture() -> TextureRect: #создание иконок макс хп
	var texture_rect := TextureRect.new()
	texture_rect.texture = HP_zero
	texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
	return texture_rect

func create_half_icon_hp_texture() -> TextureRect: #создание иконок половинок хп
	var texture_rect := TextureRect.new()
	texture_rect.texture = HP_half
	texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
	return texture_rect

func create_full_icon_hp_texture() -> TextureRect: #создание иконок полного хп
	var texture_rect := TextureRect.new()
	texture_rect.texture = HP_full
	texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
	return texture_rect

func max_icon_hp(max_lives : float): #в начале уровня высчитывает максимальное здоровье
	for i in range(max_lives):
		get_node("Control/IconPlayer").add_child(create_max_icon_hp_texture())
		get_node("Control/IconPlayerHalfHp").add_child(create_half_icon_hp_texture())
		get_node("Control/IconPlayerFullHp").add_child(create_full_icon_hp_texture())

func add_update_lives(lives_count): #Прибавление хп
	if fmod(lives_count, 1.0) == 0.5:
		get_node("Control/IconPlayerHalfHp").add_child(create_half_icon_hp_texture())
	else:
		get_node("Control/IconPlayerFullHp").add_child(create_full_icon_hp_texture())

func remove_update_lives(lives_count): #убавление хп
	if fmod(lives_count, 1.0) == 0.5:
		get_node("Control/IconPlayerFullHp").get_child(-1).queue_free()
	else:
		get_node("Control/IconPlayerHalfHp").get_child(-1).queue_free()


func remove_always_hp():
	get_node("Control/IconPlayerFullHp").queue_free()
	get_node("Control/IconPlayerHalfHp").queue_free()
	

func BackgroundsDamage():
	$BackDamage.visible = true
	$BackDamage.frame = 0
	$BackDamage.play("damage")
	$TimerDamage.start()

func BackgroundsHeal():
	$BackHeal.visible = true
	$BackHeal.frame = 0
	$BackHeal.play("heal")
	$TimerHeal.start()

func _on_TimerDamage_timeout():
	$BackDamage.visible = false


func _on_TimerHeal_timeout():
	$BackHeal.visible = false

func idleIcon():
	animation_icon.play("Idle")
func jumpIcon():
	animation_icon.play("jump")
func DMGIcon():
	animation_icon.play("TakeDamage")
func DeathIcon():
	animation_icon.play("Death")
