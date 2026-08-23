extends CanvasLayer

var char_spd = 0.7
var char_cur = 0
@export var text = "\n\n\nHey Dan! Could you send this over to Stacy upstairs?\n\n Best, \n Nathan"

var opacity = 0
var opacity_speed = 0.0333333333
var position_offset = 80
var fade_out = false

var color = "yellow"
var text_sound = [preload("res://Sounds/Text/txt1.wav"), preload("res://Sounds/Text/txt2.wav"), 
preload("res://Sounds/Text/txt3.wav"), preload("res://Sounds/Text/txt4.wav"), preload("res://Sounds/Text/txt5.wav"),
preload("res://Sounds/Text/txt6.wav"), preload("res://Sounds/Text/txt7.wav"), preload("res://Sounds/Text/txt8.wav"),
preload("res://Sounds/Text/txt9.wav"), preload("res://Sounds/Text/txt10.wav"), preload("res://Sounds/Text/txt11.wav"),
preload("res://Sounds/Text/txt12.wav"), preload("res://Sounds/Text/txt13.wav"), preload("res://Sounds/Text/txt14.wav"),
preload("res://Sounds/Text/txt15.wav"),preload("res://Sounds/Text/txt16.wav"),preload("res://Sounds/Text/txt17.wav")]
var page_sound = [preload("res://Sounds/Page/page1.wav"), preload("res://Sounds/Page/page2.wav"), preload("res://Sounds/Page/page3.wav")]
var sound_time = 0
var sound_next = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if color == "yellow":
		$Control/ColorRect.color = Color(0.925, 0.914, 0.42)
	if color == "blue":
		$Control/ColorRect.color = Color(0.53, 0.978, 0.926)
	if color == "pink":
		$Control/ColorRect.color = Color(0.993, 0.839, 0.885)
	if color == "rand":
		$Control/ColorRect.color = gen_random_choice([Color(0.925, 0.914, 0.42), Color(0.53, 0.978, 0.926), Color(0.993, 0.839, 0.885)])
	
	$Control.position.y = $Control.position.y - position_offset
	$AudioStreamPlayer.stream = page_sound.pick_random()
	$AudioStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
#fade in anim
	if fade_out == false:
		if opacity <= 1:
			opacity += opacity_speed
			$Control.modulate.a = opacity
			$Control.position.y += position_offset/(1/opacity_speed)

	if opacity >= 1:
	#writing in the text
		if char_cur <= text.length():
			char_cur += char_spd
			sound_time += 1
			if sound_time >= sound_next:
				var sound_spd = 12
				sound_next += sound_spd
				$AudioStreamPlayer.stream = text_sound.pick_random()
				$AudioStreamPlayer.play()
			var text_cur = text.substr(0, char_cur)
			$Control/ColorRect/RichTextLabel.text = text_cur
			pass
	
	if Input.is_action_just_pressed("m_left"):
		fade_out = true
		$AudioStreamPlayer.stream = page_sound.pick_random()
		$AudioStreamPlayer.play()
	
	if fade_out == true:
		opacity-= opacity_speed
		$Control.modulate.a = opacity
		$Control.position.y -= position_offset/(1/opacity_speed)

		if opacity == 0:
			self.queue_free()
			
func gen_random_choice(choices):
	randomize() # Should probably put randomize() outside,
					# since it only needs to be called once per game
	return choices[randi() % choices.size() -1]
