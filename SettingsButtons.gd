extends Control

var selection = 0
var confirmed = false
var meow = [preload("res://Sounds/Meow/snd_Meow1.mp3"), preload("res://Sounds/Meow/snd_Meow2.mp3"), preload("res://Sounds/Meow/snd_Meow3.mp3"),
preload("res://Sounds/Meow/snd_Meow4.mp3"), preload("res://Sounds/Meow/snd_Meow5.mp3"), preload("res://Sounds/Meow/snd_Meow6.mp3"),
preload("res://Sounds/Meow/snd_Meow7.mp3"), preload("res://Sounds/Meow/snd_Meow8.mp3"), preload("res://Sounds/Meow/snd_Meow9.mp3"),
preload("res://Sounds/Meow/snd_Meow10.mp3")]

var Master_Volume = 100
var Music_Volume = 100
var SFX_Volume = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_confirm") == true:
		confirmed = !confirmed
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
	
	set_selection()
	
	if confirmed == true:
		if selection == 1:
			print("hello")
		if selection == 2:
			slider_move($MasterSlider, 0.75)
			Master_Volume = $MasterSlider.value
		if selection == 3:
			slider_move($MusicSlider, 0.75)
			Music_Volume = $MusicSlider.value
		if selection == 4:
			slider_move($SFXSlider, 0.75)
			SFX_Volume = $SFXSlider.value
		if selection == 5:
			$AudioStreamPlayer.stream = gen_random_choice(meow)
			$AudioStreamPlayer.play()
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

func gen_random_choice(choices):
	randomize() # Should probably put randomize() outside,
					# since it only needs to be called once per game
	return choices[randi() % choices.size() -1]

func slider_move(slider, speed):
	var _inst = slider
	if Input.is_action_pressed("ui_right"):
		_inst.value += _inst.step * speed
	if Input.is_action_pressed("ui_left"):
		_inst.value -= _inst.step * speed
