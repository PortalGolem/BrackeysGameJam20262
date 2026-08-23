class_name Item

extends Node3D

var grabbed := false
var itemTouched := false
var movementInput := Vector2.ZERO
@export var sensitivity_ := .1
signal inspectObject
signal dropObject(position)

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		movementInput += event.relative

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("m_left") and itemTouched:
		grabbed = true
	if Input.is_action_just_pressed("m_right") and itemTouched:
		dropItem()
		inspectObject.emit()
	if Input.is_action_just_released("m_left"):
		dropItem()
	if grabbed:
		position.x += movementInput.x * sensitivity_
		position.z += movementInput.y * sensitivity_
	movementInput = Vector2.ZERO
	
	
func dropItem():
	grabbed = false
	dropObject.emit(position)

func _on_mouse_entered() -> void:
	itemTouched = true


func _on_mouse_exited() -> void:
	itemTouched = false
