extends Node2D

func _ready(): #старт комикса
	$background/frame2.visible = false
	$background/frame3.visible = false
	$background/frame4.visible = false
	$background/frame5.visible = false
	$background/frame6.visible = false
	$background/frame6/sad6.visible = false
	$background/frame7.visible = false
	$background/frame7/sad7.visible = false
	$background/frame8.visible = false
	$background/frame8/HELP.visible = false
	$background/frame8/ExclamationPoint8.visible = false
	$background/frame1/Animation_frame1.play("frame1")
	$background/frame2/Timer_frame2.start()



func _on_timer_frame_2_timeout(): #начало второго кадра
	$background/frame2/Animation_frame2.play("frame2")
	$background/frame3/Timer_frame3.start()
	$background/frame3/Timer_throw.start()


func _on_timer_frame_3_timeout(): #начало третьего кадра
	$background/frame3/Animation_frame3.play("frame3")
	$background/frame4/Timer_frame4.start()
func _on_timer_throw_timeout(): #звук бутылки
	$background/frame3/Audio_throw.play()

func _on_timer_frame_4_timeout(): #начало четвертого кадра
	$background/frame4.visible = true
	$background/frame4/dive4.play()
	$background/frame5/Timer_frame5.start()


func _on_timer_frame_5_timeout(): #начало пятого кадра
	$background/frame5.visible = true
	$background/frame5/dive5.play()
	$background/frame6/Timer_frame6.start()


func _on_timer_frame_6_timeout(): #начало шестого кадра
	$background/frame6/Animation_frame6.play("frame6")
	$background/frame7/Timer_frame7.start()


func _on_timer_frame_7_timeout(): #начало седьмого кадра
	$background/frame7/Animation_frame7.play("frame7")
	$background/frame8/Timer_frame8.start()


func _on_timer_frame_8_timeout(): #начало восьмого кадра
	$background/frame8/Animation_frame8.play("frame8")



