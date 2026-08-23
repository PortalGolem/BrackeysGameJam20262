class_name Item

extends Node3D

var grabbed := false
var itemTouched := false
var movementInput := Vector2.ZERO
@export var sensitivity_ := .1

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		movementInput = event.relative

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("m_left") and itemTouched:
		grabbed = true
	if Input.is_action_just_released("m_left"):
		grabbed = false
	if grabbed:
		position += Vector3(movementInput.x, 0, movementInput.y) * sensitivity_
		print(Vector3(movementInput.x, 0, movementInput.y) * sensitivity_ )


func _on_mouse_entered() -> void:
	itemTouched = true


func _on_mouse_exited() -> void:
	itemTouched = false
