extends Control

var selection = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#keep track of what we have selected
	if Input.is_action_just_pressed("ui_down") == true:
		selection += 1
	if Input.is_action_just_pressed("ui_up") == true:
		selection -= 1
	if selection > 3:
		selection = 3
	if selection < 1:
		selection = 1
	set_selection()
	
	if Input.is_action_just_pressed("ui_confirm") == true:
		if selection == 1:
			get_tree().change_scene_to_file("res://Scenes/pop_up.tscn")
		if selection == 2:
			get_tree().change_scene_to_file("res://SettingsMenu.tscn")
		if selection == 3:
			get_tree().quit()
	
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
