extends CanvasLayer

@onready var animation_icon = %AnimationIcon
@onready var inventory_slot_1 = %Inventory_slot_1
@onready var inventory_slot_2 = %Inventory_slot_2
@onready var inventory_slot_3 = %Inventory_slot_3
@onready var inventory_slot_4 = %Inventory_slot_4
@onready var animation_inventory = %Animation_inventory
@onready var timer_hide_inventory = %Timer_hide_inventory
@onready var texture_slot_1 = %Texture_slot_1
@onready var texture_slot_2 = %Texture_slot_2
@onready var texture_slot_3 = %Texture_slot_3
@onready var texture_slot_4 = %Texture_slot_4


var HP_zero : Texture2D = preload("res://Sprites/UI/GUI/HpZero.png")
var HP_full : Texture2D = preload("res://Sprites/UI/GUI/HpFull.png")
var HP_half : Texture2D = preload("res://Sprites/UI/GUI/HpHalf.png")

var ind_inventory = 0
var anim_name_show = "Animation_inventory_show"
var anim_name_hide = "Animation_inventory_hide"


var ind_death := false #проверка смерти

func _ready():
	pass

#ХП и Плеер бар

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
	if ind_death == false:
		get_node("Control/IconPlayerFullHp").queue_free()
		get_node("Control/IconPlayerHalfHp").queue_free()
		ind_death = true
	

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
func NoNoIcon():
	animation_icon.play("danger")

# ИНВЕНТАРЬ

func _input(event): # Работа клавиш
	if event.is_action_pressed("Inventory_slot_1"):
		inventory_slot_1.grab_focus()
		timer_hide_inventory.stop()
		timer_hide_inventory.start()
		if not animation_inventory.is_playing() and ind_inventory == 0:
			animation_inventory.play("Animation_inventory_show")
			
	if event.is_action_pressed("Inventory_slot_2"):
		inventory_slot_2.grab_focus()
		timer_hide_inventory.stop()
		timer_hide_inventory.start()
		if not animation_inventory.is_playing() and ind_inventory == 0:
			animation_inventory.play("Animation_inventory_show")
			
	if event.is_action_pressed("Inventory_slot_3"):
		inventory_slot_3.grab_focus()
		timer_hide_inventory.stop()
		timer_hide_inventory.start()
		if not animation_inventory.is_playing() and ind_inventory == 0:
			animation_inventory.play("Animation_inventory_show")
			
	if event.is_action_pressed("Inventory_slot_4"):
		inventory_slot_4.grab_focus()
		timer_hide_inventory.stop()
		timer_hide_inventory.start()
		if not animation_inventory.is_playing() and ind_inventory == 0:
			animation_inventory.play("Animation_inventory_show")

func _on_animation_inventory_animation_finished(anim_name):
	if anim_name == "Animation_inventory_show":
		ind_inventory = 1
	else:
		ind_inventory = 0

func _on_timer_hide_inventory_timeout():
	animation_inventory.play("Animation_inventory_hide")


func check_inventory_null_slots(new_texture_in_slot): # проверяем на свободный слот, принимает текстуру
	if texture_slot_1.texture != null:
		print("занято")
	else:
		texture_slot_1.texture = new_texture_in_slot
		animation_inventory.play("Animation_inventory_show")
		timer_hide_inventory.stop()
		timer_hide_inventory.start()
		return
	if texture_slot_2.texture != null:
		print("занято")
	else:
		texture_slot_2.texture = new_texture_in_slot
		animation_inventory.play("Animation_inventory_show")
		timer_hide_inventory.stop()
		timer_hide_inventory.start()
		return
	if texture_slot_3.texture != null:
		print("занято")
	else:
		texture_slot_3.texture = new_texture_in_slot
		animation_inventory.play("Animation_inventory_show")
		timer_hide_inventory.stop()
		timer_hide_inventory.start()
		return
	if texture_slot_4.texture != null:
		print("занято")
	else:
		texture_slot_4.texture = new_texture_in_slot
		animation_inventory.play("Animation_inventory_show")
		timer_hide_inventory.stop()
		timer_hide_inventory.start()
		return

func check_inventory_item(item_texture): # проверяем на нужный предмет, принимает текстуру
	if not animation_inventory.is_playing() and ind_inventory == 0:
		animation_inventory.play("Animation_inventory_show")
		timer_hide_inventory.stop()
	if texture_slot_1.texture == item_texture and inventory_slot_1.has_focus():
		items_on(texture_slot_1.texture)
		texture_slot_1.texture = null
		timer_hide_inventory.start()
	elif texture_slot_2.texture == item_texture and inventory_slot_2.has_focus():
		items_on(texture_slot_2.texture)
		texture_slot_2.texture = null
		timer_hide_inventory.start()
	elif texture_slot_3.texture == item_texture and inventory_slot_3.has_focus():
		items_on(texture_slot_3.texture)
		texture_slot_3.texture = null
		timer_hide_inventory.start()
	elif texture_slot_4.texture == item_texture and inventory_slot_4.has_focus():
		items_on(texture_slot_4.texture)
		texture_slot_4.texture = null
		timer_hide_inventory.start()
	else:
		NoNoIcon()
		timer_hide_inventory.start()

func items_on(item_texture):
	print(item_texture)
	if item_texture == preload("res://Sprites/SwampLevel1/Inventory_items/Medallion/Inventory_medallion.png"):
		get_tree().call_group("Medallion_on_tree", "item_on")
