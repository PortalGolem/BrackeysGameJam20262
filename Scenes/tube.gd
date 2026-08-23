extends Node3D

var position_goal_x = 0.00
var position_goal_y = 0.00

var open = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var speed = 10
	#take in your inputs!
	if Input.is_action_pressed("m_left"):
		position_goal_x = mouse_pos.x
		position_goal_y = mouse_pos.y
	print(mouse_pos)
	if Input.is_action_just_pressed("m_right"):
		open = !open

	#move towards mouse position slowly
	position.x = move_toward(position.x, position_goal_x, speed)
	position.y = move_toward(position.y, position_goal_y, speed)
	pass
