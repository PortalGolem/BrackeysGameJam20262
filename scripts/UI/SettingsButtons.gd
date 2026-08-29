extends Control

var selection = 1
var selection_past = 1
var confirmed = false
var annoying_check = 0
var move_sfx = [preload("res://Sounds/Menu/Move/snd_menu_moveA.mp3"), preload("res://Sounds/Menu/Move/snd_menu_moveC1.mp3"),
preload("res://Sounds/Menu/Move/snd_menu_moveC.mp3"),preload("res://Sounds/Menu/Move/snd_menu_moveD.mp3"),
preload("res://Sounds/Menu/Move/snd_menu_moveE.mp3"),preload("res://Sounds/Menu/Move/snd_menu_moveG.mp3")]
var meow = [preload("res://Sounds/Meow/snd_Meow1.mp3"), preload("res://Sounds/Meow/snd_Meow2.mp3"), preload("res://Sounds/Meow/snd_Meow3.mp3"),
preload("res://Sounds/Meow/snd_Meow4.mp3"), preload("res://Sounds/Meow/snd_Meow5.mp3"), preload("res://Sounds/Meow/snd_Meow6.mp3"),
preload("res://Sounds/Meow/snd_Meow7.mp3"), preload("res://Sounds/Meow/snd_Meow8.mp3"), preload("res://Sounds/Meow/snd_Meow9.mp3"),
preload("res://Sounds/Meow/snd_Meow10.mp3")]
var sound_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MasterSlider.value = global.Master_Volume
	$SFXSlider.value = global.Sound_Volume
	$MusicSlider.value = global.Music_Volume
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if annoying_check > 0:
		if Input.is_action_just_pressed("ui_confirm") == true:
			confirmed = !confirmed
	else:
		annoying_check += 1
#keep track of what we have selected
	if confirmed == false:
		if Input.is_action_just_pressed("ui_down") == true:
			selection += 1
		if Input.is_action_just_pressed("ui_up") == true:
			selection -= 1
		if selection > 6:
			selection = 6
		if selection < 1:
			selection = 1
#play sounds effects
		if selection_past != selection:
			selection_past = selection
			global.sound_play($AudioStreamPlayer, global.gen_random_choice(move_sfx), 1)
	set_selection()
	
	if confirmed == true:
		if selection == 1:
			print("hello")
		if selection == 2:
			slider_move($MasterSlider, 0.75)
			global.Master_Volume = $MasterSlider.value
			if slider_sound():
				global.sound_play($AudioStreamPlayer, move_sfx[3])
		if selection == 3:
			slider_move($MusicSlider, 0.75)
			global.Music_Volume = $MusicSlider.value
			if slider_sound():
				global.music_play($AudioStreamPlayer, move_sfx[3])
		if selection == 4:
			slider_move($SFXSlider, 0.75)
			global.Sound_Volume = $SFXSlider.value
			if slider_sound():
				global.sound_play($AudioStreamPlayer, move_sfx[3])
		if selection == 5:
			global.sound_play($AudioStreamPlayer, global.gen_random_choice(meow))
			confirmed = false
		if selection == 6:
			get_tree().change_scene_to_file("res://MainMenu.tscn")
	pass


func set_selection():
	if selection == 1:
		$"Text+Selection/selection".text = ">"
	if selection == 2:
		$"Text+Selection/selection".text = "\n\n>"
	elif selection == 3:
		$"Text+Selection/selection".text = "\n\n\n\n>"
	elif selection == 4:
		$"Text+Selection/selection".text = "\n\n\n\n\n\n>"
	elif selection == 5:
		$"Text+Selection/selection".text = "\n\n\n\n\n\n\n\n>"
	elif selection == 6:
		$"Text+Selection/selection".text = "\n\n\n\n\n\n\n\n\n\n>"


func slider_move(slider, speed):
	var _inst = slider
	if Input.is_action_pressed("ui_right"):
		_inst.value += _inst.step * speed
	if Input.is_action_pressed("ui_left"):
		_inst.value -= _inst.step * speed
	
func slider_sound():
	var sound_speed = 12
	sound_timer += 1
	if sound_timer == sound_speed:
		sound_timer = 0
		return true
	
