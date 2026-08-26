extends Node3D

@export var wiggleCenter := Vector2.ZERO
@export var upWiggleFactor := 1.0
@export var leftWiggleFactor := 1.0
@export var rightWiggleFactor := 1.0
@export var downWiggleFactor := 1.0
var currentWiggle := Vector2.ZERO
var startingRotation:Basis

func _ready() -> void:
	startingRotation = basis

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse = event.position
		var screenSize := get_viewport().get_visible_rect().size
		currentWiggle = -Vector2(mouse.y / screenSize.y, mouse.x / screenSize.x)
		currentWiggle.x += wiggleCenter.y
		currentWiggle.y += wiggleCenter.x
		if currentWiggle.x > 0:
			currentWiggle.x *= upWiggleFactor
		else:
			currentWiggle.x *= downWiggleFactor
		if currentWiggle.y > 0:
			currentWiggle.y *= rightWiggleFactor
		else:
			currentWiggle.y *= leftWiggleFactor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	basis = startingRotation
	rotate_x(currentWiggle.x)
	rotate_y(currentWiggle.y)
	
