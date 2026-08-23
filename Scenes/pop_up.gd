
extends CanvasLayer

var char_spd = 0.04
var char_cur = 0
@export var text = "\n\n\nHey Dan! Could you send this over to Stacy upstairs?\n\n Best, \n Nathan"

var opacity = 0
var opacity_speed = 0.001
var position_offset = 80
var fade_out = false

var color = "yellow"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if color == "yellow":
		$Control/ColorRect.color = Color(0.925, 0.914, 0.42)
	if color == "blue":
		$Control/ColorRect.color = Color(0.53, 0.978, 0.926)
	if color == "pink":
		$Control/ColorRect.color = Color(0.993, 0.839, 0.885)
	
	$Control.position.y = $Control.position.y - position_offset

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
#fade in anim
	if fade_out == false:
		if opacity <= 1:
			opacity += opacity_speed
			$Control.modulate.a = opacity
			$Control.position.y += position_offset/(1/opacity_speed)

	if opacity >= 1:
	#writing in the text
		char_cur += char_spd
		var text_cur = text.substr(0, char_cur)
		$Control/ColorRect/RichTextLabel.text = text_cur
		pass
	
	if Input.is_action_just_pressed("m_left"):
		fade_out = true
	
	if fade_out == true:
		opacity-= opacity_speed
		$Control.modulate.a = opacity
		$Control.position.y -= position_offset/(1/opacity_speed)
		if opacity == 0:
			self.queue_free()
