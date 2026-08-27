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
var trueYpos:float
var isFirstGrab := true
var actualAngleAdjustment
var usedBackboard := false

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		var camera = get_viewport().get_camera_3d()
		var newPosition:Vector3 = find_point_on_plane_with_ray(tablePlane, camera.project_ray_origin(event.position), camera.project_ray_normal(event.position))
		var otherNewPosition:Vector3 = find_point_on_plane_with_ray(Plane(Vector3(boundsBottomRight.x, tablePlane.d, boundsBottomRight.y),
				Vector3(-boundsBottomRight.x, tablePlane.d, boundsBottomRight.y),
				Vector3(boundsBottomRight.x, tablePlane.d - 1, boundsBottomRight.y - actualAngleAdjustment)),
				camera.project_ray_origin(event.position), camera.project_ray_normal(event.position))
		if newPosition.distance_to(camera.position) < otherNewPosition.distance_to(camera.position):
			var delta:Vector3
			if not usedBackboard:
				delta = newPosition - lastMousePosition
			else:
				delta = Vector3(newPosition.x - lastMousePosition.x, 0, lastMousePosition.z)
			lastMousePosition = Vector3(newPosition.x, 0, newPosition.z)
			movementInput += Vector2(delta.x, delta.z)
			usedBackboard = false
		else:
			otherNewPosition = Vector3(otherNewPosition.x, 0, -otherNewPosition.y)
			var delta:Vector3
			if not usedBackboard:
				delta = otherNewPosition - Vector3(lastMousePosition.x, 0, -lastMousePosition.y)
			else:
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
			isFirstGrab = false
	if Input.is_action_just_pressed("m_right") and itemTouched:
		if grabbed:
			dropItem()
		inspectObject.emit()
	if grabbed:
		positionFlat += movementInput
		positionFlat = Vector2(positionFlat.x,clamp(positionFlat.y, boundsBottomRight.y - backboardHeight, boundsTopLeft.y))
		global_position.x = clamp(positionFlat.x, boundsTopLeft.x, boundsBottomRight.x)
		global_position.z = max(positionFlat.y, boundsBottomRight.y)
		global_position.y = trueYpos
		if (positionFlat.y < boundsBottomRight.y):
			global_position.y -= positionFlat.y - boundsBottomRight.y
			global_position.z -= (positionFlat.y - boundsBottomRight.y) * actualAngleAdjustment
		distanceMovedThusFar += movementInput.length()
		if Input.is_action_just_released("m_left"):
			dropItem()
	movementInput = Vector2.ZERO
	
	
func dropItem():
	grabbed = false
	global_position.y = trueYpos
	print("ypos is" + str(trueYpos))
	positionFlat = Vector2(global_position.x, global_position.z)
	print("DroppedInto")
	if distanceMovedThusFar > minimumMoveDistance:
		print("DroppedInto!")
		dropObject.emit(self)
	distanceMovedThusFar = 0

func _on_mouse_entered() -> void:
	itemTouched = true


func _on_mouse_exited() -> void:
	itemTouched = false

func find_point_on_plane_with_ray(plane:Plane, rayOrigin, rayDirection):
	var planeOrigin = plane.normal * plane.d
	var denom = plane.normal.dot(rayDirection)
	if denom != 0:
		var Hd = (planeOrigin - rayOrigin).dot(plane.normal) / denom
		return Hd * rayDirection + rayOrigin
	else:
		return 0
