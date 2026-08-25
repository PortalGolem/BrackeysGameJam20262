extends Node3D

@export var upWiggleFactor := 1.0
@export var sideWiggleFactor := 1.0
var currentWiggle := Vector2.ZERO
var startingRotation:Basis

func _ready() -> void:
	startingRotation = basis

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse = event.position
		var screenSize := get_viewport().get_visible_rect().size
		currentWiggle = -Vector2((mouse.x / screenSize.x - .5) * sideWiggleFactor, (mouse.y / screenSize.y - .5) * upWiggleFactor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	basis = startingRotation
	rotate_x(currentWiggle.y)
	rotate_y(currentWiggle.x)
	
