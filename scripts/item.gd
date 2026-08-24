class_name Item

extends Node3D

var grabbed := false
var itemTouched := false
var movementInput := Vector2.ZERO
var actualMovement := Vector2.ZERO
@export var sensitivity_ := .1
signal inspectObject
signal dropObject(object:Node3D)
@export var canPutInCyl := false
@export var minimumMoveDistance := .1
var distanceMovedThusFar:float
var lastMousePosition:Vector3
@export var tablePlane:Plane

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		var camera = get_viewport().get_camera_3d()
		var newPosition:Vector3 = find_point_on_plane_with_ray(tablePlane, camera.project_ray_origin(event.position), camera.project_ray_normal(event.position))
		var delta = newPosition - lastMousePosition
		lastMousePosition = newPosition
		movementInput += Vector2(delta.x, delta.z)

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
		position.x += movementInput.x
		position.z += movementInput.y
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

func find_point_on_plane_with_ray(plane:Plane, rayOrigin, rayDirection):
	var planeOrigin = plane.normal * plane.d
	var denom = plane.normal.dot(rayDirection)
	if denom != 0:
		var Hd = (planeOrigin - rayOrigin).dot(plane.normal) / denom
		return Hd * rayDirection + rayOrigin
	else:
		return 0
