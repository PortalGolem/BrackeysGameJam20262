extends Control

var selection = 1
var selection_past = 1
var font = global.Main_Font
var music = "res://Sounds/Music/spheretypebeat.mp3"
var move_sfx = [preload("res://Sounds/Menu/Move/snd_menu_moveA.mp3"), preload("res://Sounds/Menu/Move/snd_menu_moveC1.mp3"),
preload("res://Sounds/Menu/Move/snd_menu_moveC.mp3"),preload("res://Sounds/Menu/Move/snd_menu_moveD.mp3"),
preload("res://Sounds/Menu/Move/snd_menu_moveE.mp3"),preload("res://Sounds/Menu/Move/snd_menu_moveG.mp3")]
var annoying_check = 0
var main_menu = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#font shit
	add_theme_font_override("normal_font", load(global.Main_Font))
	
	#check if we back to the main men
	if !main_menu:
		self.visible = false
		if !$"../SettingsMenu".settings:
			main_menu = true
	
	#only display if we true
	else:
		self.visible = true
	#keep track of what we have selected
		if Input.is_action_just_pressed("ui_down") == true:
			selection += 1
		if Input.is_action_just_pressed("ui_up") == true:
			selection -= 1
		if selection > 3:
			selection = 3
		if selection < 1:
			selection = 1
	#play sound effects
		if selection_past != selection:
			selection_past = selection
			global.sound_play($"../AudioStreamPlayer", global.gen_random_choice(move_sfx), 1)
		set_selection()
		if Input.is_action_just_pressed("ui_confirm") == true:
			if selection == 1:
				get_tree().change_scene_to_file("res://Scenes/TableSpace.tscn")
			if selection == 2:
				$"../SettingsMenu".settings = true
				main_menu = false
			if selection == 3:
				get_tree().quit()
		
		#set up music player and add music
		if annoying_check == 0:
			if global.Music == null:
				const Music_Scene = preload("res://Scenes/music_stream_player.tscn")
				var Music_Player = Music_Scene.instantiate()
				get_tree().root.add_child(Music_Player)
				global.Music = "res://Sounds/Music/spheretypebeat.mp3"
				annoying_check += 1
	pass

func set_selection():
	if selection == 0:
		$Selection1.text = ""
		$Selection2.text = ""
		$Selection3.text = ""
	if selection == 1:
		$Selection1.text = ">"
		$Selection2.text = ""
		$Selection3.text = ""
	elif selection == 2:
		$Selection1.text = ""
		$Selection2.text = ">"
		$Selection3.text = ""
	elif selection == 3:
		$Selection1.text = ""
		$Selection2.text = ""
		$Selection3.text = ">"
