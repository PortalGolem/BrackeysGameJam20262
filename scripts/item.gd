class_name Item

extends Node3D

var grabbed := false
var itemTouched := false
var movementInput := Vector2.ZERO
@export var sensitivity_ := .1
signal inspectObject
signal dropObject(object:Node3D)
@export var canPutInCyl := false
@export var minimumMoveDistance := .1
var distanceMovedThusFar:float

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		movementInput += event.relative

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("m_left") and itemTouched:
		grabbed = true
	if Input.is_action_just_pressed("m_right") and itemTouched:
		if grabbed:
			dropItem()
		inspectObject.emit()
	if Input.is_action_just_released("m_left"):
		dropItem()
	if grabbed:
		position.x += movementInput.x * sensitivity_
		position.z += movementInput.y * sensitivity_
		distanceMovedThusFar += movementInput.length()
	movementInput = Vector2.ZERO
	
func dropItem():
	grabbed = false
	if distanceMovedThusFar > minimumMoveDistance / sensitivity_:
		dropObject.emit(self)
	distanceMovedThusFar = 0

func _on_mouse_entered() -> void:
	itemTouched = true


func _on_mouse_exited() -> void:
	itemTouched = false
