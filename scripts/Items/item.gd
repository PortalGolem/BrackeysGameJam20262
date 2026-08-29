class_name Item

extends Node3D

var grabbed := false
var itemTouched := false
var movementInput := Vector2.ZERO
var actualMovement := Vector2.ZERO
signal inspectObject
signal dropObject(object:Node3D)
@export var canPutInCyl := false
@export var minimumMoveDistance := .01
var distanceMovedThusFar:float
var lastMousePosition:Vector3
@export var tablePlane:Plane
var positionFlat:Vector2
@export var boundsTopLeft:Vector2
@export var boundsBottomRight:Vector2
@export var backboardHeight:float
@export var backboardTilt:float
@export var boundsLeftExtention:float
@export var boundsRightExtention:float
@export var grabbedOffset:float
var trueYpos:float
var isFirstGrab := true
var actualAngleAdjustment
var usedBackboard := false

signal pickUpItem(item:Item)

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		var camera = get_viewport().get_camera_3d()
		var newPositionGoal = tablePlane.intersects_ray( camera.project_ray_origin(event.position), camera.project_ray_normal(event.position))
		var newPosition:Vector3
		if newPositionGoal != null:
			newPosition = newPositionGoal
		else:
			newPosition = Vector3.INF
		var otherNewPositionGoal = Plane(Vector3(boundsBottomRight.x, tablePlane.d, boundsBottomRight.y),
				Vector3(-boundsBottomRight.x, tablePlane.d, boundsBottomRight.y),
				Vector3(boundsBottomRight.x, tablePlane.d - 1, boundsBottomRight.y - actualAngleAdjustment)).intersects_ray(
				camera.project_ray_origin(event.position), camera.project_ray_normal(event.position))
		var otherNewPosition:Vector3
		if otherNewPositionGoal != null:
			otherNewPosition = otherNewPositionGoal
		else:
			otherNewPosition = Vector3.INF
		
		if (newPosition == Vector3.INF and otherNewPosition == Vector3.INF):
			return
		
		if newPosition.distance_to(camera.position) < otherNewPosition.distance_to(camera.position):
			var delta:Vector3
			delta = newPosition - lastMousePosition
			lastMousePosition = Vector3(newPosition.x, 0, newPosition.z)
			movementInput += Vector2(delta.x, delta.z)
			usedBackboard = false
		else:
			otherNewPosition = Vector3(otherNewPosition.x, 0, -otherNewPosition.y)
			var delta:Vector3

			delta = otherNewPosition - lastMousePosition
			lastMousePosition = Vector3(otherNewPosition.x, 0, otherNewPosition.z)
			movementInput += Vector2(delta.x, delta.z)
			usedBackboard = true
		

func _ready() -> void:
	actualAngleAdjustment = backboardTilt/45


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("m_left") and itemTouched:
		grabbed = true
		if isFirstGrab:
			positionFlat = Vector2(global_position.x, global_position.z)
			trueYpos = global_position.y
			pickUpItem.emit(self)
			isFirstGrab = false
	if Input.is_action_just_pressed("m_right") and itemTouched:
		if grabbed:
			dropItem()
		inspectObject.emit()
	if grabbed:
		positionFlat += movementInput
		var tempPositionFlat = Vector2(clamp(positionFlat.x, boundsTopLeft.x - boundsLeftExtention, boundsBottomRight.x + boundsRightExtention) ,clamp(positionFlat.y, boundsBottomRight.y - backboardHeight, boundsTopLeft.y))
		global_position.x = tempPositionFlat.x
		global_position.z = max(tempPositionFlat.y, boundsBottomRight.y)
		global_position.y = trueYpos
		if (positionFlat.y < boundsBottomRight.y):
			global_position.y -= tempPositionFlat.y - boundsBottomRight.y
			global_position.z -= (tempPositionFlat.y - boundsBottomRight.y) * actualAngleAdjustment
		global_position.y += grabbedOffset
		distanceMovedThusFar += movementInput.length()
		if Input.is_action_just_released("m_left"):
			dropItem()
	movementInput = Vector2.ZERO
	
	
func dropItem():
	grabbed = false
	global_position.y = trueYpos
	global_position.x = clamp(positionFlat.x, boundsTopLeft.x, boundsBottomRight.x)
	positionFlat = Vector2(global_position.x, global_position.z)
	if distanceMovedThusFar > minimumMoveDistance:
		dropObject.emit(self)
	distanceMovedThusFar = 0

func _on_mouse_entered() -> void:
	itemTouched = true


func _on_mouse_exited() -> void:
	itemTouched = false
