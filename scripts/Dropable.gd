class_name Drop

extends Node3D

signal trigger_dropped_function(object:Node3D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("body" + str(body))
	if body is Item and body.has_signal("dropObject"):
		body.dropObject.connect(_object_dropped_in_area)
		

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Item and body.dropObject.is_connected(_object_dropped_in_area):
		body.dropObject.disconnect(_object_dropped_in_area)

func _object_dropped_in_area(object:Node3D) -> void:
	trigger_dropped_function.emit(object)
